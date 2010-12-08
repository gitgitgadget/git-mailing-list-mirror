From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 0/2] [RFD] Using gitrevisions :/search style with other
 operators
Date: Wed, 8 Dec 2010 14:40:14 -0600
Message-ID: <20101208204014.GA6289@burratino>
References: <1291820319-12455-1-git-send-email-pclouds@gmail.com>
 <201012082047.44022.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Kevin Ballard <kevin@sb.org>, Yann Dirson <dirson@bertin.fr>,
	Jeff King <peff@peff.net>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 08 21:40:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQQoU-0000f5-P3
	for gcvg-git-2@lo.gmane.org; Wed, 08 Dec 2010 21:40:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756247Ab0LHUk3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Dec 2010 15:40:29 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:52962 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756201Ab0LHUk3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Dec 2010 15:40:29 -0500
Received: by vws16 with SMTP id 16so1378857vws.19
        for <git@vger.kernel.org>; Wed, 08 Dec 2010 12:40:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=rhEiZgBcayzgCw+Lv/nD58yFq6PPY/zDHJ1xMWK1nvA=;
        b=WOUGwqRrKI2U9zUruyqh3Ymb+C1Qfp61RdMToCPtjtSnpO6bi0C/CZwp23uItGpWrR
         a92ZwWuPIjgUyGaJyktJmySAmBf/O5NtcmR8gKFbCTKK06QDg2bon2V5E7FZqWSdGEiq
         U0UFqJbAaSkn086ynt9GLdKMQxmTSwpGRd1Eg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Gg8qSjXIQQf5FaT2ELvEjWtlC1WHTMq8zW9aZZ89MiwsbNoI1Joz9SnX4jgs00uMuN
         G9Bp2w871U4Ih2eLCEJPw+94hoUmxWavHRYGi7uxGAkx/tWfLv2MztUTQrGwdVnrJtk5
         ZX2QYaHSvkHCmbeLfdf/PffnmwkulEqJESK4A=
Received: by 10.220.192.75 with SMTP id dp11mr183965vcb.181.1291840828380;
        Wed, 08 Dec 2010 12:40:28 -0800 (PST)
Received: from burratino (adsl-69-209-58-175.dsl.chcgil.sbcglobal.net [69.209.58.175])
        by mx.google.com with ESMTPS id f17sm423244vbv.6.2010.12.08.12.40.26
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 08 Dec 2010 12:40:27 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <201012082047.44022.jnareb@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163220>

Jakub Narebski wrote:

> So if we chose this, why don't we follow Perl 6 rule of combining modifiers
> http://perlcabal.org/syn/S05.html#Modifiers, so it would be
>
>    foo^{:2nd:i/<regexp>}
>
> or
>
>    foo^{:i:nth(2)/<regexp>}

Very nice.
