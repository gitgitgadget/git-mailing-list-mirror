From: =?UTF-8?Q?Vicent_Mart=C3=AD?= <tanoku@gmail.com>
Subject: Re: [PATCH 0/5] fix up 'jk/pack-bitmap' branch
Date: Fri, 8 Nov 2013 02:39:12 +0100
Message-ID: <CAFFjANR-4x4qDoRQtDLyd8VnpeQBDsg3mNh+tV87E-ZHDqnxSA@mail.gmail.com>
References: <527C0CEA.4020705@ramsay1.demon.co.uk> <20131107221944.GA19238@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	GIT Mailing-list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Nov 08 02:39:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Veb2w-0001Zk-AF
	for gcvg-git-2@plane.gmane.org; Fri, 08 Nov 2013 02:39:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753150Ab3KHBje (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Nov 2013 20:39:34 -0500
Received: from mail-ve0-f179.google.com ([209.85.128.179]:45550 "EHLO
	mail-ve0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751692Ab3KHBjd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Nov 2013 20:39:33 -0500
Received: by mail-ve0-f179.google.com with SMTP id cz12so1012016veb.24
        for <git@vger.kernel.org>; Thu, 07 Nov 2013 17:39:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=fwUf1jeB83knz7x+nasHLZ9bcLxEusNRzCXZ76o5Alo=;
        b=gKgoCM2zmm2XvP33C9g4TiWBahsmhgqXK/PAaQfHB5SfZ+/T+bjJPOrZ6x12+4Lk5W
         zXsp5L4ESJu8kMPGKEW1oIPl3uuTuHGjuBQWSF2+YV2do7z1aRyq0C2seOkCl0yC8prr
         2fwgNxVUmKNK2+8o+yqkaBtt6rJ7fdJCXkYo4yWEZI9XfTveNGab9cp3OplVBCjothqs
         H07GILU20PgE2DdTv8oRx8A+gXGFbueIm8H7yDQWGJGBAX2QPf3WfZPMWnY+ahRHHkjx
         fCbCa0oe0zOkIPbzpaOdu8j+4PpxSrFOuzws+wNgSxQ68CJK9js0J4SVvYdV5c8Q1dAg
         KZ0g==
X-Received: by 10.58.178.239 with SMTP id db15mr9487230vec.9.1383874772452;
 Thu, 07 Nov 2013 17:39:32 -0800 (PST)
Received: by 10.221.65.202 with HTTP; Thu, 7 Nov 2013 17:39:12 -0800 (PST)
In-Reply-To: <20131107221944.GA19238@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237447>

Thank you Ramsay, all the patches look OK to me.

On Thu, Nov 7, 2013 at 11:19 PM, Jeff King <peff@peff.net> wrote:
> On Thu, Nov 07, 2013 at 09:58:02PM +0000, Ramsay Jones wrote:
>
>> These patches fix various errors/warnings on the cygwin, MinGW and
>> msvc builds, provoked by the jk/pack-bitmap branch.
>
> Thanks. Your timing is impeccable, as I was just sitting down to
> finalize the next re-roll. I'll add these in.
>
> -Peff
