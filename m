From: "Sverre Hvammen Johansen" <hvammen@gmail.com>
Subject: Re: [RFC/PATCH] Fast forward strategies allow, never, and only
Date: Tue, 11 Mar 2008 21:51:41 -0800
Message-ID: <402c10cd0803112251n675ba7e8n96e2e18ee60ac5ed@mail.gmail.com>
References: <402c10cd0803101959q619efa86pbd501e5e2cc018c2@mail.gmail.com>
	 <m33aqxzknl.fsf@localhost.localdomain>
	 <402c10cd0803112124i2726c32m75b9353d902df320@mail.gmail.com>
	 <7v1w6g8s1w.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Jakub Narebski" <jnareb@gmail.com>, git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 12 06:52:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZJt1-0002yo-5L
	for gcvg-git-2@gmane.org; Wed, 12 Mar 2008 06:52:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751901AbYCLFvo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2008 01:51:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751890AbYCLFvo
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Mar 2008 01:51:44 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:33824 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751725AbYCLFvn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2008 01:51:43 -0400
Received: by fg-out-1718.google.com with SMTP id e21so2735817fga.17
        for <git@vger.kernel.org>; Tue, 11 Mar 2008 22:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=QeouXke17voMZLxefDNTFNfL5HH8xpLagpIQ+/r0Q1g=;
        b=WpWb+19Mht9T3KL7jDDyAGnBGpCTj35YeDSy/ujECuuJNCKjWYqkqsP2+lUPJ+JK6gzl0MlSid78/JzY7/69+N2Pq2mFoX7t5mkLOUzymIwSBTxWo6caaYI0x0oa3l5xnlN4k1auGh/Ut3YZNkhPM8yMioWWb4iHwSVXSFbrxl4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=u3v6qq/D/CHqYe1q3csD6gQ0bbvppSiOXX8sL7o00tOKK8Rz/ZNBBlYcZslXSjWbl2SSFCo6d3MOk7NW9WQ84kIFu2Lo1ReFW6528039/fPZC1EjFM1ZaIlBIQj7nJ7ZDLEWC6utDALDLuEthHJj2xUiyuCdOrootYzQkEaAcPs=
Received: by 10.82.191.3 with SMTP id o3mr18700596buf.17.1205301101664;
        Tue, 11 Mar 2008 22:51:41 -0700 (PDT)
Received: by 10.82.172.14 with HTTP; Tue, 11 Mar 2008 22:51:41 -0700 (PDT)
In-Reply-To: <7v1w6g8s1w.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76927>

On Tue, Mar 11, 2008 at 8:50 PM, Junio C Hamano <gitster@pobox.com> wrote:
>  So I think the wording is fine.  What's more necessary in the documention
>  is how and why these restrictions are useful in what situations, workflows
>  and management policies.

I agree.  I plan a revised patch later this week.  I may need some
help with the documentation.

-- 
Sverre Hvammen Johansen
