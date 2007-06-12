From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: Asking again... [Re: how to properly import perforce history?]
Date: Tue, 12 Jun 2007 16:12:35 +0200
Message-ID: <81b0412b0706120712hc72680bjdf26fa7ded08f0c7@mail.gmail.com>
References: <20070608202236.GJ25093@menevado.ms.com>
	 <200706112042.16331.simon@lst.de> <20070611201232.GA4649@steel.home>
	 <200706112346.13628.simon@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Simon Hausmann" <simon@lst.de>
X-From: git-owner@vger.kernel.org Tue Jun 12 16:12:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hy76z-0002ho-QB
	for gcvg-git@gmane.org; Tue, 12 Jun 2007 16:12:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751094AbXFLOMi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 12 Jun 2007 10:12:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751777AbXFLOMi
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jun 2007 10:12:38 -0400
Received: from wr-out-0506.google.com ([64.233.184.225]:16356 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751094AbXFLOMi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jun 2007 10:12:38 -0400
Received: by wr-out-0506.google.com with SMTP id 76so1308325wra
        for <git@vger.kernel.org>; Tue, 12 Jun 2007 07:12:37 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=EswJlzs9M3DbA0ges8gH8RQITj2gPIPCb4A/chQrTTC+jfE6sWQ02d5CbRdSCfaNaSvKbc15X3j77kpjV36sqyKxAlyTP7TsoGly/1JBS1TtwZkkBwRdsbINSuc0MRHn6MYM6NoVIa+WIa+j+/thGscrEy6H0swdGZfMki+41XE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=F+Te6I2qsQI14Z8cwDowMtTqnMxDZkpGolanprsPjNg92UDiQrUpbNS7WggPyQxLe27OfKdu3Hq+xCy7rK9JtsNVywNboAdQfYqy7x07gV3ry1/bofRyZdUUirFimT1iUwK6X4KMCiaaUJc9a6paRrdxCzamCC9udoGUxdgZ8j4=
Received: by 10.78.137.7 with SMTP id k7mr2683715hud.1181657555661;
        Tue, 12 Jun 2007 07:12:35 -0700 (PDT)
Received: by 10.78.118.19 with HTTP; Tue, 12 Jun 2007 07:12:35 -0700 (PDT)
In-Reply-To: <200706112346.13628.simon@lst.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49964>

On 6/11/07, Simon Hausmann <simon@lst.de> wrote:
> Ooops, indeed. Makes me realizes that I've never actually submitted files with
> spaces in the name :). For now I've quoted them with double quotes like in
> the other places, which is better than nothing. Thanks for spotting!

Running 'p4 print' the code also does not check for code "error",
and there may be other places which have to check for errors.

BTW, I have never seen code "text". It is always "binary" for file data,
for text files the type in code-stat element is just set to "text".
