From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: fast-import deltas
Date: Wed, 09 Apr 2014 12:44:52 -0500
Message-ID: <53458714720a6_af197d30861@nysa.notmuch>
References: <20140401102554.GA32231@glandium.org>
 <20140401114502.GA15549@sigill.intra.peff.net>
 <20140401130703.GA1479@glandium.org>
 <20140401131512.GA19321@sigill.intra.peff.net>
 <A0BF7D05-E351-4A5B-8F0F-DD0FAD391656@quendi.de>
 <20140402041346.GB15690@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>, Max Horn <max@quendi.de>
X-From: git-owner@vger.kernel.org Wed Apr 09 20:05:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WXwsL-0007MK-Jx
	for gcvg-git-2@plane.gmane.org; Wed, 09 Apr 2014 20:05:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934078AbaDISFW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Apr 2014 14:05:22 -0400
Received: from mail-oa0-f54.google.com ([209.85.219.54]:65500 "EHLO
	mail-oa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933354AbaDISFU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Apr 2014 14:05:20 -0400
Received: by mail-oa0-f54.google.com with SMTP id n16so3183091oag.13
        for <git@vger.kernel.org>; Wed, 09 Apr 2014 11:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=r7m+heJTNzRuuV+k0YHmr0+yef3CQ4dFR2+Z4Jw6DPo=;
        b=Qq/PJIE2vDWv6LP2lxFhytBHqKVlXvQ2IRruAIXqruTKqPD6pTgeZz36GqvoB4xHpq
         ePmsInGch8Dom0U6vYY/jq/P8qW0z2g4zbN+QymGNO+s1M6Kzi0Slq9/Y2dKyEsHdNbn
         Q0/I73k1Tooyjv5r43+0sDvqlGtLn9XtOmpiVTq8LWbnBo/9BQeiseXy5rS6cwu7yKkE
         2M4/zWJJDCs36ZEX2RGxPT79J0OUYrrv9v0TUZNb5NUczmlBhw6dD51CpgV7ejmhknvP
         hDTJJnZnnfTSYPfWAzYutxIG3KDd3/gT3XE/klvW/Po5WxXsuAnPmrQyMAW+BNPeKpEQ
         mlJQ==
X-Received: by 10.60.83.234 with SMTP id t10mr9855459oey.4.1397066719619;
        Wed, 09 Apr 2014 11:05:19 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id cn1sm6725241oeb.11.2014.04.09.11.05.17
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Apr 2014 11:05:18 -0700 (PDT)
In-Reply-To: <20140402041346.GB15690@glandium.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245983>

Mike Hommey wrote:
> On Wed, Apr 02, 2014 at 01:29:13AM +0200, Max Horn wrote:
> > I wonder if it is really worth the effort to start yet another project on
> > this... Moreover, I don't see a fundamental reason why one could not modify
> > git-remote-hg to work this way.
> 
> The way git-remote-hg works is fundamentally different to how one can
> directly get and push stuff to a remote mercurial server.

That is why you would modify it; so it does what you want, and instead of using
remote-helper's import/export, it would use fetch/push.

Either way, I say you should hack Git and do as many changes as you want, and
once you have some numbers, it would be clearer what approach should be the
ideal one, how much is the benefit, and then we could discuss if it's worth the
modifications in Git needed.

-- 
Felipe Contreras
