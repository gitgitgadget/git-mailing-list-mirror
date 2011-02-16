From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: non-empty index with git commit -a
Date: Wed, 16 Feb 2011 15:29:19 +0700
Message-ID: <AANLkTikmxHQpir5YbiBihASL1SYf_AyoUHKT3nqKS-iP@mail.gmail.com>
References: <AANLkTi=5E8D0mwMDNuMdgZS69kOnKCfs=Q8X5bpcjnYF@mail.gmail.com>
 <20110216023645.GA7085@sigill.intra.peff.net> <20110216032047.GA2858@elie> <AANLkTinbcHW+ja7T=PiCEorNdnK6W2DvA_c9F8JTEMKB@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>,
	Git List <git@vger.kernel.org>,
	Jakub Narebski <jnareb@gmail.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 16 09:30:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ppclp-0002C8-1Y
	for gcvg-git-2@lo.gmane.org; Wed, 16 Feb 2011 09:29:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753360Ab1BPI3w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Feb 2011 03:29:52 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:39352 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750840Ab1BPI3v (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Feb 2011 03:29:51 -0500
Received: by wyb28 with SMTP id 28so1070491wyb.19
        for <git@vger.kernel.org>; Wed, 16 Feb 2011 00:29:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=1wqiNVVH4/+evewApb6Ukn9DeGw02j6jYJB8eAD7u9I=;
        b=aioXwywh906+E7wRTjzytu6g8EEb0TTZQPuR6tP+MoLcKyx/yIkVUQrJ6pkjM0mxfC
         6WGepkJqhO6wm868y5gbk9SFJyJOzkvmI3sj3xI8dmazx4jBEVEQMp1X77ecqnk0J0Fr
         /gi/HW6dkrNu4N+dg4PChJzuISSLZLYrQruCc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=AYiEihINd79x4P0qYqK70cL2cRXwjibwRNbHwzHC0uemVoMI9kaypMPpdfyP7t5zkG
         I+OmLhqWum6YqQyAxIHjwDTewxYmsmfgExC4Vhsh6P8v5PrQ2Ye4C9CSPOCyOHfC6dcS
         RgjLBcdcs1x3KUdgfnmmwqgHK4t3ka1yPxY7c=
Received: by 10.216.89.71 with SMTP id b49mr233018wef.28.1297844989783; Wed,
 16 Feb 2011 00:29:49 -0800 (PST)
Received: by 10.216.66.144 with HTTP; Wed, 16 Feb 2011 00:29:19 -0800 (PST)
In-Reply-To: <AANLkTinbcHW+ja7T=PiCEorNdnK6W2DvA_c9F8JTEMKB@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166930>

On Wed, Feb 16, 2011 at 3:18 PM, Sverre Rabbelier <srabbelier@gmail.com> wrote:
> Heya,
>
> On Wed, Feb 16, 2011 at 03:20, Jonathan Nieder <jrnieder@gmail.com> wrote:
>> If I remember the discussion[1] correctly, by requiring a separate
>> add -u step (or commit -f -a) if the "I don't trust my fingers"
>> configuration is enabled.
>
> That would definitely work for me. The question then is, should git
> consider the index precious by default, or not? That is, should that
> value default to true in 1.8?

Is it insane that "git commit -a" still commits everything, but then

1. If old index is different from old HEAD, keeps index as is and warn users
2. If old index is the same as old HEAD, update index with new HEAD

?
-- 
Duy
