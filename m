From: Sergio Callegari <sergio.callegari@gmail.com>
Subject: Re: GSoC - Some questions on the idea of
Date: Sat, 31 Mar 2012 13:02:08 +0200
Message-ID: <4F76E430.6020605@gmail.com>
References: <CA+M5ThS2iS-NMNDosk2oR25N=PMJJVTi1D=zg7MnMCUiRoX4BQ@mail.gmail.com> <CACsJy8APtMsMJ=FrZjOP=DbzuFoemSLJTmkjaiK5Wkq9XtA4rg@mail.gmail.com> <loom.20120328T131530-717@post.gmane.org> <CA+M5ThTPyic=RhFL2SvuNB0xBWOHxNTaUZrYMB144UjpjCiLoQ@mail.gmail.com> <20120330203430.GB20376@sigill.intra.peff.net> <CA+M5ThR6jtxqs0-Kz-8fcRuOFRbLr-GvsJcTmrOQ7_geNspDLg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Bo Chen <chen@chenirvine.org>
X-From: git-owner@vger.kernel.org Sat Mar 31 13:02:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDw54-0008F7-Jm
	for gcvg-git-2@plane.gmane.org; Sat, 31 Mar 2012 13:02:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757127Ab2CaLCQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Mar 2012 07:02:16 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:49689 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756961Ab2CaLCP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Mar 2012 07:02:15 -0400
Received: by wejx9 with SMTP id x9so826360wej.19
        for <git@vger.kernel.org>; Sat, 31 Mar 2012 04:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=io3ymSRZbbWoAs1WRRzNikmi6yq9Yo2aMfIN+iUiYFA=;
        b=SS/PBEhrvKrsamgkYPgohiCrXcP31PZzVphXHbx90ZGwKL/LENpHjeVbPyWChzgotY
         GP2+tSkGdQswfKz9exG8MlCb8+WkH1syTauYEMGOri4zj/FOtC3bLQD/TjtEY6TMl9lZ
         9BFSijAYC3GLzDaV8hSbUPHYTgDnJ45hdWutOI9p+s3eaUOF+evw32Q5pnKNwCCvrl0I
         S3nQfMHMxAS0gBNERBoECbE2l38yQ9h5VqCNKUgbsSSKR3r2COOe1tNrMvWGTxQA5Ea2
         bslj4XCAw3dbplGLDpI/Rv9yy3+4bdna30VqO6OknQSUpG5qmTL68x3fxrKp3zVKY0yP
         ee0w==
Received: by 10.180.97.4 with SMTP id dw4mr6023786wib.18.1333191733617;
        Sat, 31 Mar 2012 04:02:13 -0700 (PDT)
Received: from [192.168.1.14] (host171-45-dynamic.7-87-r.retail.telecomitalia.it. [87.7.45.171])
        by mx.google.com with ESMTPS id w10sm24164387wiy.3.2012.03.31.04.02.10
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 31 Mar 2012 04:02:11 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:11.0) Gecko/20120310 Thunderbird/11.0
In-Reply-To: <CA+M5ThR6jtxqs0-Kz-8fcRuOFRbLr-GvsJcTmrOQ7_geNspDLg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194448>

I wonder if it could make sense to have some pluggable mechanism for file 
splitting. Something under the lines of filters, so to say.
Bupsplit can be a rather general mechanism, but large binaries that are 
containers (zip, jar, docx, tgz, pdf - seen as a collection of streams) may 
possibly be
more conveniently split by their inherent components.
