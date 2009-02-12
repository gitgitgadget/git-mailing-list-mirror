From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCHv2 5/6] gitweb: last-modified time should be commiter, not 
	author
Date: Thu, 12 Feb 2009 12:23:47 +0100
Message-ID: <cb7bb73a0902120323ja05d79bw7470521d967eef03@mail.gmail.com>
References: <1232970616-21167-1-git-send-email-giuseppe.bilotta@gmail.com>
	 <200902121007.29867.jnareb@gmail.com>
	 <cb7bb73a0902120152h7b3e0ac6w379bd9319712ea2b@mail.gmail.com>
	 <200902121111.51147.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Deskin Miller <deskinm@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 12 12:25:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXZh6-00018f-SQ
	for gcvg-git-2@gmane.org; Thu, 12 Feb 2009 12:25:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757292AbZBLLXx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Feb 2009 06:23:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757136AbZBLLXw
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Feb 2009 06:23:52 -0500
Received: from mail-ew0-f21.google.com ([209.85.219.21]:50731 "EHLO
	mail-ew0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756851AbZBLLXv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Feb 2009 06:23:51 -0500
Received: by ewy14 with SMTP id 14so546927ewy.13
        for <git@vger.kernel.org>; Thu, 12 Feb 2009 03:23:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=O4LIsXrN0H0mX0WlF9GJ75T3/taCDdaWFc9A7W1G4Mg=;
        b=f6iscFV0y36PQeO2j1HYatDo+VS8ooJ8uvT/PP6js4JuBYc6HNjmtFoIad/yV581nb
         uZL1hH1cSa8yuMM88FqRnoCAI0bfxyHC2p8kJH+Bch+zKitwj0XBnTcui1oxDGX5Tl2a
         veeVOv2wwMQnnHQLYAbWxoYjcSpGa+F63RUPA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=XACts0DLSKWNsbR2Toq22rFlJeXHI2yWy2lTD3jWGrSmOn4kPPdkkm7hdRo9A6vVkX
         mipkTXahIEb5PXPXL6u9AUfpPuxyCA6u6Euz/0S9H11zWbOU3tzleVkzz9fH5ht99TMc
         SfBNfq5bwtqLSWfgSEhQ9g3NoJy1GZnHtq1HU=
Received: by 10.210.43.10 with SMTP id q10mr612926ebq.58.1234437829909; Thu, 
	12 Feb 2009 03:23:49 -0800 (PST)
In-Reply-To: <200902121111.51147.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109604>

On Thu, Feb 12, 2009 at 11:11 AM, Jakub Narebski <jnareb@gmail.com> wrote:
>
> Well, that beside my little doubt whether using publish date is a good
> idea or not...
>

I'm open to suggestion for better ideas 8-)

> P.S. What would you do for explicit and implicit HEAD? HEAD reflog,
> or 'current branch' reflog?

I would say the HEAD reflog.


-- 
Giuseppe "Oblomov" Bilotta
