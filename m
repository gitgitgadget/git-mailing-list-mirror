From: Scott Baker <bakers@canbytel.com>
Subject: Re: diff-highlight highlight words?
Date: Wed, 12 Nov 2014 09:59:35 -0800
Message-ID: <5463A007.4090302@canbytel.com>
References: <5462907B.1050207@canbytel.com> <20141112075609.GA21485@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Nov 12 19:06:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XocJC-0003Gk-B8
	for gcvg-git-2@plane.gmane.org; Wed, 12 Nov 2014 19:06:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753372AbaKLSGS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Nov 2014 13:06:18 -0500
Received: from magenta.web-ster.com ([216.105.64.36]:55963 "HELO
	magenta.web-ster.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751685AbaKLSGR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Nov 2014 13:06:17 -0500
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Wed, 12 Nov 2014 13:06:17 EST
Received: (qmail 14731 invoked from network); 12 Nov 2014 17:59:35 -0000
Received: from bar-1.web-ster.com (HELO [10.1.1.1]) (bakers@web-ster.com@65.182.224.20)
	by magenta.web-ster.com with (DHE-RSA-AES128-SHA encrypted) SMTP
	(a96934d2-6a95-11e4-a8f9-5254004741a3); Wed, 12 Nov 2014 09:59:35 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
In-Reply-To: <20141112075609.GA21485@peff.net>
X-MagicMail-UUID: a96934d2-6a95-11e4-a8f9-5254004741a3
X-MagicMail-Authenticated: bakers@web-ster.com
X-MagicMail-SourceIP: 65.182.224.20
X-MagicMail-EnvelopeFrom: <bakers@canbytel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/11/2014 11:56 PM, Jeff King wrote:
> [+cc git@vger, since this may be of interest to others]
>
> On Tue, Nov 11, 2014 at 02:40:59PM -0800, Scott Baker wrote:
>
> > I'd like to recreate the github style diffs on the command line. It
> > appears that your diff-highlight is very close. The current version only
> > allows you to "invert the colors" which isn't ideal.
>
> Yes, I never built any configurability into the script. However, you can
> tweak the definitions at the top to get different effects.
> Traditionally, ANSI colors on the terminal only came in two flavors:
> "normal" and "bright" (which is attached to the "bold" attribute").
> Instead of reversing video, you can switch on brightness like this:

It's 2014, most terminals are at least 256 colors. I'm fine if the
defaults are 16 colors (that's safest), but it would be really cool if
we could have an option for:

line add color
line remove color
word add color
word remove color

I would then configure appropriate colors from the 256 color palette. I
think the Github style diffs which include the lines/words that are
changed are very readable and make dealing with diffs easier.

-- 
Scott Baker - Canby Telcom 
Senior System Administrator - RHCE
