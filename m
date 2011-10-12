From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Makefile: add a knob to turn off hardlinks within same
 directory
Date: Wed, 12 Oct 2011 14:57:05 -0500
Message-ID: <20111012195705.GA13768@elie.hsd1.il.comcast.net>
References: <20111012083842.GA21969@elie.hsd1.il.comcast.net>
 <7vaa969go4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Bastian Blank <waldi@debian.org>,
	Cedric Staniewski <cedric@gmx.ca>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 12 21:57:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RE4vY-00005X-HP
	for gcvg-git-2@lo.gmane.org; Wed, 12 Oct 2011 21:57:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753977Ab1JLT5P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Oct 2011 15:57:15 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:56191 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753283Ab1JLT5P (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Oct 2011 15:57:15 -0400
Received: by iaek3 with SMTP id k3so390658iae.19
        for <git@vger.kernel.org>; Wed, 12 Oct 2011 12:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=SuExXaPuBSFG7uh1WGnywAefB321JNLUdA+kc3JUPrI=;
        b=OyLXx0/bIC9dtFyFd5CG28Hy+xfAzyEHr7dU0yNieXa8jt8yTdQlIJpF9vYrGlf5/2
         vpiYsIavfSej86cx5GnVrGArK+QMZ988B+2plchzJ6WLimx5COl6afkI0OqjBQt7+Lpx
         Q2DipdugL79h+Fwe2iyKl5uiZ0G0S2tWZeJDo=
Received: by 10.42.155.201 with SMTP id v9mr885213icw.38.1318449434787;
        Wed, 12 Oct 2011 12:57:14 -0700 (PDT)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id 2sm8076137ibf.0.2011.10.12.12.57.13
        (version=SSLv3 cipher=OTHER);
        Wed, 12 Oct 2011 12:57:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vaa969go4.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183408>

Junio C Hamano wrote:

> Wouldn't your use case be better served with
>
>     $ tar zcf dist.tar.gz --hard-dereference $list_of_files_to_tar_up
>
> instead?

No, because that duplicates the files instead of making symlinks.
