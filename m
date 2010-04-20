From: Anand Kumria <wildfire@progsoc.org>
Subject: [bug] git svn clone failing with invalid diff stream
Date: Tue, 20 Apr 2010 16:48:23 +1000
Message-ID: <m2q971f65791004192348zab4adf13p93a6a4c1d60f9c16@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 20 08:48:51 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O47GM-0005UU-TX
	for gcvg-git-2@lo.gmane.org; Tue, 20 Apr 2010 08:48:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753634Ab0DTGsp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Apr 2010 02:48:45 -0400
Received: from mail-iw0-f197.google.com ([209.85.223.197]:55261 "EHLO
	mail-iw0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753474Ab0DTGsp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Apr 2010 02:48:45 -0400
Received: by iwn35 with SMTP id 35so2863077iwn.21
        for <git@vger.kernel.org>; Mon, 19 Apr 2010 23:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:from:date
         :x-google-sender-auth:received:message-id:subject:to:content-type;
        bh=m5tTHF1VdgN1MsIgBXZJ6W2CssJM/oE6ivn+CVBjr7g=;
        b=TvIdyPZJS3mHR/kYaaTYKEJmEMBM1xMZY09rpjQX6Pf7tH/qf59nYCVydfdr8BcJYs
         Cwbz7/yOClBRH8U+gVhHNygzPigkvJYMD0I3lj4J4iWZyhN76Ug8JzHNrDMumCd+MZ0p
         a/ul7OXw63D5IGF+aaVVEXmwSvMhiht5mZtsA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:from:date:x-google-sender-auth:message-id
         :subject:to:content-type;
        b=f2U67jYBtDPr0vKQeszBl8ymC/0Y6YJXqzMuednvPo880E0Z0duvxVPoev7RqWYsQ7
         unuZM3TqPCqqnzKgYYoZj5es/pu3zo3XYIDZP7QUN8wir/boVlc3hUnpDAYfbHxDyV45
         jV87XqRsLgnwITinZ76pIWh6e6etm9QUxGqOg=
Received: by 10.231.190.193 with HTTP; Mon, 19 Apr 2010 23:48:23 -0700 (PDT)
X-Google-Sender-Auth: 4a81f0466f1a019b
Received: by 10.231.173.129 with SMTP id p1mr2242056ibz.85.1271746124054; Mon, 
	19 Apr 2010 23:48:44 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145351>

Hi,

Using both git 1.7.0.4 and 1.5.6.5 I am unable to clone the Subversion
respository for Serendipity.

URL: svn://svn.berlios.de/serendipity

It fails consistently on r1341 with:

(1.5.6.5): Svndiff data contains invalid instruction: Invalid diff
stream: [tgt] insn 335 starts beyond the target view position at
/usr/bin/git-svn line 3856

and

(1.7.0.4): Svndiff data contains invalid instruction: Invalid diff
stream: [tgt] insn 335 starts beyond the target view position at
/usr/lib/git-core/git-svn line 5047

On, seemingly UTF-8 encoded data. Any ideas / pointers would be appreciated.

Regards,
Anand
