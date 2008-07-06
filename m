From: "Mikael Magnusson" <mikachu@gmail.com>
Subject: Re: [ANNOUNCE] GIT 1.5.6.2
Date: Sun, 6 Jul 2008 16:54:00 +0200
Message-ID: <237967ef0807060754t4bf0ab8el7362e69aac4699b5@mail.gmail.com>
References: <7vy74fo9t4.fsf@gitster.siamese.dyndns.org>
	 <alpine.LNX.1.10.0807061444250.28765@fbirervta.pbzchgretzou.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org,
	linux-kernel@vger.kernel.org
To: "Jan Engelhardt" <jengelh@medozas.de>
X-From: git-owner@vger.kernel.org Sun Jul 06 16:55:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFVdl-0003Np-FS
	for gcvg-git-2@gmane.org; Sun, 06 Jul 2008 16:55:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757093AbYGFOyD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jul 2008 10:54:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756921AbYGFOyD
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Jul 2008 10:54:03 -0400
Received: from rv-out-0506.google.com ([209.85.198.234]:44714 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756793AbYGFOyA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jul 2008 10:54:00 -0400
Received: by rv-out-0506.google.com with SMTP id k40so2270514rvb.1
        for <git@vger.kernel.org>; Sun, 06 Jul 2008 07:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=pJaRS8/CHKG3DheMiSZM/TNCCePxzuNEiWdZnV/8jQU=;
        b=cKXvhX15wTbRgdM7n+OQRFGjKuXb1ESbdWJLjPljq5BcKLmIoAJpnDGeD4/Cye14LU
         VCmn7pUujwW/WvCOC8yNfx0hScGF+SfQUBMdfRsGzkJ/LjzR6DV/hcWPq4RCxYQJdNLl
         OHGCuKSzBlG0ZSQVggNQaMQKcWLOkZMUANVxs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=xv13hytG8uwnD4JIJinLYPlmD93Zw09IyQr+wmuJ7g826AlAjLeeal4+gXTWfBIdS9
         iGHT3Xo0XgGmyGJsJHrSBd+QCGT1nQbH/l+hVWlHtKbGW0aubJ/YjzkEygmDjBx1W0IZ
         OxarqHoajsh+B92953XEka8CYHBhtqZ6FnhDY=
Received: by 10.140.249.20 with SMTP id w20mr1646625rvh.189.1215356040311;
        Sun, 06 Jul 2008 07:54:00 -0700 (PDT)
Received: by 10.141.68.4 with HTTP; Sun, 6 Jul 2008 07:54:00 -0700 (PDT)
In-Reply-To: <alpine.LNX.1.10.0807061444250.28765@fbirervta.pbzchgretzou.qr>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87535>

2008/7/6 Jan Engelhardt <jengelh@medozas.de>:
>
> On Sunday 2008-07-06 07:34, Junio C Hamano wrote:
>>Junio C Hamano (9):
>>      Allow "git-reset path" when unambiguous
>>      diff --check: do not discard error status upon seeing a good line
>>      git-shell: accept "git foo" form
>>      GIT 1.5.4.6
>>      GIT 1.5.5.5
>>      Start draft release notes for 1.5.6.2
>>      Work around gcc warnings from curl headers
>>      Fix executable bits in t/ scripts
>>      GIT 1.5.6.2
>
> Three git versions?

I believe this is related to moving to the dash-less form of receive-pack et al.

-- 
Mikael Magnusson
