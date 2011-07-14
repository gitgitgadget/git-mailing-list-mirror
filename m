From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [PATCH 1/3] implement generic key/value map
Date: Thu, 14 Jul 2011 20:54:07 +0200
Message-ID: <CAKPyHN3G41iMGmGgp6jTcWN=Rxt=RTUS7ktgVDhZEXPBRXvTDQ@mail.gmail.com>
References: <20110714173454.GA21657@sigill.intra.peff.net>
	<20110714175105.GA21771@sigill.intra.peff.net>
	<CAKPyHN0-VbzjMaMJFZeGGrGX6HuGNEBHNVNf0cexB2vu21_13g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>, "Ted Ts'o" <tytso@mit.edu>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Clemens Buchacher <drizzd@aon.at>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	David Barr <davidbarr@google.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jul 14 20:54:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QhR38-0003QF-BG
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jul 2011 20:54:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932202Ab1GNSyJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jul 2011 14:54:09 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:45730 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932078Ab1GNSyI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2011 14:54:08 -0400
Received: by vws1 with SMTP id 1so400639vws.19
        for <git@vger.kernel.org>; Thu, 14 Jul 2011 11:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=p1HCtrbod/cX6arhYCgIxnbxUG/sS0cind58TNvR3bg=;
        b=CCjTAF3CEfMeOeFGdIL4T5uCMDhfD6zkIivb+wmXq8PMWvl8xs64dN5VLhDLtWaVRk
         KOg35ckq5i09r6lzL3QdaIceAMt3kWUqGxLFYYHW7ivWp9XHQBuhpFjRD+28P0f5XnV4
         7nQt9UH7FHMUj9FMxYzDyK2bZQOnF0zdw0Lqk=
Received: by 10.52.72.161 with SMTP id e1mr2945341vdv.195.1310669647502; Thu,
 14 Jul 2011 11:54:07 -0700 (PDT)
Received: by 10.52.107.228 with HTTP; Thu, 14 Jul 2011 11:54:07 -0700 (PDT)
In-Reply-To: <CAKPyHN0-VbzjMaMJFZeGGrGX6HuGNEBHNVNf0cexB2vu21_13g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177154>

On Thu, Jul 14, 2011 at 20:52, Bert Wesarg <bert.wesarg@googlemail.com> wrote:
> On Thu, Jul 14, 2011 at 19:51, Jeff King <peff@peff.net> wrote:
>> +#define MAP_IMPLEMENT(name, ktype, vtype, cmp_fun, hash_fun) \
>
> This define should probably in the header too. Else this is completely useless.

Ahh. One have to read patch 2/3, to see how to use this. Please feel
free to ignore this than.

>
> Bert
>
