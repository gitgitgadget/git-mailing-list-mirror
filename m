From: "Aneesh Kumar" <aneesh.kumar@gmail.com>
Subject: stg branch command failures.
Date: Wed, 10 Oct 2007 09:01:22 +0530
Message-ID: <cc723f590710092031w87511dfl6ee3b728375f0815@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>,
	catalin.marinas@gmail.com, kha@treskal.com
X-From: git-owner@vger.kernel.org Wed Oct 10 05:31:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IfSIH-0007VV-Or
	for gcvg-git-2@gmane.org; Wed, 10 Oct 2007 05:31:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750993AbXJJDbY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Oct 2007 23:31:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751009AbXJJDbY
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Oct 2007 23:31:24 -0400
Received: from rv-out-0910.google.com ([209.85.198.191]:38492 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750983AbXJJDbX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Oct 2007 23:31:23 -0400
Received: by rv-out-0910.google.com with SMTP id k20so67449rvb
        for <git@vger.kernel.org>; Tue, 09 Oct 2007 20:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=0PK47SepH4QiYNoG5VfvnR2yE5M6EYN9tmah2BeV0OE=;
        b=j0Ykp655agVJmvB3E1JijqIPU6k3yPMi2JRXEvzmVaoyZUgGljDPQJKRCO0RULU6fujQ+2MDZ/y9Rkjvopx3hPDxugK0+GZ2B67+ZPGMaCq2Bq75Nt/a3oskqaI+NYx2U5baEF5VKcwY3GxMxoaqJ3j50L89gJRYVXkLVscexYE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=hLT3h8HbXiPNPYMbqdNc0+sUi1Ao/0vQoJMQbwk9vQFr4hgHXc05hh1jUqXdGOrvPyhKQLZhrHFDtSbcehEczm7QRH/VW/Hrqz6ox6vJni7U3+Kt+NbxgigmvL5NW9IhACd586bA6sL4EqZ0RAdziyvziACaIBVy5dz9HzchU4A=
Received: by 10.114.52.1 with SMTP id z1mr236460waz.1191987082756;
        Tue, 09 Oct 2007 20:31:22 -0700 (PDT)
Received: by 10.114.240.11 with HTTP; Tue, 9 Oct 2007 20:31:22 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60460>

Hi,

Both the below commands doesn't work

stg branch --rename review test-large-file
stg branch -c review v2.6.23-rc9

It throws error
fatal: Needed a single revision

-aneesh
