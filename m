From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC/PATCH] Add the NO_SENTINEL build variable
Date: Mon, 15 Jul 2013 11:13:57 -0700
Message-ID: <20130715181357.GF14690@google.com>
References: <51E4338E.4090003@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Mon Jul 15 20:14:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UynHk-0005NS-5j
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jul 2013 20:14:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752283Ab3GOSOD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jul 2013 14:14:03 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:57750 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752101Ab3GOSOC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jul 2013 14:14:02 -0400
Received: by mail-pa0-f51.google.com with SMTP id lf11so11482634pab.24
        for <git@vger.kernel.org>; Mon, 15 Jul 2013 11:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=QvpwNSq0udA2QFKBf0m048+f8a48MlhQ+AFZ8JZDlUY=;
        b=zeINauN8GUOHsaY2uEc/wDUFcM3q8ajrDZj4/Mvl0/ZVoWgKySTEnU1a2PEMmTlxKc
         qVdRxRZeYsonNKZANq2rXOME9lPNqSSgkDaIwo6ZI5GYz/sXvH+HomVAi5wArmc0i5YA
         lUdxgW8YogMG646DWk3VQDAklAg04+NuG+MjBiFv5/VKqiawaqJG44pviNCFOgMy8yTh
         jFO4tlZTA1I7C2BAWAtMBaMO6XenskiF+ZOTsUP8Ahul/XzWlcN/dD1Nl/X4R6aE2VQY
         bidWZwy89MOUKjvDC8l0H5uUQ1bKxktRkMonIat55PA/eueMB8ynkkVayjNaGU1dvZDe
         fxhg==
X-Received: by 10.68.201.98 with SMTP id jz2mr50342810pbc.56.1373912041231;
        Mon, 15 Jul 2013 11:14:01 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id ib9sm62124252pbc.43.2013.07.15.11.13.59
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 15 Jul 2013 11:14:00 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <51E4338E.4090003@ramsay1.demon.co.uk>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230512>

Ramsay Jones wrote:

> One of the three gcc compilers that I use does not understand the
> sentinel function attribute. (so, it spews 108 warning messages)

Do you know what version of gcc introduced the sentinel attribute?
Would it make sense for the ifdef in git-compat-util.h to be keyed on 
__GNUC__ and __GNUC_MINOR__ instead of a new makefile flag?

Thanks,
Jonathan
