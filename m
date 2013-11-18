From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH 00/86] replace prefixcmp() with has_prefix()
Date: Mon, 18 Nov 2013 11:42:04 +0100
Message-ID: <CAP8UFD0HjJha7gF7h_S3Hb5ZSqOW0nfHW=G=P6gu0LZaN=hfRQ@mail.gmail.com>
References: <xmqq7gcdgvmf.fsf@gitster.dls.corp.google.com>
	<20131113.074703.1555957018827670255.chriscool@tuxfamily.org>
	<20131113071747.GA31251@sigill.intra.peff.net>
	<20131117.095200.299497690980619465.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Andreas Ericsson <ae@op5.se>, git <git@vger.kernel.org>,
	Avery Pennarun <apenwarr@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jonathan Nieder <jrnieder@gmail.com>, Max Horn <max@quendi.de>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Mon Nov 18 11:42:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ViMHU-0007Jp-Ka
	for gcvg-git-2@plane.gmane.org; Mon, 18 Nov 2013 11:42:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751665Ab3KRKmI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Nov 2013 05:42:08 -0500
Received: from mail-vc0-f173.google.com ([209.85.220.173]:33232 "EHLO
	mail-vc0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751292Ab3KRKmF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Nov 2013 05:42:05 -0500
Received: by mail-vc0-f173.google.com with SMTP id lh4so3478122vcb.18
        for <git@vger.kernel.org>; Mon, 18 Nov 2013 02:42:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=m6X8FotiMGZQzaFu6SsRb9nDfXxYXH9JNDtfzWpzTpw=;
        b=PJ6linPq9/CgeXrTgSoC1AiWoi5E5CmgQ2g+8hcCN4Y5wr2u9et5Y2FBProHnZ1vsy
         TzPEe92R7Khb/laHOeiBLgR0JcS2oZxA6bUD1mBJovdTE4ByDCjX4ceFCJ24nDEkqRWL
         SBw4ihiCJkcEGUy+/et1TflovLPwO+vtltWaZJeXRz+XmvD5fnBgDMoPbffO4pbQNVnC
         FwWfQgiNinFanD7X1zK+sy4MSFGLx6u7LXQ0nEM+vt8zeY3ArJynD5/RtYJMJilIuevx
         x1Cb6EW5FPnB2c3AWu/gZWMxkM2BNe0vvZV4FiaiOlbxOpUJ1At1Rhkt8hrdGbJ2/98Z
         mKuw==
X-Received: by 10.58.136.231 with SMTP id qd7mr14863280veb.1.1384771324154;
 Mon, 18 Nov 2013 02:42:04 -0800 (PST)
Received: by 10.58.253.136 with HTTP; Mon, 18 Nov 2013 02:42:04 -0800 (PST)
In-Reply-To: <20131117.095200.299497690980619465.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237980>

On Sun, Nov 17, 2013 at 9:52 AM, Christian Couder
<chriscool@tuxfamily.org> wrote:
> From: Jeff King <peff@peff.net>
>>
>> On Wed, Nov 13, 2013 at 07:47:03AM +0100, Christian Couder wrote:
>>
>>> My preference is:
>>>
>>> 1) with an "s"
>>> 2) "start"
>>> 3) underscore
>>>
>>> so that gives: starts_with() and ends_with()
>>
>> FWIW, that looks good to me, too. Whether there is confusion over the
>> meaning of "suffix" or not, it makes sense, all other things being
>> equal, to use the same terms as other popular languages.
>>
>> Like you, I prefer "with an s", but we are deep in bikeshedding
>> territory now. I can live with anything. :)
>
> When I prepared a new version of my patch series, this time to rename
> suffixcmp() to ends_with(), it appeared that we already have a static
> ends_with() function in vcs-svn/fast_export.c with another slightly
> different implementation :-)
>
> I will send a new version that will remove this redundant
> implementation.

There is also a new version of my 86 patch long series to replace
prefixcmp() with starts_with() that I am ready to send, but I hesitate
to spam the whole list :-)
I can put it somewhere like GitHub where people can see everything and
perhaps send only a few patches to the list, including the first and
the last.
@Junio, how would you like me to proceed?

Thanks,
Christian.
