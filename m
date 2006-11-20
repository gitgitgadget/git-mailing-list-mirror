X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Petr Baudis <pasky@suse.cz>
Subject: Re: Feature request: git-pull -e/--edit
Date: Mon, 20 Nov 2006 19:11:59 +0100
Message-ID: <20061120181159.GB7201@pasky.or.cz>
References: <git2eran@tromer.org> <4561B0B5.1020305@tromer.org> <200611201709.kAKH9or1012062@laptop13.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 20 Nov 2006 18:17:01 +0000 (UTC)
Cc: Eran Tromer <git2eran@tromer.org>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <200611201709.kAKH9or1012062@laptop13.inf.utfsm.cl>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31926>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GmDgH-0001CQ-8c for gcvg-git@gmane.org; Mon, 20 Nov
 2006 19:15:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S966347AbWKTSMK (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 20 Nov 2006
 13:12:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966348AbWKTSMF
 (ORCPT <rfc822;git-outgoing>); Mon, 20 Nov 2006 13:12:05 -0500
Received: from w241.dkm.cz ([62.24.88.241]:2274 "EHLO machine.or.cz") by
 vger.kernel.org with ESMTP id S966347AbWKTSMB (ORCPT
 <rfc822;git@vger.kernel.org>); Mon, 20 Nov 2006 13:12:01 -0500
Received: (qmail 25191 invoked by uid 2001); 20 Nov 2006 19:11:59 +0100
To: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Sender: git-owner@vger.kernel.org

On Mon, Nov 20, 2006 at 06:09:50PM CET, Horst H. von Brand wrote:
> Eran Tromer <git2eran@tromer.org> wrote:
> >   A------------F master
> >    \          /
> >     B--C--D--E
..snip..
> And if quux merges back, she gets the same plus a new merge node, and...
> Linus told everybody (quite forcefully, I might add) that this is not
> acceptable for distributed development.

Wrong, if quux merges back and does not do the same "force commit"
fast-forward (why would it, anyway - OP clearly said it's only if you
_want_ to make it explicit), quux won't get another merge but end up
with F as well. It all converges back nicely.

I can see how it could be useful.

> > You'd need to educate users on how to use this responsibly
> 
> Looks like you've never met real users ;-)

Yes, that is a real problem. ;-) But not adding features because users
could use them irresponsibly doesn't get you too far.

> > And to answer Linus: yes, it's expected that only non-leaf developers
> > will use --force-commit on regular basis, but that's not because
> > maintainers are technically special in any way. It's just because
> > maintainers have something useful to say ("someone's private topic
> > branch, starting at A and ending at E, has just been accepted into my
> > all-important public repo and here's why"). Anyone else can do the same
> > if he feels likewise.
> 
> But the individual changes will presumably reflect said someone's
> authorship.

You are personifying too much. Git setups where multiple people have
commit access are very common, and there's no reason to play them down
just because Git makes other setups easy.

> If they are interleaved with stuff by others or not doesn't make much
> (development) sense. Yes, it might be interesting for a software
> historian, but that's not git's main audience in the first place.

Tell that to Junio, our pickaxe guy. :^)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
The meaning of Stonehenge in Traflamadorian, when viewed from above, is:
"Replacement part being rushed with all possible speed."
