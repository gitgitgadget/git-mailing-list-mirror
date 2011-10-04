From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH/RFC] remote: support --all for the prune-subcommand
Date: Tue, 4 Oct 2011 09:10:40 +0200
Message-ID: <CABPQNSZrfxhyA3em8TN2=d7pAHopZMgRg47baKnDT9h14=rxkA@mail.gmail.com>
References: <1317644168-5808-1-git-send-email-kusmabite@gmail.com> <20111004070006.GA6824@sigill.intra.peff.net>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Oct 04 09:11:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RAz9x-0003g5-L8
	for gcvg-git-2@lo.gmane.org; Tue, 04 Oct 2011 09:11:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754497Ab1JDHLV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 4 Oct 2011 03:11:21 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:41317 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754027Ab1JDHLV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Oct 2011 03:11:21 -0400
Received: by pzk1 with SMTP id 1so592271pzk.1
        for <git@vger.kernel.org>; Tue, 04 Oct 2011 00:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=B3wflnS27fYWD1MnRF8yomb+ipDH4Xy1zR/u8FWojtk=;
        b=r6NnA+3x//2kkR/l1G1jMLV/evWmr4OjFyj7XzimGWJt/Vhh0D6XKGSu6S5zuI+aiX
         E0MutlWEYcIgr8hadr/C3+pXkz55IpHn0YUqyoIhW5ML+fbJ6cm+AkId9cZxDvxRuuck
         6n+/DZFbBnKqA/4YYg/zk8C5RxdM5iEkH8k+M=
Received: by 10.68.16.65 with SMTP id e1mr7623767pbd.27.1317712280816; Tue, 04
 Oct 2011 00:11:20 -0700 (PDT)
Received: by 10.68.42.169 with HTTP; Tue, 4 Oct 2011 00:10:40 -0700 (PDT)
In-Reply-To: <20111004070006.GA6824@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182731>

On Tue, Oct 4, 2011 at 9:00 AM, Jeff King <peff@peff.net> wrote:
> On Mon, Oct 03, 2011 at 02:16:08PM +0200, Erik Faye-Lund wrote:
>
>> I recently needed to prune remote branches in a repo with a lot
>> of remotes, and to my surprise "git remote prune" didn't support
>> the --all option. So I added it. Perhaps this is useful for other
>> people as well?
>
> You could do:
>
> =A0git remote update --prune
>
> But I thought we were trying to get away from remote doing fetch-like
> things in the long term. Isn't the "right" way to do this these days:
>
> =A0git fetch --all --prune
>
> ?
>
> -Peff
>

I wasn't aware that fetch could prune, but yeah, that seems much
better to me. Perhaps a mention of this in the "git remote prune"
documentation could steer other users in the right direction?
