From: Christian Couder <christian.couder@gmail.com>
Subject: Re: Draft of Git Rev News edition 5
Date: Mon, 6 Jul 2015 21:59:43 +0200
Message-ID: <CAP8UFD2JkPqkXWX0EZFcSx4Dh47Esvrnviv3+DQQgPYTC3DBHQ@mail.gmail.com>
References: <CAP8UFD2fpRiOmgL9GW-1N9ZLAY+p-nOSH-b57vJFO4e_tELrWw@mail.gmail.com>
	<20150705191101.GB9815@flurp.local>
	<xmqqa8v92qdf.fsf@gitster.dls.corp.google.com>
	<CAPig+cTfkDqSDRqDjA=CNkT1c7Fo0zaLiwi2bAbCLZxPHi5=Bg@mail.gmail.com>
	<xmqqfv5118a3.fsf@gitster.dls.corp.google.com>
	<20150706193941.GA1730@flurp.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Thomas Ferris Nicolaisen <tfnico@gmail.com>,
	Nicola Paolucci <npaolucci@atlassian.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Jul 06 21:59:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCCYP-0002uo-Bo
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jul 2015 21:59:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754906AbbGFT7p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jul 2015 15:59:45 -0400
Received: from mail-wg0-f46.google.com ([74.125.82.46]:35978 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751017AbbGFT7o (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jul 2015 15:59:44 -0400
Received: by wguu7 with SMTP id u7so149850934wgu.3
        for <git@vger.kernel.org>; Mon, 06 Jul 2015 12:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=3q+MuDQBL3KddEPOzVnCnHkIVVFgZDweKypY0Vnrlbs=;
        b=PRyxblrbHgBMvTadT970JykRSTl8T+tNbryOQQz1lqdeEBd4MUGTO4DbI+/jzUciET
         4A2GPq2DpbX8p+nMHDvYEvLCQlBXdTLDGZfeDf9fLDRxoJRSBIbrgtSrQKLyqdjSwhbb
         vWC0F4Yb0Fl+/fyTI6vBTR1BaDZEChXJ6RIqLjOvIZGTUKkF1e4gsHEFXIDSLUijMfAH
         RNTZSAdqHvoMD3fz9mIaO0RBk9VwUqBfXaZizXD3KH8MIz02hlI6u+BmUU4gFyyDXtui
         k8rBjq5D40Tia3t06q+W2pCDrj3k8Be7J8XUn2P/OdZTrirR/7gwezx01BgItirsL2f7
         QRuQ==
X-Received: by 10.180.95.10 with SMTP id dg10mr56402676wib.41.1436212783327;
 Mon, 06 Jul 2015 12:59:43 -0700 (PDT)
Received: by 10.194.221.229 with HTTP; Mon, 6 Jul 2015 12:59:43 -0700 (PDT)
In-Reply-To: <20150706193941.GA1730@flurp.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273455>

On Mon, Jul 6, 2015 at 9:39 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Mon, Jul 06, 2015 at 10:54:28AM -0700, Junio C Hamano wrote:
>> Eric Sunshine <sunshine@sunshineco.com> writes:
>> > How about this instead: prefixing with "As originally implemented",
>> > with a couple s/is/was/ thrown in...
>> >
>> >     As originally implemented, creation of linked-worktrees was
>> >     accomplished via `git checkout --to <path> <branch>`, and cleanup
>> >     of leftover administrative files, after `<path>` is deleted, was
>> >     done with `git prune --worktrees`. However, a recent unrelated
>> >     change to `git prune` led to a discussion that concluded that
>> >     worktree-related maintenance functionality didn't belong in `git
>> >     prune`.
>> >
>> > Is that sufficient to clue in the reader that "checkout --to" is not
>> > final form,...
>>
>> Yeah, I think that is a good way to address my concern.
>>
>> The current draft release notes to 2.5 mentions this feature as
>> experimental and warns that its UI is bound to change.  We will
>> ship the upcoming release with "checkout --to" and the more places
>> we advise the users that this UI is not final, the better.
>
> Here it is in patch form. (I wouldn't be surprised if the non-ASCII
> characters in Duy's name in the context line get botched again...)

Ok, the following is merged:

https://github.com/git/git.github.io/pull/87

Thanks both,
Christian.
