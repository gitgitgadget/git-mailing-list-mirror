From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: [PATCH 5/9] update-index: add --checkout/--no-checkout to update CE_NO_CHECKOUT bit
Date: Thu, 20 Nov 2008 22:54:29 +0700
Message-ID: <fcaeb9bf0811200754o69551068h44856ad3971cab48@mail.gmail.com>
References: <1222833849-22129-2-git-send-email-pclouds@gmail.com>
	 <1222833849-22129-4-git-send-email-pclouds@gmail.com>
	 <1222833849-22129-5-git-send-email-pclouds@gmail.com>
	 <1222833849-22129-6-git-send-email-pclouds@gmail.com>
	 <20081118113316.GA18610@segfault.peff.net>
	 <7vk5b0vp19.fsf@gitster.siamese.dyndns.org>
	 <7v4p24tq59.fsf@gitster.siamese.dyndns.org>
	 <20081119130223.GA27893@segfault.peff.net>
	 <fcaeb9bf0811200726x1f2956c6k6f2ca16543a0fbc@mail.gmail.com>
	 <20081120153252.GA7374@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Nov 20 17:01:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L3Bsk-0004GQ-C6
	for gcvg-git-2@gmane.org; Thu, 20 Nov 2008 16:55:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754969AbYKTPye (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Nov 2008 10:54:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754733AbYKTPyd
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Nov 2008 10:54:33 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:39399 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751307AbYKTPyd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Nov 2008 10:54:33 -0500
Received: by ug-out-1314.google.com with SMTP id 39so316232ugf.37
        for <git@vger.kernel.org>; Thu, 20 Nov 2008 07:54:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=/xSeE2ncJsk+ARichKlSxZeYqn3lZ7EDRcMmkcOyYQ0=;
        b=vDAbBgf8Y0Vi4kKiUUGVSxmfiDj/DtG4Z3VqRXNdqDXds4xfksxGy9aKmHrrhYI+PK
         1UgA3Tv1vCDf4zcL10xKamswp9vS+WKldh5f1DAj2navWPLLHlkxiJO58rNVTwn1USDR
         b70g2+yHljTBjDXCtzuKivYqdKu9zb/Caj15c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=WZE8d+PzRf9Up3HUfuhPGmzHtn/kGdWBsMeRzAyyaEFbWYCDih0Iryeo7zWVZJKmfB
         MqzxMmchankgyTCrZWmZlXDHc1M1mmET145RzsjPwl4vvX8Gsh5bsmgS8WeYshawQ2WK
         VeySZsx2jc/slJs4QebY3VShnPMYewmy/9q7Q=
Received: by 10.86.57.9 with SMTP id f9mr1658449fga.32.1227196469705;
        Thu, 20 Nov 2008 07:54:29 -0800 (PST)
Received: by 10.86.62.13 with HTTP; Thu, 20 Nov 2008 07:54:29 -0800 (PST)
In-Reply-To: <20081120153252.GA7374@coredump.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101456>

On 11/20/08, Jeff King <peff@peff.net> wrote:
> On Thu, Nov 20, 2008 at 10:26:48PM +0700, Nguyen Thai Ngoc Duy wrote:
>
>  > Thanks for catching. The last half also has the same problem. Another
>
>
> I'm not sure what you mean by "the last half also has the same problem";
>  with the patch I posted (or Junio's patch) the test works fine for me.

Sorry for the confusion. I meant the second half of the series,
implementing UI interface for sparce checkout, which is not in pu yet.
-- 
Duy
