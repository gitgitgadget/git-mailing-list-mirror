From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 0/2] avoid bogus "recursion detected in die handler"
 message
Date: Tue, 16 Apr 2013 17:49:41 -0700
Message-ID: <20130417004941.GJ29773@google.com>
References: <20130415230651.GA16670@sigill.intra.peff.net>
 <20130415230802.GA11267@sigill.intra.peff.net>
 <CA+sFfMes99EepY4FCW32s1L3ywv_gyFb76=Y=35rvPbc2K1BWA@mail.gmail.com>
 <20130416004228.GA14995@sigill.intra.peff.net>
 <CA+sFfMdzTNjH10FKxhvJy+7hZg+0=1Wrqy9k8KaPoJg1DuDpmg@mail.gmail.com>
 <20130416025024.GA20932@sigill.intra.peff.net>
 <516CFB56.1090805@viscovery.net>
 <20130416130154.GA17976@sigill.intra.peff.net>
 <516D5CA4.7000500@viscovery.net>
 <20130416194418.GA7187@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Brandon Casey <drafnel@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 17 02:49:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USGZR-0000hL-T2
	for gcvg-git-2@plane.gmane.org; Wed, 17 Apr 2013 02:49:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755410Ab3DQAtr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Apr 2013 20:49:47 -0400
Received: from mail-da0-f44.google.com ([209.85.210.44]:58164 "EHLO
	mail-da0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754273Ab3DQAtq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Apr 2013 20:49:46 -0400
Received: by mail-da0-f44.google.com with SMTP id z20so498241dae.31
        for <git@vger.kernel.org>; Tue, 16 Apr 2013 17:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=DSu/0D2GAN1OHwq1td374OY8P+G7T9fAixkhzp2doKo=;
        b=P8wG8lC/eCICj8Sfay8Ym9qEyaiqVDgnxl/1W5xazaC8sQertlRTCVy/S0eYq+moYK
         uUN022GdKwFTbaZUSbg3LFcXLS9UXLFI35WjOLwGoN4VaN5Mgtcm2FwJTkKv2ObbD/FY
         321vYn+JLNzVQFxPfY7TdkOxb+84sJw/M7QCWSHXSrzS6oTHGekFa0oJN1bLB8EcXRGt
         BDbGSEld1fdpK33HhvyX1rKDvxHwnnjfQUh/6ihwfGzlDSsh9JPvI83TUt5zxfeFIuBd
         1XKQ5z5MFNEMTalDvzVj5EVdM83OKMEmWKnF6KnO5/paZOgcAyMOXcLr6qX+7aVomQBB
         V27Q==
X-Received: by 10.66.164.161 with SMTP id yr1mr5992700pab.77.1366159786129;
        Tue, 16 Apr 2013 17:49:46 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPS id jk11sm4013748pbb.0.2013.04.16.17.49.43
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 16 Apr 2013 17:49:44 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130416194418.GA7187@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221494>

Jeff King wrote:

>   [1/2]: usage: allow pluggable die-recursion checks
>   [2/2]: run-command: use thread-aware die_is_recursing routine

Lovely.  This doesn't solve the analagous problem for grep,
index-pack, pack-objects, preload-index, or bidirectional_transfer_loop,
but it doesn't make them worse and even should make them easier to fix
later, so

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
