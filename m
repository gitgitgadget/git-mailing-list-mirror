From: Reynald Borer <reynald.borer@gmail.com>
Subject: git-svn checksum mismatch
Date: Thu, 4 Nov 2010 14:45:40 +0100
Message-ID: <AANLkTiki9itV6TTsu1=UOxTb8tHUMdm=cJAQnsjPbnp9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 04 14:46:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PE08m-0001P2-Ls
	for gcvg-git-2@lo.gmane.org; Thu, 04 Nov 2010 14:46:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751454Ab0KDNqD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Nov 2010 09:46:03 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:54630 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751400Ab0KDNqB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Nov 2010 09:46:01 -0400
Received: by yxk8 with SMTP id 8so1384130yxk.19
        for <git@vger.kernel.org>; Thu, 04 Nov 2010 06:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:from:date
         :message-id:subject:to:content-type;
        bh=0HT9PoX8J/fkJqhVHiHDGUYMjx3cTsl1TNno/TnoYaw=;
        b=rxLV/tQxzUjQjWHDgrqUmDKRx7iFPimSzhDAZzsltu4hl6yH5Dcf3831VvPGMTj20D
         Vkq2+s3ki7Q8hNXgMJEeGUeQ5gsdo2VSRfbxy9WchyILQ7YnOrWoBTrCd5ycQAGEtKDu
         cC8M3Us8sZiNJjo4I/vO2XwpfJOC66cQyVo1Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=EzcJd7+LD/+qYbFZ2rrOjl0+DPsOm418BWjsTmYDEmkReITkWVDazbAFxHCI/ZuTra
         U3qEeGzFIVbT9NiGYDRQby+IBU++Wn63QCQAeA9xleUpbEYFi1+dRmRNX168Pm9DTEj9
         etgxjw3TkvU1SPPBXUoL0SxUYP5O6Iy0dqjOk=
Received: by 10.42.204.79 with SMTP id fl15mr295740icb.514.1288878360765; Thu,
 04 Nov 2010 06:46:00 -0700 (PDT)
Received: by 10.231.11.205 with HTTP; Thu, 4 Nov 2010 06:45:40 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160718>

Hello all,

I'm using git with a subversion repository and am experiencing the
well known checksum mismatch problem when I try to fetch from our
repository:

r5289 = f110f54fc3a488639e8b645438c4538e7785228f (refs/remotes/trunk)
Checksum mismatch:
app/tnin/model/src/main/resources/etc/sql/migration_scripts/STX-12229.sql
expected: c70c72fe170781e3279c37d0de637a55
    got: f90d31e1fd8e0f88569f87eb087c06c9

I have already been trying to diagnose this issue and have found
nothing to fix it so far. I have tried to do a checkout with an svn
client of the revision 5289, the previous one and then do an update,
everything works fine when doing so.

The only thing I see that may cause this issue is that the file has
special svn property (eol-style=native).

I am using git version version 1.7.2.3 (using svn 1.6.13).

Thanks in advance for your help,
Reynald Borer
