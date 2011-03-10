From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Summer of Code project ideas due this Friday
Date: Thu, 10 Mar 2011 09:31:23 -0800
Message-ID: <AANLkTinv-CQ4TKQu8T8o6K5aJ3ivdrScPN0shF=ma9Oz@mail.gmail.com>
References: <AANLkTinpVKBjcqxaCGH0vp82kpKsO2uCBPdMoMKco6Ex@mail.gmail.com>
 <20110303185918.GA18503@sigill.intra.peff.net> <AANLkTinXZDq5FJxMmxUuWpCGgMYb3HH774eLJCojmnOz@mail.gmail.com>
 <20110303203323.GA21102@sigill.intra.peff.net> <20110309174956.GA22683@sigill.intra.peff.net>
 <AANLkTinpAOE06YX-m=ptQM_y-QMGpVmjewDxWopkXJkQ@mail.gmail.com>
 <20110309215841.GC4400@sigill.intra.peff.net> <20110310001017.GA24169@elie> <20110310163011.GA17137@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@student.ethz.ch>, git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 10 18:32:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PxjiM-0007G3-AO
	for gcvg-git-2@lo.gmane.org; Thu, 10 Mar 2011 18:31:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753833Ab1CJRbt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Mar 2011 12:31:49 -0500
Received: from mail-qy0-f181.google.com ([209.85.216.181]:46264 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753708Ab1CJRbs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Mar 2011 12:31:48 -0500
Received: by qyg14 with SMTP id 14so1662853qyg.19
        for <git@vger.kernel.org>; Thu, 10 Mar 2011 09:31:47 -0800 (PST)
Received: by 10.52.0.107 with SMTP id 11mr242222vdd.236.1299778306554; Thu, 10
 Mar 2011 09:31:46 -0800 (PST)
Received: by 10.52.162.33 with HTTP; Thu, 10 Mar 2011 09:31:23 -0800 (PST)
In-Reply-To: <20110310163011.GA17137@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168836>

On Thu, Mar 10, 2011 at 08:30, Jeff King <peff@peff.net> wrote:
>
>> 7. packfilev4.
>
> I suspect that is too complex for a SoC project. But you never know.

It is. Nico is also probably working on it.

My big concern with pack v4 right now is the on-disk format of
commits/trees is different from the current wire protocol. If a pack
v2 only client connected to a server using pack v4, the server would
have to spend a lot of time to inflate/deflate about 60% of the
objects in the repository (commits and trees). That is a lot of CPU
time. So even if a SoC-er finished the work, it probably wouldn't be
merged because of this penalty.

-- 
Shawn.
