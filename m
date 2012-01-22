From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [linux.conf.au] VCS Interoperability
Date: Sun, 22 Jan 2012 15:55:34 +0530
Message-ID: <CALkWK0nsO2EBLUrO_iWAdGYpULt=oug4yPDnczX9c44hzdwzqg@mail.gmail.com>
References: <CAFfmPPMH2643JMMZdVbOQJL7DB-DiRYQS8x0TqEaSbGmhMdBNw@mail.gmail.com>
 <CALkWK0kMmDMZ4wiMSmOfwBLzd+xBEA+WKsviu9FVcvj9eZEahg@mail.gmail.com> <CAFfmPPOZfDdH+GF91Dxyy5yfX8TmGDmsbpHz=CVLcBY0c-pCsQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: David Michael Barr <davidbarr@google.com>
X-From: git-owner@vger.kernel.org Sun Jan 22 11:26:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Roud1-0007yM-7A
	for gcvg-git-2@lo.gmane.org; Sun, 22 Jan 2012 11:26:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751046Ab2AVK0H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Jan 2012 05:26:07 -0500
Received: from mail-wi0-f174.google.com ([209.85.212.174]:63366 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751165Ab2AVKZ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jan 2012 05:25:57 -0500
Received: by wics10 with SMTP id s10so1463492wic.19
        for <git@vger.kernel.org>; Sun, 22 Jan 2012 02:25:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Edp+AdWHJXaWAqC5TbBzWHuEm1VU8ubSLi33WJZmk/c=;
        b=xhgY80soA+qLAiyP9amTZzUYHLh2c4Q/d0DdsOUHBHic7yCJ/qMBOzBUAd5siU2lqx
         kTgCncck4p7it1eLirJItewE64V3N64Eh1C/wLYeL6W8XXFEMuGvxHGbZKZ6daES7ORs
         X74WPumdFZcM5DAexC2r9b1o5BX1N5Pul9+to=
Received: by 10.180.109.198 with SMTP id hu6mr7763603wib.16.1327227955279;
 Sun, 22 Jan 2012 02:25:55 -0800 (PST)
Received: by 10.216.51.202 with HTTP; Sun, 22 Jan 2012 02:25:34 -0800 (PST)
In-Reply-To: <CAFfmPPOZfDdH+GF91Dxyy5yfX8TmGDmsbpHz=CVLcBY0c-pCsQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188952>

Hi David,

David Michael Barr wrote:
> Thank you for the feedback, it helped a lot with picking a trajectory.
>
> Video is now available: http://youtu.be/0hVuv-wv4Dw
> Slides: http://barrbrain.github.com/vcs-interoperability.html
>
> It was my first conference presentation so the usual caveats apply.
> I was fortunate to have a small but interested audience.
>
> I look forward to constructive criticism so that I can better represent
> our community to the folk Down Under.

Thanks for the valuable criticism.  A few thoughts:
1. We'll try to fix this over the next few weeks.
2. Subversion's architecture is well-compartmentalized: is this what
leads to communication gaps between the API layers?
3. What are your thoughts on lib'ifying Git so that others can call
into it using an API?

Cheers!
