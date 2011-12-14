From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC/PATCH 0/7] some sequencer loose ends (Re: Fix revert
 --abort on Windows)
Date: Wed, 14 Dec 2011 03:57:49 -0600
Message-ID: <20111214095749.GA19953@elie.hsd1.il.comcast.net>
References: <20111120094650.GB2278@elie.hsd1.il.comcast.net>
 <20111122111207.GA7399@elie.hsd1.il.comcast.net>
 <20111122112001.GF7399@elie.hsd1.il.comcast.net>
 <7vr50zd5x0.fsf@alter.siamese.dyndns.org>
 <20111123012721.GA14217@elie.hsd1.il.comcast.net>
 <4ECCB3A2.5030102@viscovery.net>
 <20111123100452.GA30629@elie.hsd1.il.comcast.net>
 <4ECCC935.7010407@viscovery.net>
 <20111210124644.GA22035@elie.hsd1.il.comcast.net>
 <7v39cp32av.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Ramkumar Ramachandra <artagnon@gmail.com>, git@vger.kernel.org,
	Christian Couder <chriscool@tuxfamily.org>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 14 10:58:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ralb9-0003qq-D9
	for gcvg-git-2@lo.gmane.org; Wed, 14 Dec 2011 10:58:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755049Ab1LNJ56 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Dec 2011 04:57:58 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:56845 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754975Ab1LNJ55 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Dec 2011 04:57:57 -0500
Received: by vbbfc26 with SMTP id fc26so485312vbb.19
        for <git@vger.kernel.org>; Wed, 14 Dec 2011 01:57:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=3i+fmiAPqVwv+Sfn5rmbNaUKHjMgqqVXcUZEWbSV3n4=;
        b=nseXTxCvFdzyqBbGTLV/8SQuggoNRQ/o6TylNLOMw/P766i8jEH5tYuSr2vqGwXlFN
         ZpWusloE2uBHxxtfbertMVC9soxWXT1Nf1bqUcOTtFfsgFzY4Lxsjh9XYm8b/LmsTix1
         SonS7JWhamG++r8bCX3hRGcRnsKOj55hXvvnc=
Received: by 10.52.99.231 with SMTP id et7mr3375608vdb.114.1323856676857;
        Wed, 14 Dec 2011 01:57:56 -0800 (PST)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id ir2sm1923130vdb.9.2011.12.14.01.57.54
        (version=SSLv3 cipher=OTHER);
        Wed, 14 Dec 2011 01:57:55 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7v39cp32av.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187105>

Junio C Hamano wrote:

> I saw a few minor nits in the log messages but otherwise nothing
> objectionable jumped at me from my initial reading of the series.

I was tempted to send a reroll with slightly better log messages once
I could see your corrections, but it looks like the series has been
merged to "next" and your corrections already leave me happy enough.

Thanks for looking it over.
