From: "Francis Moreau" <francis.moro@gmail.com>
Subject: Why doesn't git-apply remove empty file
Date: Tue, 12 Aug 2008 18:17:56 +0200
Message-ID: <38b2ab8a0808120917h10f15c81v4d1f04c0174dc994@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 12 18:19:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSwaj-0003bw-1I
	for gcvg-git-2@gmane.org; Tue, 12 Aug 2008 18:19:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754601AbYHLQR6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Aug 2008 12:17:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754568AbYHLQR5
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Aug 2008 12:17:57 -0400
Received: from rv-out-0506.google.com ([209.85.198.234]:60853 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754560AbYHLQR4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Aug 2008 12:17:56 -0400
Received: by rv-out-0506.google.com with SMTP id k40so2857357rvb.1
        for <git@vger.kernel.org>; Tue, 12 Aug 2008 09:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=JwpI8SheEUjnWajue5rxM1mrs6Fjv60uDRnUCWE9MNY=;
        b=uCFXVAqedgHeyAuA4N4LNRb0a+pDH5X2PxxYqEdCEb9KzpV9PycR20g7rBsfqAMPdS
         3caxViIcH7A3/JTRaTh8La9XxQmFp+aLyCBKY+keBEuRaKa3EoVHEm1RFhiLHRgHLzRl
         NTrT3j/UF+oZWmY9DRsI+w4yddXJGLhYn+wXQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=aS/zak1qJ86pnlFmewkL+UdgIDUF+9hFOHvk+QCBo9O9Y+g2Pv++gvdvjYncZtfoQK
         t9OVLyZ6A5ee5Tim/v52q/EGa5ktSK+Q1rergZ4Ydi/2YsrTXTYDd/ux+LSIlcBmFdqP
         n0vWxYqXUEKDUdj7EVJ+UnMKDJur+Vqx5kqg4=
Received: by 10.141.71.8 with SMTP id y8mr4533101rvk.63.1218557876176;
        Tue, 12 Aug 2008 09:17:56 -0700 (PDT)
Received: by 10.140.170.16 with HTTP; Tue, 12 Aug 2008 09:17:56 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92110>

Hi,

Or at least has an option to do so ?

thanks
-- 
Francis
