From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v4 00/13] New remote-hg helper
Date: Mon, 29 Oct 2012 22:47:04 +0100
Message-ID: <CAMP44s3L0ycSQFU9s157V7e-GryUdojtQ3Vk_-d2wtPf9NFtbg@mail.gmail.com>
References: <1351396453-29042-1-git-send-email-felipe.contreras@gmail.com>
	<20121029085045.GA5023@sigill.intra.peff.net>
	<CAMP44s0RVe6i4DpNmaV_n7_5KO_aq2WxCPVafjsTukExRSR5Jw@mail.gmail.com>
	<20121029212643.GA20513@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Oct 29 22:47:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TSxB5-00012i-0x
	for gcvg-git-2@plane.gmane.org; Mon, 29 Oct 2012 22:47:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933167Ab2J2VrI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Oct 2012 17:47:08 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:33460 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933001Ab2J2VrF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Oct 2012 17:47:05 -0400
Received: by mail-oa0-f46.google.com with SMTP id h16so5189526oag.19
        for <git@vger.kernel.org>; Mon, 29 Oct 2012 14:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=uL7ZCoo7q41lvgYUvFS5LeBiy4DSeATduFA9AST/vn0=;
        b=bwlrHvmI3xgdhlaPh5lKHUFygZnaTE05gb7nRzG5mgnoFbNKUOMzeb7NCGb1uxAgVv
         AuHS/nZACEvLq1PwdcJOp6FskjQqIfvMHLtdGAHBfeC3nhNxmS8vsuTJ+t6SD86v+hv3
         Ei7Tr2SHvN9M1Phf18VH1J+ojoxsLoxNEPgpBkoXP4hSq1WQf9utldWtkTkoQnkVCyA/
         hUPkdT+uONnGSf2zoqTtc5Gv/6elRT8UWmwr67f0FFnU7cRC14todQW9f1Eu5p9pXxEp
         huhFQ3asIk+XYzohSBG6sCO7v89gEs06adMKRBY7qoBNK3xLY4CkkactDDMit9+xkpW5
         fh8A==
Received: by 10.182.116.6 with SMTP id js6mr25776471obb.82.1351547224546; Mon,
 29 Oct 2012 14:47:04 -0700 (PDT)
Received: by 10.60.4.74 with HTTP; Mon, 29 Oct 2012 14:47:04 -0700 (PDT)
In-Reply-To: <20121029212643.GA20513@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208641>

On Mon, Oct 29, 2012 at 10:26 PM, Jeff King <peff@peff.net> wrote:
> On Mon, Oct 29, 2012 at 03:56:39PM +0100, Felipe Contreras wrote:
>
>> >> I've ported the tests from hg-git and made sure that the output from remote-hg
>> >> matches the output of hg-git. With these extensive tests I would consider this
>> >> one ready for wide use. Not only do the tests pass, I've compared the generated
>> >> repos of a few projects, and the SHA-1's are exactly the same :)
>> >
>> > Sounds cool. Unfortunately, the test script hangs for me, after starting
>> > up xxdiff (!).
>> >
>> > pstree reveals that it is "hg" that starts it, but I didn't investigate
>> > beyond that.
>>
>> Yeah, the test script is not ready for merging, it needs to check for
>> python, hg, and hg-git.
>>
>> Do you have hg-git installed?
>
> No. But it's important that it fail gracefully; I can't even take it in
> pu if I can't run the test suite in a sane way.

The contrib part is fine for 'pu'. The tests aren't even meant to
exercise stuff in 'contrib', right? There might be some exceptions,
but either way, there's plenty of stuff in 'contrib' without any
tests. The tests I'm providing are simply a little sugar.

-- 
Felipe Contreras
