From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: Libification project (SoC)
Date: Mon, 19 Mar 2007 08:01:35 +0100
Message-ID: <e5bfff550703190001k761541c7v2c259ef3f7695b10@mail.gmail.com>
References: <20070316042406.7e750ed0@home.brethil>
	 <20070316060033.GD31606@spearce.org>
	 <7vps79wueu.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.63.0703161251200.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	 <20070316130958.GD1783@peter.daprodeges.fqdn.th-h.de>
	 <Pine.LNX.4.63.0703161509560.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	 <20070318140816.GG4489@pasky.or.cz>
	 <Pine.LNX.4.63.0703190045520.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	 <20070319012111.GS18276@pasky.or.cz>
	 <Pine.LNX.4.63.0703190235330.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Petr Baudis" <pasky@suse.cz>, "Rocco Rutte" <pdmef@gmx.net>,
	git@vger.kernel.org, tytso@mit.edu, spearce@spearce.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Mar 19 08:01:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HTBsC-0000Rn-4y
	for gcvg-git@gmane.org; Mon, 19 Mar 2007 08:01:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965744AbXCSHBj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Mar 2007 03:01:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965750AbXCSHBj
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Mar 2007 03:01:39 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:8447 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965744AbXCSHBi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Mar 2007 03:01:38 -0400
Received: by ug-out-1314.google.com with SMTP id 44so1235382uga
        for <git@vger.kernel.org>; Mon, 19 Mar 2007 00:01:36 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=nm4AiS7dRysNA8TpRDy10d44H8uwbXYakVyMru7wkUPQq/JjZvarqM/UqNRdN0hz5HzTqYqRtIn7FAcjNqe2UfkpXDp+/YXpriaQ9Fz8rvr3Freqvg+ScaYKNZWfKMJK4Qf/eB0sXKnT5LnbvH44xV8maK7WuBdPOc6IAhT9c7M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=A0xQoaYOUqRyaNWLZ84ALm5wb/GBYdaLLbGB5UFHQXYeNlEZlFqEhVZiXw+W2qY67QCRH0wt2BAEM82YHapAox8glNFn7vyipiSZgDwFsyoFU4qlnA3cAMrI1tUAM9Cy5TiH6tGM/8ssu1EeweDFhns5LTlsDM02VOZFMK6ri2w=
Received: by 10.65.126.16 with SMTP id d16mr8266615qbn.1174287695475;
        Mon, 19 Mar 2007 00:01:35 -0700 (PDT)
Received: by 10.114.60.16 with HTTP; Mon, 19 Mar 2007 00:01:35 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.63.0703190235330.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42597>

On 3/19/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>
> I don't see _any_ problem in making an API which works with _one_ repo
> first. This has several advantages:
>
> - most users (if any!) will work that way,
>

Sometime could be useful to write a list of possible users before
starting to code.

Please which are, in your opinion, the possible tools that could use a
non-reentrant, blocking libgit? In case tool is already exsistant
please write the name, in case it's a 'would be' one give a brief
description.

I' have tried to do the list myself, but I found only viewers ;-)
among _currently_ tools I know of, and all the viewers allow loading
in background _now_ so will not be portable to libgit without main
surgery, read multi-thread (BTW none is currently multi-thread).

   Marco
