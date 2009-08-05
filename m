From: "G.zhen.ning" <g.zhen.ning@gmail.com>
Subject: what's wrong wtih my rebase? (git-svn)
Date: Wed, 5 Aug 2009 09:47:09 +0800
Message-ID: <44ceb8150908041847mbf7d238r60a59ee40ef6e232@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 05 03:47:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYVb5-0006q3-LP
	for gcvg-git-2@gmane.org; Wed, 05 Aug 2009 03:47:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933067AbZHEBrL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 4 Aug 2009 21:47:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933023AbZHEBrK
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Aug 2009 21:47:10 -0400
Received: from rv-out-0506.google.com ([209.85.198.232]:21939 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933021AbZHEBrJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Aug 2009 21:47:09 -0400
Received: by rv-out-0506.google.com with SMTP id f6so1346315rvb.1
        for <git@vger.kernel.org>; Tue, 04 Aug 2009 18:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=3rh5it2YsuPnHQQdnWl4HcZ8iI1etU1w3HwNqQybacA=;
        b=X+T9wKUa1w+6cUpgA0/dIa9z7ILkRRIkelinH6+zyVfWCur9zc5/tqMvOqmqOPFTZt
         IWMgmcw+EIz00k8kLMnPy+9qhyv7YImzlHVq1vq0P4X83JaHnUpRiwQnfQXNEzfATyHK
         jw05q81dYKulerCHu9KhIw3W7akDVkHSuju+8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=UoQRkPBKQdb6dBzja2bI3NNwpYhMBGY8cwM/s3dpRg10YvaV/hY3ttMksw1D/u3kg5
         SN5C9bbZyZR2PV8w0NbYix70BcaHkTLtBrpx4YOOcXdrYbawN1FwFtfFFYSgyFBGkLoP
         E4ipo6veRT0AZAdnmhdE2NbeEJbcPvmcbLFic=
Received: by 10.140.199.15 with SMTP id w15mr5824414rvf.147.1249436829872; 
	Tue, 04 Aug 2009 18:47:09 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124837>

git svn fetch
git svn rebase
git diff
vim my.html.erb                (resolve the conflict)
git rebase --continue

problem still there.

little programmer needs some help.
---------------------------
rebase refs/remotes/stream: command returned error: 1

nn@nn:~/forum$ git diff
diff --cc app/views/layouts/my.html.erb
index b6092da,ce476f3..0000000
--- a/app/views/layouts/my.html.erb
+++ b/app/views/layouts/my.html.erb
@@@ -42,7 -42,7 +42,11 @@@
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 <% end -%>
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 </ul>
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 <% else -%>
++<<<<<<< HEAD:app/views/layouts/my.html.erb
=A0+=A0=A0=A0=A0=A0=A0=A0=A0=A0 <span class=3D"nothing">nothing</span>
++=3D=3D=3D=3D=3D=3D=3D
+=A0=A0=A0=A0=A0=A0 <span class=3D"nothing">nothing</span>
++>>>>>>> add a nothing css style:app/views/layouts/my.html.erb
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 <% end -%>
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 </div>
=A0=A0=A0=A0=A0=A0=A0=A0=A0 </div>
nn@nn:~/forum$ vim app/views/layouts/my.html.erb
nn@nn:~/forum$ git rebase --continue
You must edit all merge conflicts and then
mark them as resolved using git add
nn@nn:~/forum$ git add .
nn@nn:~/forum$ git rebase --continue
Applying: add a nothing css style
No changes - did you forget to use 'git add'?
