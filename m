From: Jeenu V <jeenuv@gmail.com>
Subject: Update index with a pickaxed diff
Date: Wed, 29 Dec 2010 17:03:43 +0530
Message-ID: <AANLkTi=BJ-8FaN+rk6_74mgM0PVzVP5uhV3aO1A3jUS3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 29 12:34:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PXuIl-0002cJ-CT
	for gcvg-git-2@lo.gmane.org; Wed, 29 Dec 2010 12:34:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752141Ab0L2LeW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Dec 2010 06:34:22 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:56356 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751604Ab0L2LeV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Dec 2010 06:34:21 -0500
Received: by wyb28 with SMTP id 28so10023167wyb.19
        for <git@vger.kernel.org>; Wed, 29 Dec 2010 03:34:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:from:date
         :message-id:subject:to:content-type;
        bh=vSFVip1+9ZPupTO5sR2abFRhTd0YM7uKwibhPlEkWWc=;
        b=o8jpp+umQz2fTyyCPKBarxUc1cjG2308sXtF2U42AgKHdqHyerMyg23YTXkPzwkMNb
         nOYM1YvwL7E7E5+qUvM6Jcdh+JDYZkKFP2lZhnpn+Tnkz61FPALn4onWTulfguwMSux4
         PhuyvfhoK+xuUcGNtKdsmSY9zkyU+oVkB3EEA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=DHgmBE/SmL+Vtl91nSQ5J8Lwrjlih7Z5g0tDf0J/BmLY2+YHDhGKoQ/OcYpwTz1LSQ
         S87C2MtNWgpVXinhtX8esv3RmiaStFFB0NaQKxBas7I/qrUWCZd7DC3ZMFz7eyCjNu7u
         Yal/MxrO/OFscBO4KVYzDS85DcLOs/YbuQdsQ=
Received: by 10.216.158.133 with SMTP id q5mr7683414wek.39.1293622453864; Wed,
 29 Dec 2010 03:34:13 -0800 (PST)
Received: by 10.216.254.166 with HTTP; Wed, 29 Dec 2010 03:33:43 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164308>

I'd like to know if there's a quick way of updating the index with the
output of 'git diff -S<expr>'. I find this useful if the change set
that I wanted to include results from, for example, a mass identifier
renaming. That would be easier, especially when my working directory
is already dirty with other changes, and I don't have to interactively
filter out change sets, other than those matching <expr>.

Thanks.

-- 
Jeenu
