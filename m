From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v3 0/7] New remote-bzr remote helper
Date: Wed, 28 Nov 2012 01:23:29 +0100
Message-ID: <CAMP44s0swzsg1MkQHkPUtwZi71xaad3y4uY542jYvXAf8Ha5nQ@mail.gmail.com>
References: <1352643598-8500-1-git-send-email-felipe.contreras@gmail.com>
	<CAMP44s2F9C4cr6v===M3AWHieaiUk1adigcU8txpZPL0wN81Ow@mail.gmail.com>
	<7v4nkdxawx.fsf@alter.siamese.dyndns.org>
	<CAMP44s1G3b3XQX+=5Ag2exdy83hULbz1m0Z6UFDrhZU2TGwBMg@mail.gmail.com>
	<7vehjelizc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 28 01:23:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdVRJ-0005Av-Hq
	for gcvg-git-2@plane.gmane.org; Wed, 28 Nov 2012 01:23:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752851Ab2K1AXa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2012 19:23:30 -0500
Received: from mail-oa0-f46.google.com ([209.85.219.46]:54529 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752418Ab2K1AX3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2012 19:23:29 -0500
Received: by mail-oa0-f46.google.com with SMTP id h16so13027881oag.19
        for <git@vger.kernel.org>; Tue, 27 Nov 2012 16:23:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=dwmEsd3V+yGPR+skfymYgFy3bnXxt3Naz0UXycn2KzI=;
        b=VAtlOpUjd9JXh8TVoesA6kBUKSSyDxJHpNiv+1wSbl4cfsBvW8y/SCmMELtjYPIpUu
         398f0co0mWaJS51m/xI+WRA034G8QNu2SsjSAcWGAnfS8ZkL9prU8A1LOIsdKfXvjdmE
         ZWzplag8WHJTg3Gc2uTGa+Xe7mJdM4iQK4T4rCri2XQrOruaBc860Fzx6dESp6d7vil6
         d2UBXzBFLmCGhcXl1z3nKVv8cCQl/QRD1G6fvO/A45Ek4MdRkfVc4N+JnAkW00sRgb5J
         nr5Yv3MkTUZRnIa8hSVDKN36x8GVLJ07UdUitKqoWEjegAfJmAd5lulxhfI+edmgCmEn
         /ung==
Received: by 10.60.4.227 with SMTP id n3mr14133744oen.136.1354062209120; Tue,
 27 Nov 2012 16:23:29 -0800 (PST)
Received: by 10.60.32.196 with HTTP; Tue, 27 Nov 2012 16:23:29 -0800 (PST)
In-Reply-To: <7vehjelizc.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210640>

On Wed, Nov 28, 2012 at 12:32 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> On Mon, Nov 26, 2012 at 5:09 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>>
>>>> On Sun, Nov 11, 2012 at 3:19 PM, Felipe Contreras
>>>> <felipe.contreras@gmail.com> wrote:
>>>>> This is a re-roll of the previous series to add support to fetch and push
>>>>> special modes, and refactor some related code.
>>>>
>>>> It seems this one got forgotten, I only see v2 in pu.
>>>
>>> Oops; I think that was fell through the cracks during the maintainer
>>> hand-off.  As the previous one has already been cooking in 'next'
>>> for a week or so, I would appreciate if you send incremental updates
>>> to fix or enhance what is in there.
>>
>> Yes, that's what I have planned for the next patches, as I already did
>> for remote-hg, but the changes in remote-bzr were a bit bigger.
>
> OK.  Both fc/remote-hg and fc/remote-bzr are slated for 'master'
> soonish, but I take the above to mean that fc/remote-hg is ready
> while it is better to wait for updates to fc/remote-bzr before
> merging it.

I was waiting on both to be merged, let me see what I have pending and
would be nice to have before the merge.


-- 
Felipe Contreras
