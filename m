From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [WIP/PATCH 0/4] Re: Making error messages stand out
Date: Wed, 11 Aug 2010 19:21:52 +1000
Message-ID: <AANLkTi=cNUTG-DGZNpwrag9Wz2-JoQQamiayKVNA5wbn@mail.gmail.com>
References: <20100725005443.GA18370@burratino>
	<AANLkTilnQhsopnuAf0nja8Qq63VrOlt0_uCJrqYv5X-v@mail.gmail.com>
	<201007251122.41166.trast@student.ethz.ch>
	<20100729235151.GB6623@burratino>
	<AANLkTi=ao2RY8NGm4cACqz3_5zfT2zvXB4JHOopBD9T5@mail.gmail.com>
	<20100811083100.GA16495@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	git <git@vger.kernel.org>, Jakub Narebski <jnareb@gmail.com>,
	Jeff King <peff@peff.net>,
	Christian Couder <chriscool@tuxfamily.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 11 11:22:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oj7VW-0003co-Uh
	for gcvg-git-2@lo.gmane.org; Wed, 11 Aug 2010 11:21:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756407Ab0HKJVy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Aug 2010 05:21:54 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:54205 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755578Ab0HKJVx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Aug 2010 05:21:53 -0400
Received: by wwj40 with SMTP id 40so14007913wwj.1
        for <git@vger.kernel.org>; Wed, 11 Aug 2010 02:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=VBlLSWxz4rWYIUXnkPX22dljlX5WJ/aZCobOwWxUpOc=;
        b=LlEhJ6kGH9R5e/ijg7oFLvSZjkS8o7xbtzo0WjDbwl6jHk32Hpe9d9DfOCMgWVWVI6
         hx/ZC3m2t8LfW+0+fFSxjfuv2LoFKYgdgr23qOeQX5AAs7ZSPEvXssuxZrhmJJvu5c1j
         FP9O9/4iRj+TAFzzhRZy8p/SZ0vD7yVd7gVzc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=OEQQnjW9wSWGXGwju4e72wDbMLZ2l68Ngli0WxMLMpVc1NY8THZJkLtf0Eb1ARuJ9V
         L60RZ/ichfNoS/5ZYz983wBiznTO/xXm2J4NnMPRXGyNa+Os9DKXzew8poamWCLQgJl9
         eIZS8wN+heUZNkBCTTYeI9A1ypjLLMi7lbVXw=
Received: by 10.216.10.77 with SMTP id 55mr16477950weu.17.1281518512374; Wed, 
	11 Aug 2010 02:21:52 -0700 (PDT)
Received: by 10.216.173.133 with HTTP; Wed, 11 Aug 2010 02:21:52 -0700 (PDT)
In-Reply-To: <20100811083100.GA16495@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153218>

On Wed, Aug 11, 2010 at 6:31 PM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> Sverre Rabbelier wrote:
>> On Thu, Jul 29, 2010 at 18:51, Jonathan Nieder <jrnieder@gmail.com> =
wrote:
>
>>> though, I find the best solution is to use short, formulaic message=
s:
>>>
>>> =C2=A0...
>>> =C2=A0Recorded resolution for 'dir/a'.
>>> =C2=A0[detached HEAD aa9ae6b] related change
>>> =C2=A0 1 files changed, 1 insertions(+), 1 deletions(-)
>>> =C2=A0fatal: could not apply 649420f... second
>>> =C2=A0hint: after resolving the conflicts, mark the corrected paths
>>> =C2=A0hint: with 'git add <paths>' and run 'git rebase --continue'
>>
>> Yes please. This would be _extremely_ helpful!
>
> Ok. :)
>
> This does not suppress the =E2=80=9CCould not apply=E2=80=9D message =
at the end yet.

Even better, make it available for some time with, say "git hints".
After doing lots of things to resolve conflicts, I simply forget what
it hinted me.
--=20
Duy
