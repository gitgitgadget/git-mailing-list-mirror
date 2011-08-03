From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v13 5/8] bisect: introduce --no-checkout support into porcelain.
Date: Wed, 3 Aug 2011 21:41:10 +0200
Message-ID: <201108032141.10618.chriscool@tuxfamily.org>
References: <1312284545-2426-1-git-send-email-jon.seymour@gmail.com> <CAP8UFD3QvXv_gnAtw3qMCOdDyAUAFMYcf33ieP+HebvTf3SGAg@mail.gmail.com> <CAH3Anro1Hs5VBT9901PoDdhGjtzTEZHWd9hgHvjfB_ivSErHMw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com, j6t@kdbg.org, jnareb@gmail.com
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 03 21:41:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QohJu-0002HB-H3
	for gcvg-git-2@lo.gmane.org; Wed, 03 Aug 2011 21:41:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755497Ab1HCTlW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Aug 2011 15:41:22 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:32920 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754854Ab1HCTlT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2011 15:41:19 -0400
Received: from style.localnet (unknown [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 0321DA6269;
	Wed,  3 Aug 2011 21:41:11 +0200 (CEST)
User-Agent: KMail/1.13.6 (Linux/2.6.38-8-generic; KDE/4.6.2; x86_64; ; )
In-Reply-To: <CAH3Anro1Hs5VBT9901PoDdhGjtzTEZHWd9hgHvjfB_ivSErHMw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178615>

On Wednesday 03 August 2011 17:13:13 Jon Seymour wrote:
> On Thu, Aug 4, 2011 at 12:09 AM, Christian Couder
> <christian.couder@gmail.com> wrote:
> > On Wed, Aug 3, 2011 at 3:24 PM, Jon Seymour <jon.seymour@gmail.com> wrote:
> >> Mmmm.
> >> 
> >> Actually, there is a neater way to do this.
> >> 
> >> I'll such use the existence of BISECT_HEAD to inform the
> >> implementation of bisect_mode().
> >> 
> >> This avoids the need for a separate .git/BISECT_MODE file.
> > 
> > Yeah, but then you have to be careful of the fact that BISECT_HEAD
> > might have not been properly deleted or might have been created by the
> > user for other purposes.
> 
> I have removed $GIT_DIR/BISECT_MODE in v15.
> 
> If BISECT_HEAD was being used for other purposes, it is going to get
> deleted anyway, irrespective of whether we have a separate BISECT_MODE
> file, so I am not sure we need to consider that when deciding when we
> need a separate BISECT_MODE file.

Yeah, I was probably worrying too much.

> FWIW: bisect_mode() was only going to get called from one place so I
> just inlined the implementation in that place. (on the call to
> bisect--helper).

Ok.

Thanks,
Christian.
