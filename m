From: Aneesh Bhasin <contact.aneesh@gmail.com>
Subject: List of all tags on a branch/remote-repo
Date: Mon, 16 Feb 2009 16:59:12 +0530
Message-ID: <f662f0210902160329h2ad09ac3r13c64c1e41947e89@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 16 12:31:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZ1gu-0005RR-4i
	for gcvg-git-2@gmane.org; Mon, 16 Feb 2009 12:31:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752432AbZBPL3O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2009 06:29:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752283AbZBPL3O
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Feb 2009 06:29:14 -0500
Received: from rv-out-0506.google.com ([209.85.198.229]:18158 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752176AbZBPL3N (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2009 06:29:13 -0500
Received: by rv-out-0506.google.com with SMTP id g37so1519629rvb.1
        for <git@vger.kernel.org>; Mon, 16 Feb 2009 03:29:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=1cpaklOA0oRgYR8TgVpkn64dCiIBNBpjfM1bHuo3gJY=;
        b=ObF+0r7BOQDnoKG1T/oSZq1/lKipYfCIP6tn0C8f0To13qbYb87z2addqmvohGlzQ0
         TMWqdn2RfhymB+lU54/qNb/qPJMwDFnB1PcqH21QFivAScVPxTPIRHgJ5lAk4H4CgQwx
         jsGJyy8SLKsnZv4VTV7bhCF5QwyojJOWLc4cs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=RZe9gFu/r5vaSRcJv6TBSYqImppSsRnYcJRFm5Duy6JoAn9M4ByPJoCCnb6K9mZMM9
         Dkp/ux4BcdpjO4P2nwcQFygm5Zy8u+ZKi/MeVLKdtovQe8/60AMzsTyCfvfCgZoSUXj4
         Ra2TPxhMJd6NhtsB2HptEwGO5KeTPi/HGfzk0=
Received: by 10.140.171.18 with SMTP id t18mr2663695rve.10.1234783752776; Mon, 
	16 Feb 2009 03:29:12 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110171>

Hi All,

I have a small question. How do I see all the tags that exist on a
particular branch. eg, if I have two branches : B1 and B2 and B1 has
tags : T1_1, T1_2... and B2 branch has tags T2_1, T2_2... then if I
say :
>git tag
I will see all the tags (T1_1, T1_2, T2_1, T2_2...). How do I see just
the tags that exist on branch B2 ?? Is there a single command for it
or any other way of doing it ?

And extending this concept, if I add a remote tracking repo with the command :
>git remote add linux-2.6.25_DEV1 /home/DEV1//linux-2.6.25_DEV1/.git

then how do i see all the tags that existed in linux-2.6.25_DEV1
without showing all the tags in my git repo ??

Thanks in advance..

Regards,
Aneesh
