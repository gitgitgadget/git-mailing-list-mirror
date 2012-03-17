From: =?ISO-8859-1?Q?R=E9mi_JANOT?= <r.janot@gmail.com>
Subject: Git push behavior
Date: Sat, 17 Mar 2012 09:28:21 +0100
Message-ID: <CACOHuxUESU4t8ZDhxMuXb1b3TsOqKr8Zpr40n+_tQGUiSLO1iw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 17 09:29:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S8p12-0006di-4q
	for gcvg-git-2@plane.gmane.org; Sat, 17 Mar 2012 09:29:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753009Ab2CQI2p convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 17 Mar 2012 04:28:45 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:62838 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752134Ab2CQI2n convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 17 Mar 2012 04:28:43 -0400
Received: by iagz16 with SMTP id z16so6585831iag.19
        for <git@vger.kernel.org>; Sat, 17 Mar 2012 01:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type
         :content-transfer-encoding;
        bh=HkdN17ZsxZtywiCufeg33hNR4ZTKARUFSMgUyRt3H6g=;
        b=Mvk2z/+GBewehrSqK7XKVPJj6RP1x+HuNXizII0l32rANcwnbE/3p4je7/DCSrbMUL
         y+/IGTpza5nCZwtevet8uoQR8UldnKwlXZtk/R7d4Ptn+3uWy68IjCAagQZWpUOMwNhO
         nJlLROX9BHvHE7omQuhVl9i8HC8ZLJTuZjyM8L4TfZ7Zv0jezoMutQLWA7UhI69l4dIp
         /DoZTaPco09NaV2hjCRkouby1qu/3iVRC5y2KmtPrwND0G83jDKXyQjMx7MPkoavp/SS
         qaExEFIhJyfjxYLZV9Fl8n+M9UJUNc8nY91qL7e4OuAQaL9IfIwAtVEvogTHqk5VIGXS
         56sg==
Received: by 10.60.6.164 with SMTP id c4mr6452761oea.43.1331972922495; Sat, 17
 Mar 2012 01:28:42 -0700 (PDT)
Received: by 10.60.54.10 with HTTP; Sat, 17 Mar 2012 01:28:21 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193311>

Hi all,

As we use git in my company we already have problems with someone
doing a git push -f (thinking pushing only his branch) and so rollback
the master branch..... That's so dangerous

=46or us the better default value should be "current".

Thanks!

R=E9mi JANOT
