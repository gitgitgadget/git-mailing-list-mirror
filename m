From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: GSoC Project | Improvise git bisect
Date: Mon, 21 Mar 2016 12:59:07 +0530
Message-ID: <CAFZEwPNd3X9JocrrJa-d4mV-U_MZdMEq=gMxByZ9iQd6Tz4w2Q@mail.gmail.com>
References: <CAFZEwPN-oUDNnc_PBeP2Q4msJAHenkiLtE+Oo75R+uTTwUKpYQ@mail.gmail.com>
	<vpqoaaahbvi.fsf@anie.imag.fr>
	<CAP8UFD2fudNtGpUHTYjZKXCErocuRS65E=5tH_+_tsNFbmHCBA@mail.gmail.com>
	<CAFZEwPMeejJEMjYbx1sJsH0UNygDEdtNazceOePo81Abi0dHHQ@mail.gmail.com>
	<CAFZEwPP2OLOQanazPXxK1u5GVHzFWqx8GuRad7tLUyHrWR_+Tw@mail.gmail.com>
	<alpine.DEB.2.20.1603201628590.4690@virtualbox>
	<CAFZEwPMEDnzv3mLpULOY=7CQZgULx5QsAb_4Pz40iJWzt9HRGg@mail.gmail.com>
	<alpine.DEB.2.20.1603210814410.4690@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git List <git@vger.kernel.org>,
	Stefan Beller <sbeller@google.com>,
	Lars Schneider <larsxschneider@gmail.com>,
	Jeff King <peff@peff.net>, Troy Moure <troy.moure@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Kevin Daudt <me@ikke.info>,
	Philip Oakley <philipoakley@iee.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Mar 21 08:29:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ahuH4-0004WW-Jt
	for gcvg-git-2@plane.gmane.org; Mon, 21 Mar 2016 08:29:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752569AbcCUH3L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2016 03:29:11 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:34316 "EHLO
	mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751349AbcCUH3I (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2016 03:29:08 -0400
Received: by mail-yw0-f193.google.com with SMTP id f6so16790535ywa.1
        for <git@vger.kernel.org>; Mon, 21 Mar 2016 00:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=zT39hnC/cKOmqg+kjIJDW492FTIOXTaeUJ7vZ/LQYBw=;
        b=SmlROFyD9OyE+Lv/2PBzn/T73w05woPRHIrNTlUc3WMFZZ3QjZu3dhiwXfNcR7vCSQ
         9l6E+sJnz0m2owav7hNd2ZRqBH/qGyRlDViHIPO4PAmOMzx+e2tsztE11d2aXYh9Mp9o
         8yjTdUHdTK17vgWj6cdHbahik+qB6rQeRCdLdXEeweY1zo5Ay8+iTnbejyijtCS9MVEr
         MLou+c5Y2DMJ9r1DOlfk8uzsitjnWz6tcJYQ3FO4rgepUQjxV/UWWPosK0xVHlxLVHL4
         AgTI8LDILilXAdW94Khc4cWAnEZoYTgRahiFbPmvA5ukv6qGi8Yi+seWwTvdhylkdQfX
         mqlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=zT39hnC/cKOmqg+kjIJDW492FTIOXTaeUJ7vZ/LQYBw=;
        b=eVMWUVIAMvXXP9F8sBzO7+XrzKjqQAz5O0uwMhdI+3t1PLNBShUXoH8wjgZFHjwSvs
         ZDg4ZjWcHfotJkgrnrtvcd1snvG6BXwukJm/Hhg2EbqcRx8Rgbpo/gMCaxnB3Mt1zYqY
         4/SVfEvhbhuBRlPdfOdOZK2VIsdRm8/kWc2vM2Q1f2ryCuF09Ev/o7MkzaT5InSIzlMn
         8ev1oqGRgRS631/PUMy95f8NWn5rq/uslcHinXtzcqrT+cil2TPcLPH8HPFQh5d846f9
         UjgwjgDp9uFWZTotDUuLHu+j1NZ7dukPnXyQd9qws2aEe2GDN10a8RaGgYGd9i1gmE8T
         uE1A==
X-Gm-Message-State: AD7BkJJdMDk9Jk5yKLw0t/snoYyqRDxFySiKY+dWwkSvf82LGsnIbAKckzHzs6Tz/t7x1TvDHOrkPFqIpFBGFQ==
X-Received: by 10.129.9.214 with SMTP id 205mr12297026ywj.53.1458545347362;
 Mon, 21 Mar 2016 00:29:07 -0700 (PDT)
Received: by 10.13.203.137 with HTTP; Mon, 21 Mar 2016 00:29:07 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1603210814410.4690@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289407>

On Mon, Mar 21, 2016 at 12:48 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi Pranit,
>
> On Sun, 20 Mar 2016, Pranit Bauva wrote:
>
>> I could first move individual functions to bisect--helper.c.
>
> My suggestion would be to give it a try already with some functionality
> you deem small enough to move to the bisect--helper within a day or so. It
> is always good to test the waters like that, and to include this early
> work in the proposal, also to assess (and to let the reviewers assess) how
> feasible the project is.

Sure! I will start with check_term_format().

Also, I think implementing a new algorithm for bisect along with this
would be too big for a GSoC project and I am no algorithm expert. I
will stick to --first-parent along with incremental rewrite.
