From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: User-wide ignore list
Date: Thu, 15 Feb 2007 13:06:24 +0000
Message-ID: <200702151306.33865.andyparkins@gmail.com>
References: <vpq4ppnvi1j.fsf@olympe.imag.fr> <200702151112.06729.andyparkins@gmail.com> <Pine.LNX.4.63.0702151259270.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 15 14:06:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHgK0-0000wG-7f
	for gcvg-git@gmane.org; Thu, 15 Feb 2007 14:06:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932698AbXBONGk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Feb 2007 08:06:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932699AbXBONGk
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Feb 2007 08:06:40 -0500
Received: from wr-out-0506.google.com ([64.233.184.238]:57959 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932698AbXBONGj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Feb 2007 08:06:39 -0500
Received: by wr-out-0506.google.com with SMTP id i31so678517wra
        for <git@vger.kernel.org>; Thu, 15 Feb 2007 05:06:38 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=hvGzr4RSs2VMNf+8c6lmiqmECgkAphhLLAQmuY6FxAHiQtZjFsv3jCqq5SmgFwTK5e2Jhjc5zZUpuQGMgoI1CK53c09HbZNHFxen65ytURrdLNRfycPQ0nkaKskNzthUNMZ9ZYQZBdeoC2WFqgnrlYU0RZj264dcgCqpq9kKiF4=
Received: by 10.90.93.6 with SMTP id q6mr2299565agb.1171544798916;
        Thu, 15 Feb 2007 05:06:38 -0800 (PST)
Received: from 360run094l ( [194.70.53.227])
        by mx.google.com with ESMTP id 53sm2545505ugn.2007.02.15.05.06.36;
        Thu, 15 Feb 2007 05:06:36 -0800 (PST)
User-Agent: KMail/1.9.5
In-Reply-To: <Pine.LNX.4.63.0702151259270.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39826>

On Thursday 2007 February 15 11:59, Johannes Schindelin wrote:

> > info/exclude::
>
> Nope. This is per-repo, not per-user.

Silly me; I forgot to write the last bit of my email :-)

$ ln -sf $HOME/.git/exclude $GIT_DIR/info/exclude

Do that in each of your working checkouts and voila.


Andy

-- 
Dr Andy Parkins, M Eng (hons), MIEE
andyparkins@gmail.com
