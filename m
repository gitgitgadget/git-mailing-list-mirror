From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] drop support for "experimental" loose objects
Date: Fri, 22 Nov 2013 16:24:05 -0800
Message-ID: <20131123002405.GK4212@google.com>
References: <20131120203350.GA31139@kitenet.net>
 <20131120213348.GA29004@sigill.intra.peff.net>
 <20131120222805.GC26468@kitenet.net>
 <20131121114157.GA7171@sigill.intra.peff.net>
 <20131121114837.GB7171@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Joey Hess <joey@kitenet.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Nov 23 01:24:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vk11R-0006iH-Rq
	for gcvg-git-2@plane.gmane.org; Sat, 23 Nov 2013 01:24:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755495Ab3KWAYM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Nov 2013 19:24:12 -0500
Received: from mail-yh0-f53.google.com ([209.85.213.53]:36736 "EHLO
	mail-yh0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755311Ab3KWAYJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Nov 2013 19:24:09 -0500
Received: by mail-yh0-f53.google.com with SMTP id b20so1324417yha.26
        for <git@vger.kernel.org>; Fri, 22 Nov 2013 16:24:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=Gt0OQBTBD6RXCyHxeVP4mWxdEpEwYXTAQb/makfuSIY=;
        b=byUduNw3zkpFsW8ylmEu5nlc/7xQBBbMIBUrceFOvtY8YVnWYuCauuFh5ehIN91uUa
         RKyCD39+dXxoPp5mJz+Z/O22gFWd2VPNidhxvoqZKQ0XaTR5uUzzeNn5a8xdpKNLAd1U
         yBpfflp9NNjrmfIxdp2DFhQsxZC5MyONuwYYE7yDzrEXmWSAYLOnZmueWl/F/U3yo+xM
         8M576Mf9K3KQlDFa8JfBv95bqbltLujohW77lhNBrEAlP9/Lg05NbyBNPPJwYTTgVsuO
         peGxqQ3wh16k/Adw0tUamkjdvl4KTtEOrKTNwfJXocVJhtNOD1jVoQAl6gA9hV7FeRHO
         bLzw==
X-Received: by 10.236.35.99 with SMTP id t63mr14024187yha.19.1385166248885;
        Fri, 22 Nov 2013 16:24:08 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id u52sm59765987yhg.5.2013.11.22.16.24.07
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 22 Nov 2013 16:24:07 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20131121114837.GB7171@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238223>

Jeff King wrote:

>  sha1_file.c                                        |  74 ---------------------

Yay!

>  t/t1013-loose-object-format.sh                     |  66 ------------------

Hmm, not all of these tests are about the "experimental" format.  Do
we really want to remove them all?

Thanks,
Jonathan
