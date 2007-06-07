From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: [PATCH] [RFC] Generational repacking
Date: Fri, 8 Jun 2007 10:51:53 +1200
Message-ID: <46a038f90706071551w45592471g59a35abb871749bd@mail.gmail.com>
References: <11811281053874-git-send-email-sam.vilain@catalyst.net.nz>
	 <56b7f5510706061704r34692c49v994ff368bbc12d05@mail.gmail.com>
	 <46676D44.7070703@vilain.net>
	 <alpine.LFD.0.99.0706062314410.12885@xanadu.home>
	 <46a038f90706071246y7dd14f55t199b8ed4e7617b68@mail.gmail.com>
	 <46687A73.6080100@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Nicolas Pitre" <nico@cam.org>, "Dana How" <danahow@gmail.com>,
	"Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Sam Vilain" <sam@vilain.net>
X-From: git-owner@vger.kernel.org Fri Jun 08 00:52:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HwQpk-0000kx-Rn
	for gcvg-git@gmane.org; Fri, 08 Jun 2007 00:52:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932846AbXFGWvz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Jun 2007 18:51:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760569AbXFGWvy
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jun 2007 18:51:54 -0400
Received: from wr-out-0506.google.com ([64.233.184.224]:25519 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932846AbXFGWvy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jun 2007 18:51:54 -0400
Received: by wr-out-0506.google.com with SMTP id i21so533026wra
        for <git@vger.kernel.org>; Thu, 07 Jun 2007 15:51:53 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=C3KEvs+wVn+f+fFqArLj9kyiX1e4s3JDhFZoX6OQn/JGac5zvS1AKKA6QRgDDeBTSBiDx/FYJf8iURfIwCfV9kN0p4pYwV0I2qeel6OMp+KM92hlkcaNSuxXHosyA5/xycFmWh9xQRK6Ffb9O6nAjDGCIz9/SaWAX42qqaoyMDo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=THmGQfeH8KQjBHajl41bgATwrDvTbtTToQVqR1+FDJLQzTyUDVSqLiY9sdGBhWBurlanBI7cE4kiZz8We1k99pEVU0eM0Si1UIRdP86CFOLtOdBaMk7EAJ6e0hoNbsxfKfitoxuzsW47W/L1zCY0C1wCnEDwVxLLrNI+EikwaR4=
Received: by 10.90.92.7 with SMTP id p7mr2259850agb.1181256713482;
        Thu, 07 Jun 2007 15:51:53 -0700 (PDT)
Received: by 10.90.35.4 with HTTP; Thu, 7 Jun 2007 15:51:53 -0700 (PDT)
In-Reply-To: <46687A73.6080100@vilain.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49399>

On 6/8/07, Sam Vilain <sam@vilain.net> wrote:
> Ok.  But if repack is generational you probably don't mind waiting for
> it on commit so don't need to background it.

Agreed. The patch I posted back then was on fetch as a signle fetch is
more likely to bring a lot of new objects in. (Moreso than a commit)

Repack-on-commit if there's more than 1k unpacked objects makes sense.
Are fetches nowaways always using the "keep pack" and "fatten thin
pack" semantics? If yes, then

cheers,



martin
