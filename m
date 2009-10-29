From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: [PATCH 1/3] add splash screen
Date: Wed, 28 Oct 2009 22:25:05 -0400
Message-ID: <4AE8FD01.3070009@gmail.com>
References: <20091029002229.GA986@sigill.intra.peff.net> <20091029002400.GA1057@sigill.intra.peff.net>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Oct 29 03:25:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3KhU-0003ls-2V
	for gcvg-git-2@lo.gmane.org; Thu, 29 Oct 2009 03:25:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756191AbZJ2CZI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2009 22:25:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756189AbZJ2CZI
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Oct 2009 22:25:08 -0400
Received: from mail-yx0-f187.google.com ([209.85.210.187]:59673 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754942AbZJ2CZH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2009 22:25:07 -0400
Received: by yxe17 with SMTP id 17so1290976yxe.33
        for <git@vger.kernel.org>; Wed, 28 Oct 2009 19:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id
         :disposition-notification-to:date:from:reply-to:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=+hMhVfyRfVIGZT1uj2N3exjbqhzBW7yb+AheTSDGfI4=;
        b=D+YjiA/KWCIrF8sKH44nHTABpAGp2XcygMAHWtCt3H+YUhUUXwfHL7WjYyCjlB53YR
         jAdP1GJFoSkFXfxS4umrTGvWT60+m/aRYV0pYnr+yatCreGGThDhOXMDAYLdr4muy1I3
         V/6XQu9jWIHumv7BHKQ7RRqWe9J6uuxU4l9/s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:disposition-notification-to:date:from:reply-to
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        b=Q68M5aD5u0FEedom/u3G5dAgxsbERWvaWyd0mXQfxTY5xETRnLUtJvW4Tn8GMxoNKL
         wnV2dT03cpwjlEj7g5d3ILFCgL5HYZu2JGY/qbjvZEwT4rP4PF/XMPttHuujOTryYRm0
         UuUQjD3fk2fqhbJ4vR+y/nw6spnXPx0Yz438I=
Received: by 10.150.236.18 with SMTP id j18mr2125389ybh.110.1256783111567;
        Wed, 28 Oct 2009 19:25:11 -0700 (PDT)
Received: from ?10.0.0.6? (c-71-199-240-201.hsd1.fl.comcast.net [71.199.240.201])
        by mx.google.com with ESMTPS id 20sm580190ywh.32.2009.10.28.19.25.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 28 Oct 2009 19:25:11 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.10 (X11/20060911)
In-Reply-To: <20091029002400.GA1057@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131549>

Jeff King wrote:
> Because bash completion is so slow to start, we need to
> entertain users with a splash screen, so reuse the one from
> git-gui.
> 
> Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>
> Signed-off-by: Sam Vilain <sam@vilain.net>
> Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
> Signed-off-by: Nick Edelen <sirnot@gmail.com>
> Signed-off-by: "J.H." <warthog9@kernel.org>
> Signed-off-by: Brandon Casey <drafnel@gmail.com>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  .gitignore    |    1 +
>  Makefile      |    3 +++
>  git-splash.sh |    4 ++++
>  git.c         |    6 ++++++
>  4 files changed, 14 insertions(+), 0 deletions(-)
>  create mode 100644 git-splash.sh
> 

If you're going to assume that the user has a working network connection 
for every git command invoked for part 3 of this series, why not get the 
logo image from kernel.org also so you always have the most up-to-date logo?
