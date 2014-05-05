From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 1/3] Revert "make error()'s constant return value more
 visible"
Date: Mon, 05 May 2014 00:45:30 -0500
Message-ID: <5367257a857ce_2db613a731043@nysa.notmuch>
References: <1399183975-2346-1-git-send-email-felipe.contreras@gmail.com>
 <1399183975-2346-2-git-send-email-felipe.contreras@gmail.com>
 <20140505054901.GA19331@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 06 18:07:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WhhtC-0005Yp-Qa
	for gcvg-git-2@plane.gmane.org; Tue, 06 May 2014 18:06:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754620AbaEEF4N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 May 2014 01:56:13 -0400
Received: from mail-ob0-f176.google.com ([209.85.214.176]:62737 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754412AbaEEF4M (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 May 2014 01:56:12 -0400
Received: by mail-ob0-f176.google.com with SMTP id wp4so7823555obc.7
        for <git@vger.kernel.org>; Sun, 04 May 2014 22:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=vV21qLq13nZYtzGDaSGN0V+bmxjFVmk7UVcy9vUFIRk=;
        b=EcUpdqXOt/9URo51ZtMN4iv/GBIGTVsWPLE/7MpVrg2rD3Q9bLTsNT3vD9i3OlYbSA
         Q2mxXs/E43nvq/AfdCbFEk8t2afAPQAaMh5ZD/ZSBDtJAjdrqoDQciE2M5edtR/01IVg
         JJmcy84H1w3vTtdPVlCDqvLgiOntMuQ3tdf4pGFLNnU4ox9E0QOdMUzT0tT9Xq/ZbusZ
         5NUaQzUQyfNw29gWDR2F4iGaiArSsbRM1R+MM9reqGamLkpj1nPgcm9fXkIC1jF63fAo
         EtPn43WESrbj8tHB9dK4H+X3zAxbMtvLMQ0XArWpX6iDUHMcRoYaSTz7LKqiKmodDMh9
         dNbQ==
X-Received: by 10.182.33.6 with SMTP id n6mr1418179obi.48.1399269372022;
        Sun, 04 May 2014 22:56:12 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id bj8sm16974812obb.7.2014.05.04.22.56.09
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 04 May 2014 22:56:10 -0700 (PDT)
In-Reply-To: <20140505054901.GA19331@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248116>

Jeff King wrote:
> On Sun, May 04, 2014 at 01:12:53AM -0500, Felipe Contreras wrote:
> 
> > So it looks like gcc is smarter now, and in trying to fix a few warnings
> > we generated hundreds more.
> > 
> > This reverts commit e208f9cc7574f5980faba498d0aa30b4defeb34f.
> 
> And now we've gone the other way, and re-enabled the initial warnings.
> Can we come up with a solution that helps both cases?

What initial warnings? As I explained already I don't get any warnings
with this patch series in gcc 4.9.0.

-- 
Felipe Contreras
