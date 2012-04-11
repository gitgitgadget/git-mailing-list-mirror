From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: GSoC - Some questions on the idea of
Date: Wed, 11 Apr 2012 01:04:04 -0500
Message-ID: <20120411060357.GA15805@burratino>
References: <CA+M5ThS2iS-NMNDosk2oR25N=PMJJVTi1D=zg7MnMCUiRoX4BQ@mail.gmail.com>
 <CACsJy8APtMsMJ=FrZjOP=DbzuFoemSLJTmkjaiK5Wkq9XtA4rg@mail.gmail.com>
 <loom.20120328T131530-717@post.gmane.org>
 <CA+M5ThTPyic=RhFL2SvuNB0xBWOHxNTaUZrYMB144UjpjCiLoQ@mail.gmail.com>
 <20120330203430.GB20376@sigill.intra.peff.net>
 <CA+M5ThR6jtxqs0-Kz-8fcRuOFRbLr-GvsJcTmrOQ7_geNspDLg@mail.gmail.com>
 <4F76E430.6020605@gmail.com>
 <4F772E48.3030708@gmail.com>
 <20120402210708.GA28926@sigill.intra.peff.net>
 <4F84DD60.20903@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>,
	Sergio Callegari <sergio.callegari@gmail.com>,
	Bo Chen <chen@chenirvine.org>, git@vger.kernel.org
To: Neal Kreitzinger <nkreitzinger@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 11 08:04:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SHqfG-0002Tl-0K
	for gcvg-git-2@plane.gmane.org; Wed, 11 Apr 2012 08:04:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753306Ab2DKGER (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Apr 2012 02:04:17 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:52172 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753005Ab2DKGEQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2012 02:04:16 -0400
Received: by iagz16 with SMTP id z16so820307iag.19
        for <git@vger.kernel.org>; Tue, 10 Apr 2012 23:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=dL/ax61mI0GjrSgihs+sX+a/G1Rc7Wzr30aemfDYjiA=;
        b=H71IviOEMhsLIOU9um4pW6hM4xPbBV8+txjPj/bfX57FWqhnWQ0Y5fjhJ98XcgW2hk
         8W3/900nb9ca6O9KHeAaqAX0hb2WlKonz2qKOHuZ1xPoovfWKfvqFGstezrpfGnANJJo
         kvKAx2eoIbBSTIWSgYnAVfn7MHLCudkU12H0HJOLSbtYEdbMexrbnXms4hlvcC9aPk/2
         J/uV5XESKEcWBTsQC/qiKrUZzHhh3UK9ify89s2bKoHuE7+nbwRMCkSkdQmU6Wm+No1s
         EBTiLOXBANBQdlLdAG9/nLZZkNdsZY8VtTnjIXWmVLJvhS9ddoa/UzNBxzm4CwD4KbzQ
         od/g==
Received: by 10.50.37.236 with SMTP id b12mr4620087igk.36.1334124256198;
        Tue, 10 Apr 2012 23:04:16 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id kn3sm23694875igc.15.2012.04.10.23.04.15
        (version=SSLv3 cipher=OTHER);
        Tue, 10 Apr 2012 23:04:15 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4F84DD60.20903@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195151>

Neal Kreitzinger wrote:

> Maybe small binaries do xdelta well and the above is a moot point.

If I am reading it correctly, diff-delta copes fine with smallish
binary files that have not changed much.  Converting to hex would only
hurt.

I would suggest tracking source code instead of binaries if possible,
though.

Jonathan
