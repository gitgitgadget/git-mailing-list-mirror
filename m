From: "Vegard Nossum" <vegard.nossum@gmail.com>
Subject: git-merge --no-commit commits
Date: Sun, 2 Dec 2007 17:57:38 +0100
Message-ID: <19f34abd0712020857m757c57cfr358a81e47f38fac8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 02 17:58:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iys94-0005By-FI
	for gcvg-git-2@gmane.org; Sun, 02 Dec 2007 17:58:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753686AbXLBQ5j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Dec 2007 11:57:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754536AbXLBQ5j
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Dec 2007 11:57:39 -0500
Received: from rv-out-0910.google.com ([209.85.198.185]:26380 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753686AbXLBQ5i (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Dec 2007 11:57:38 -0500
Received: by rv-out-0910.google.com with SMTP id k20so2404461rvb
        for <git@vger.kernel.org>; Sun, 02 Dec 2007 08:57:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=/hNbQ48SpkmABpso596s35bWwPD4E94tm+c1szqbzMM=;
        b=o3ro6cW1AZCAjKjw7GO7uPAq4E1f7THhgVjyw7//bayfKLV13lPoH0ISqcOgqbMrM64XPfh2KFjnAuEhB7UjM8Z0Sg6muShAkWUlho1Hloc2/ujHDAO3AUJ4+eds+Ln0rFa1NRgBoor++Y41uzPxgN6ojo1iYSeNkxpS3MknXco=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=ti53GxC46y/A39cNJEya7ySbo8AfbrpcMn6FJ2aM1vWy6rfHFFUo4cGjQ8lne80z27QPmIQMVSRubi2ewUPSOn88snYYXrJRT9GplJ45bb5/5uZerS7fIfPtxBYDW5sPE3UP4CMpz3jiMnVTlCOAhFEtTDyfCqtqX0f3HD6bDGI=
Received: by 10.140.180.42 with SMTP id c42mr960899rvf.1196614658380;
        Sun, 02 Dec 2007 08:57:38 -0800 (PST)
Received: by 10.141.170.18 with HTTP; Sun, 2 Dec 2007 08:57:38 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66795>

Hi,

I am using git 1.5.3.4 and just did the following (v1 and v2 are
branches; v1 is a parent of v2):

git checkout v1
git merge --no-commit v2

It simply fast-forwarded AND committed even though I explicitly told
it not to. What gives?

Kind regards,
Vegard Nossum
