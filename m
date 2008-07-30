From: "Mikael Magnusson" <mikachu@gmail.com>
Subject: Re: cvs diff -l equivalent?
Date: Wed, 30 Jul 2008 22:57:55 +0200
Message-ID: <237967ef0807301357l60dfb5b7y63a357c4b5c2c23@mail.gmail.com>
References: <20080730082030.GA12555@cuci.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Stephen R. van den Berg" <srb@cuci.nl>
X-From: git-owner@vger.kernel.org Wed Jul 30 22:59:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOIl8-0002Rn-Am
	for gcvg-git-2@gmane.org; Wed, 30 Jul 2008 22:58:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751816AbYG3U56 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jul 2008 16:57:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751813AbYG3U56
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jul 2008 16:57:58 -0400
Received: from ik-out-1112.google.com ([66.249.90.183]:27490 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751496AbYG3U55 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jul 2008 16:57:57 -0400
Received: by ik-out-1112.google.com with SMTP id c28so185055ika.5
        for <git@vger.kernel.org>; Wed, 30 Jul 2008 13:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=QSBpquMbRYvFhhqhWIhr6dNjt+WuXYtfpUf+P+5rZwA=;
        b=krwHD1fhRSyRMkC3vkD/rHNbaxNr3JHy6mbq1/7EDLMhuTbHE8c/78rlQMKSFVWrLi
         oJlY607YIE7gSLoXnnzTzy3VHKoDz7mwb2KY13LWpU9fvoAegxeFwlvOSRZzBuWnU2dU
         P5PoH0kNO8DelGJYVMCHemkjMzJZK27wQpPGY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=olPve6K2VyDGLqsgwyE4L/weHJJ+vwHloqz2tgFESgm2E6HpPc5/VTEGhfYdMIpi7V
         VXPeFUKeb67RfCOsJ2bRXTOzEzXX2DNmUy6PtACJGWByvH2bIWewuKhiAhJxkAI5ID7g
         eAYR8I2cMDcvznur1x3ppVjHIwHQKBlSMbZeM=
Received: by 10.210.16.20 with SMTP id 20mr9870012ebp.134.1217451475608;
        Wed, 30 Jul 2008 13:57:55 -0700 (PDT)
Received: by 10.210.73.14 with HTTP; Wed, 30 Jul 2008 13:57:55 -0700 (PDT)
In-Reply-To: <20080730082030.GA12555@cuci.nl>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90854>

2008/7/30 Stephen R. van den Berg <srb@cuci.nl>:
> Someone popped this question on me.  The closest I got was:
>
>   git diff .
>
> But that still recurses.  Any solutions without patching?

Another option than the ones suggested:
git diff|filterdiff -x '*/*/*'

filterdiff is available from the "patchutils" package.

-- 
Mikael Magnusson
