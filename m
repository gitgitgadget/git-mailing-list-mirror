From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] i18n: use test_i18ncmp in t2020 (checkout --detach)
Date: Sat, 14 Apr 2012 07:47:17 -0500
Message-ID: <20120414124716.GB20076@burratino>
References: <20110320090111.GA15641@sigill.intra.peff.net>
 <20110320090918.GB15948@sigill.intra.peff.net>
 <20120413225901.GA13220@burratino>
 <20120413233010.GA16663@sigill.intra.peff.net>
 <20120413234607.GE13995@burratino>
 <20120414022452.GA17535@sigill.intra.peff.net>
 <20120414050234.GE1791@burratino>
 <20120414082213.GC11124@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Piotr Krukowiecki <piotr.krukowiecki@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Apr 14 14:47:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJ2O0-0004OU-Lb
	for gcvg-git-2@plane.gmane.org; Sat, 14 Apr 2012 14:47:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751621Ab2DNMrY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Apr 2012 08:47:24 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:59229 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751302Ab2DNMrX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Apr 2012 08:47:23 -0400
Received: by iagz16 with SMTP id z16so5375062iag.19
        for <git@vger.kernel.org>; Sat, 14 Apr 2012 05:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=qB616PKa58JX9kbsUIQN6GcUEG/ONNqhyOae81hcIgs=;
        b=Ai02vlmXH1S41HD10C8ZW6RB4Uk5+joM1EbFeVHSFBNcbVGXxJ9dhb8EXcXstaRiUD
         j5SZQPNk+bN8TVjRQ3hdhMKC12eiJGi04T4R/Iv6l3IwkFrA6h1zHB2Iz4id/YolV+6N
         eCWEolwB9GDaGyyfyV8//Aqd9nxITOv9u1SDDp/UkPwQsAfKuFT11iSx7996NauW7Nlj
         s/Fh7YaS2CzcKCOIcrxOdve38E80B3jtoxub3BP/RS8gyPrUT5ilswPwYw7OsA7FxyFs
         HfU/Kv8IPpVwDvXsbogpefZhrmN9qzlvgctBFZnbK+sK4t27ZTQnI23jWtFgU5dyKD9D
         bqXA==
Received: by 10.50.17.166 with SMTP id p6mr1107792igd.53.1334407642027;
        Sat, 14 Apr 2012 05:47:22 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id de2sm2281326igc.4.2012.04.14.05.47.21
        (version=SSLv3 cipher=OTHER);
        Sat, 14 Apr 2012 05:47:21 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120414082213.GC11124@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195489>

Jeff King wrote:

>                         I suspect you'd have to actually make a poison
> locale (though you could probably generate one via script without too
> much effort).

Yes, that's the easy part.  The hard part is convincing gettext to use
it.
