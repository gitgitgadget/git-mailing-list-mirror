From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 00/18] GSoC update: Sequencer for inclusion v3
Date: Thu, 28 Jul 2011 21:56:08 +0530
Message-ID: <CALkWK0kWtdHD2JF+sP8ox96jPncZagQpHzu3vvggyEFO3D2ryw@mail.gmail.com>
References: <1311736755-24205-1-git-send-email-artagnon@gmail.com> <7vfwlrmisu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 28 18:26:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QmTPu-0003lu-EP
	for gcvg-git-2@lo.gmane.org; Thu, 28 Jul 2011 18:26:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755172Ab1G1Q0a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jul 2011 12:26:30 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:36487 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754563Ab1G1Q03 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2011 12:26:29 -0400
Received: by wyg8 with SMTP id 8so259446wyg.19
        for <git@vger.kernel.org>; Thu, 28 Jul 2011 09:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=SaceZeWuQ3ACCufT76CeBHdcm+3TCTs/v5DWSBTpUDo=;
        b=fbjeH+SEPljL9mGXtWwSTxvUv3cms4PfspOJUet3kFFB3Aivnozcah1aQjaU1WgSPe
         DrQ1HuJwnLVdGcSdTgN/5Cx8lQDVpvz+yl9+PEv/KWrN2zUJ8eb3RiPZwIz56uRiKG4w
         OqC8t5WZjFnnIfKrfXCtcqI126LsmFpxTAIvc=
Received: by 10.227.152.146 with SMTP id g18mr231421wbw.79.1311870388041; Thu,
 28 Jul 2011 09:26:28 -0700 (PDT)
Received: by 10.216.137.134 with HTTP; Thu, 28 Jul 2011 09:26:08 -0700 (PDT)
In-Reply-To: <7vfwlrmisu.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178076>

Hi Junio,

Junio C Hamano writes:
> As I already said in the earlier "What's cooking" message, this series is
> getting very closer, and the difference between the last round and this
> seems to be just "allow explicit file to be given to the config writer"
> (with help from Peff) which is very good, and "remove 'Please, do this'".

Right, and some minor commit message improvements.

> Both of which are good. I offhand do not recall if there were other issues
> raised in the previous review round.

No other issues were raised.  I've taken care of all the issues that
were raised by you and Jonathan this iteration too, with a couple of
exceptions:
1. "revert: Remove sequencer state when no commits are pending" isn't
very elegant.  I've decided that the right way to fix this is to
increase the coupling between "git commit" and the sequencer -- I
think this can wait.
2. Jonathan suggested some improvements to "git checkout" behavior in
"reset: Make reset remove the sequencer state".  I think this can wait
too.

Do you think the series is alright otherwise?  I'll post another
iteration of the sequencer momentarily.

Thanks.

-- Ram
