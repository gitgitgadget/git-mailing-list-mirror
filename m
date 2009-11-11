From: David Symonds <dsymonds@gmail.com>
Subject: Consensus on "Git"
Date: Wed, 11 Nov 2009 19:32:30 +1100
Message-ID: <ee77f5c20911110032r65a60653sfeef34e3de07d17e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Nov 11 09:32:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N88d3-0003Ru-0f
	for gcvg-git-2@lo.gmane.org; Wed, 11 Nov 2009 09:32:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755794AbZKKIc0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Nov 2009 03:32:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756909AbZKKIcZ
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Nov 2009 03:32:25 -0500
Received: from qw-out-2122.google.com ([74.125.92.26]:64180 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755719AbZKKIcZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Nov 2009 03:32:25 -0500
Received: by qw-out-2122.google.com with SMTP id 3so164470qwe.37
        for <git@vger.kernel.org>; Wed, 11 Nov 2009 00:32:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=IZsEoNv2Hn/YvXPk4a8G/drFdOCzDc8JTi/yoYoYTFk=;
        b=L6p493oxajsJ1q3ISOCe4BcoZee4oFf07G9I4z3Z/1MI2c+bDFTwdA2yfZC2fH45T9
         qyOX2sE42nilSpnVB525CtrLlfGirURwkCnJrrEpXuRltXzja4SP97uryqkxxZ9cPwGs
         uOBk+5dxRM5jpvlB/gWpe7GuUAjcCGuNtJl28=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=suyVyqwEgZ1EtP8nMlqrds5OcURZVyJBhAmkcwWqFOrdoCT2gWm5dOSKt8n64Xj4e+
         6a7PouFz5/Th80CaNl5qwu2byCiccWdRdpny/gwMXCuecIbXMbQUgQJ8+M7eG4CTsnDg
         bebWZDz7jQQmQVm5oPJ562lMcrELXIOrRrUbE=
Received: by 10.229.116.140 with SMTP id m12mr181721qcq.54.1257928350772; Wed, 
	11 Nov 2009 00:32:30 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132620>

Hi folks,

Is there consensus on "Git" being the standard capitalisation, versus
"GIT"? I only really see "git" and "Git" on the mailing list and in
most external documentation and websites (e.g. git-scm.com and
github.com), but git's source tells a different picture:

$ cat *.[ch] | egrep -o '\bG[Ii][Tt]\b' | sort | uniq -c
  36 GIT
   7 Git
$ cat Documentation/* 2> /dev/null | egrep -o '\bG[Ii][Tt]\b' | sort | uniq -c
 284 GIT
 155 Git



Dave.
