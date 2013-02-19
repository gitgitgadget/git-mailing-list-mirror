From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Google Summer of Code 2013 (GSoC13)
Date: Mon, 18 Feb 2013 23:25:12 -0800
Message-ID: <20130219072512.GI19757@elie.Belkin>
References: <87ehgd1qq2.fsf@pctrast.inf.ethz.ch>
 <20130218174239.GB22832@sigill.intra.peff.net>
 <CALkWK0nDEwgDwnVktmM8abv3ZgQmJCOm8LBe25UKR485PZMPfA@mail.gmail.com>
 <7vip5p9rtm.fsf@alter.siamese.dyndns.org>
 <CALkWK0=s4XX0mmUTAcNBHyqdrryhMYvhtrNZCFFccJJBUUVdUg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, Jeff King <peff@peff.net>,
	Thomas Rast <trast@inf.ethz.ch>, git@vger.kernel.org,
	Shawn Pearce <spearce@spearce.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Pat Thoyts <patthoyts@users.sourceforge.net>,
	Paul Mackerras <paulus@samba.org>,
	Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	Thomas Gummerer <t.gummerer@gmail.com>,
	David Barr <b@rr-dav.id.au>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 19 08:25:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7haA-0006M5-PC
	for gcvg-git-2@plane.gmane.org; Tue, 19 Feb 2013 08:25:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756827Ab3BSHZT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2013 02:25:19 -0500
Received: from mail-pb0-f45.google.com ([209.85.160.45]:52148 "EHLO
	mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756548Ab3BSHZS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2013 02:25:18 -0500
Received: by mail-pb0-f45.google.com with SMTP id ro8so2096925pbb.32
        for <git@vger.kernel.org>; Mon, 18 Feb 2013 23:25:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=tYVYbNMnWSvEI5CzpJfMZYdBIxFC9EHUl5f1rUOt1es=;
        b=YvaqHB9NNQS5YMFoldd0VoE+zGp8pfFi0zUG2+eL7AgwlZhMkwXNjXbwZhRitZMqSP
         ejshQEKtCtAF2XOwduHYr8eBsmnNaDKr/CChbhjN8bdwrFZXnhA6/LQoT4XWYyZxn2sU
         yAS+ql71NHlKJCAdurNCA9FH8rtI6TPgR5r13+UPbW1NEgpVDhQgQsLzo1Yodq/LVHcd
         EaMPfmGeuf7HSVfz5HzFtf1fUAtnaYnCmnNXfgn84LLWy/On4DRfeAgu8etpnYSW2c0h
         v+Dt6WVuUNMDRO5nbnwrK8KMYImVKnonUPiUYv4BL3cZuYwqwhsrX7Y2BtaL3o4xQ8wx
         TyIA==
X-Received: by 10.66.85.161 with SMTP id i1mr42799559paz.67.1361258717764;
        Mon, 18 Feb 2013 23:25:17 -0800 (PST)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id g4sm14245892pax.4.2013.02.18.23.25.14
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 18 Feb 2013 23:25:16 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CALkWK0=s4XX0mmUTAcNBHyqdrryhMYvhtrNZCFFccJJBUUVdUg@mail.gmail.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216569>

Ramkumar Ramachandra wrote:

> The short undiplomatic version of that is that our mentors suck (I'm
> not pointing fingers, but that's what I infer from failing projects).

Hold on a second.  I'm not remembering such a grim outcome with 100%
failure from prior summers of code as you're describing.  Before I
start beating myself up, I guess I'd like a little more information
--- is there some specific project or statistic that you're thinking
of that brings you to that conclusion?

[...]
> I propose that we have one thread for every proposal where we can all
> discuss the implementation outline- this will serve as authoritative
> source of information for students, and for picking mentors (the
> people who contribute most to the discussion).  Students should be
> matched with mentors on an individual basis.

How is that different from what happened in previous summers where
students made proposals, received feedback, and were accepted and
matched to mentors or rejected based on how the discussion went?

Jonathan
