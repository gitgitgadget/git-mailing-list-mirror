From: "Bruce Korb" <bruce.korb@gmail.com>
Subject: I've tried to read the manuals, but "git pull" just won't work
Date: Sat, 2 Aug 2008 21:58:19 -0700
Message-ID: <668c430c0808022158s56e22c56t3bbd61eef59d7b32@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 03 06:59:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPVgg-0001Ua-FD
	for gcvg-git-2@gmane.org; Sun, 03 Aug 2008 06:59:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751595AbYHCE6V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Aug 2008 00:58:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751516AbYHCE6V
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Aug 2008 00:58:21 -0400
Received: from yw-out-2324.google.com ([74.125.46.31]:16595 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751470AbYHCE6U (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Aug 2008 00:58:20 -0400
Received: by yw-out-2324.google.com with SMTP id 9so932785ywe.1
        for <git@vger.kernel.org>; Sat, 02 Aug 2008 21:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=N1ZS5njt9Uio5cINB/r6J7OvrpduRItLaEE8n4H5bZ0=;
        b=c+ppA7ba9/zItJsoBe0QoVR7nhJOgGI1S8EWK2bAD0j5aaue1PmhbqZfd/MnDsQixU
         kuhfkQZe5HjzZzYCdfhwk/bUcH7wYzaBy26b/7666HAUFlcg83eqy2XG1zi6URmFQKAi
         s6gUG4gbDGFDYzqHBLJ/aVjyctc3GBaERwiSw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=BQ9BLDgOQ/aglMwtBGkh9VRKONdzXBoVXG4KNnSSEW3wwORA+GGCDooHTv4eFygL+X
         qSkE+brmGUWyeGmLZtVpCEktuFwHjO1ejrg0ShdSHRDT6w6AOJ4WK+8w9ymcjoZdkjs3
         y8+Ta4jh8zuqGJukvDro4NIFXySIy3aAas0hU=
Received: by 10.151.12.4 with SMTP id p4mr5998580ybi.132.1217739499510;
        Sat, 02 Aug 2008 21:58:19 -0700 (PDT)
Received: by 10.150.57.4 with HTTP; Sat, 2 Aug 2008 21:58:19 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91205>

Sorry, I don't know where else to turn.
I've modified my local copy of ChangeLog and my "git pull" says, "Oh, oh!
You'd overwrite your changes" and refuses to pull.  I tried
"git reset HEAD  ChangeLog", but it says all sorts of crazy things
that make no sense and I'm still stuck.  I know I can fix this:
pull my edits into a patch, throw away my repository, clone a fresh
copy.  There has to be a better way.  The better  way is just too
obtuse to figure out.....Help, please?  Thank you.
