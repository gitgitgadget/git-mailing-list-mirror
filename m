From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: push.default documented in "man git-push"?
Date: Mon, 8 Oct 2012 15:35:57 +0700
Message-ID: <CACsJy8B9V2xASOkTF8doORPMhOMYTkuCBk9395fESpg5Awoy-Q@mail.gmail.com>
References: <CAN7QDoK4WCuRMu+KV6ACo9miR9_eFEE510J5PDiPk+BXLyQG9Q@mail.gmail.com>
 <CALkWK0mxLQNOE8kZUJrxYQMWXpzZW0uS+N2iGXxdRmCXTzYcBQ@mail.gmail.com>
 <CACsJy8B7Z4kVYax4igYQ-d8q6e+GrPL3UwzhHSYbJ5Qo0TiL-w@mail.gmail.com>
 <CALkWK0kKzt8ii-+O0zRM1JLenP+XKh-2Wv_v6zXkkcvTGQ2MQg@mail.gmail.com>
 <CACsJy8BB4WM1Lqz4yCGnGN2DV1Xsip3Qzh86ibBXwt2BnaNENA@mail.gmail.com>
 <CALkWK0=N0OwTyu1KDAKzM48ioevGtmMNgy5gfK2J78zSPx7CVA@mail.gmail.com>
 <CACsJy8APN-CdBZgLzuNWAa5ArR2gkcStY4GZ=79fU7sGT9pOMw@mail.gmail.com>
 <7v7gr75s40.fsf@alter.siamese.dyndns.org> <CALkWK0m0ZzOmwFxAt40gHXi98JEq+==9ctiLYVYf4UE5GB+V8A@mail.gmail.com>
 <7v7gr2qb7q.fsf@alter.siamese.dyndns.org> <CALkWK0=gYFuLBfWBiXcw=1Be9nYgRJgFSSDSbvwxPnttHqAFew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	David Glasser <glasser@davidglasser.net>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 08 10:36:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TL8pL-0001ae-4y
	for gcvg-git-2@plane.gmane.org; Mon, 08 Oct 2012 10:36:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753807Ab2JHIg3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Oct 2012 04:36:29 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:63321 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752712Ab2JHIg1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Oct 2012 04:36:27 -0400
Received: by mail-ie0-f174.google.com with SMTP id k13so8508048iea.19
        for <git@vger.kernel.org>; Mon, 08 Oct 2012 01:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=G4DvPmmOefXUDGoWvAuwwJcKYc+NOg22o0lmcvqZLS4=;
        b=a6HPqANe325NQ2ijcevFG7uJjGgig3wCQ+LmZzAbpCKI3JKBoB2r0iKAiTh+jrPhE7
         couYjNLvIpFMcxvGEtsSffmcK2Xj8kAn7EIVz1VGaLj/bFW8vnjoHsvpiT/iXFeS90La
         uS0dI87IPHT3kiCOKfsZo112sxaap1yOuH+cH5Va41UEBwV1AzH+8VvbbGxrU+y0mZBq
         3HwPVdTXlHonD3fJvSo3HTKSHT5kFrOZ8e40VDqiny8FRPv33DXHfDzVr+880Pl/LSbB
         gH1M7wxjwldGwIkuvtmIHU8FtjjreOLNzoan2t4XkUA9sgp7/gwoGPHoSnQq6pyixzBg
         UPUA==
Received: by 10.50.153.130 with SMTP id vg2mr5187046igb.26.1349685387463; Mon,
 08 Oct 2012 01:36:27 -0700 (PDT)
Received: by 10.64.143.168 with HTTP; Mon, 8 Oct 2012 01:35:57 -0700 (PDT)
In-Reply-To: <CALkWK0=gYFuLBfWBiXcw=1Be9nYgRJgFSSDSbvwxPnttHqAFew@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207226>

On Mon, Oct 8, 2012 at 2:27 PM, Ramkumar Ramachandra <artagnon@gmail.com> wrote:
> Should we replicate the description from git-config[1]?  That seems
> like a waste.

I think Jeff's suggestion [1] of moving config bits from
git-config.txt to git-*.txt makes sense. But that seems a big task.
We'll need to figure out how to groups config keys in separate
config-*.txt then include them in relevant commands' man page and
config.txt (or just "see also" in config.txt). Maybe we can try it
with push config first?

[1] http://thread.gmane.org/gmane.comp.version-control.git/206780/focus=206939
-- 
Duy
