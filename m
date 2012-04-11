From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: GSoC - Some questions on the idea of
Date: Wed, 11 Apr 2012 12:20:34 -0500
Message-ID: <20120411172034.GE4248@burratino>
References: <loom.20120328T131530-717@post.gmane.org>
 <CA+M5ThTPyic=RhFL2SvuNB0xBWOHxNTaUZrYMB144UjpjCiLoQ@mail.gmail.com>
 <20120330203430.GB20376@sigill.intra.peff.net>
 <CA+M5ThR6jtxqs0-Kz-8fcRuOFRbLr-GvsJcTmrOQ7_geNspDLg@mail.gmail.com>
 <4F76E430.6020605@gmail.com>
 <4F772E48.3030708@gmail.com>
 <20120402210708.GA28926@sigill.intra.peff.net>
 <4F84DD60.20903@gmail.com>
 <20120411060357.GA15805@burratino>
 <4F85B4E7.7090603@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>,
	Sergio Callegari <sergio.callegari@gmail.com>,
	Bo Chen <chen@chenirvine.org>, git@vger.kernel.org
To: Neal Kreitzinger <nkreitzinger@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 11 19:20:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SI1Dt-0006yZ-FY
	for gcvg-git-2@plane.gmane.org; Wed, 11 Apr 2012 19:20:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760782Ab2DKRUo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Apr 2012 13:20:44 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:50687 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756591Ab2DKRUl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2012 13:20:41 -0400
Received: by yenl12 with SMTP id l12so598882yen.19
        for <git@vger.kernel.org>; Wed, 11 Apr 2012 10:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=KLvEhN5a+QUbwf7N03G/DkzSUptuxzFOf9qc+bshsbY=;
        b=emByM2kQrA6fK3zsfEB2nIQGvEAjGtagtn/1I+klQsBAQ+IGy1ErTrrHxjmDd++Qk8
         mKZEzIrK4y6+vUB9h2S5bWtkpmCXiO5xnn7uWAyggkLvYsnCFXKJgouE76fVBuy9s2IU
         hVyiTr1O0Swmo83bYKRx69QqeMacr0w1wa2kq65foNjfGDqjlq3poWrGDHSc1lW06I4/
         1roj5rUSYb5kfB4E3uQA4cndqeI6Dulw0gOXGoCpHynXpuicCv5cJbTXWlf3S++TVTZf
         BbF+vzTvjeYcJTyCQSEWgZoxrOkCTgYHiMU9OS+BO4ZR6dMhN2cTVA2TItL+QwlyeG+Y
         t8FQ==
Received: by 10.50.46.167 with SMTP id w7mr6496116igm.73.1334164840748;
        Wed, 11 Apr 2012 10:20:40 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id us6sm25809645igc.9.2012.04.11.10.20.36
        (version=SSLv3 cipher=OTHER);
        Wed, 11 Apr 2012 10:20:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4F85B4E7.7090603@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195220>

Neal Kreitzinger wrote:

>                              Graphics files for your app are
> "source".  The binary is all you have.

Often there is source in SVG or some other simple editable format that
gets lossily compiled to PNG or JPEG compressed raster graphics.
