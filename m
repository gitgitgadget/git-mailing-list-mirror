From: Nico Williams <nico@cryptonector.com>
Subject: Re: Amending merge commits?
Date: Tue, 29 Jul 2014 10:44:11 -0500
Message-ID: <CAK3OfOhFzbUA7gZbox84W=VC+0aSuiNc-XRP_MTyYy1UeFFzZQ@mail.gmail.com>
References: <CAK3OfOjr6ej5VdGU=bLmtag9cca1=ogLxVakCFTMG7b-A2uBiA@mail.gmail.com>
	<87r4147agk.fsf@osv.gnss.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	"Besen, David" <david.besen@hp.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Sergei Organov <osv@javad.com>
X-From: git-owner@vger.kernel.org Tue Jul 29 17:44:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XC9Zd-0002Vq-5X
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jul 2014 17:44:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752161AbaG2PoP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2014 11:44:15 -0400
Received: from sub4.mail.dreamhost.com ([69.163.253.135]:60470 "EHLO
	homiemail-a85.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751048AbaG2PoM (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Jul 2014 11:44:12 -0400
Received: from homiemail-a85.g.dreamhost.com (localhost [127.0.0.1])
	by homiemail-a85.g.dreamhost.com (Postfix) with ESMTP id 35B30BBA06B
	for <git@vger.kernel.org>; Tue, 29 Jul 2014 08:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=cryptonector.com; h=
	mime-version:in-reply-to:references:date:message-id:subject:from
	:to:cc:content-type; s=cryptonector.com; bh=js85CGsDdQO6TMyQ36rl
	GaH8zaY=; b=luaRo8QzFyH1K/nsxMyfyjOCyJypBcsdkpXMod0nf5cYsaYMNKxs
	fu9OSlWpayEPRpHCOPx4clhoB+49bFbsYEG3UfoBTTP1mcFf8wFV000WIi0LcFRj
	MBEQhdMZeSEGDG5mTlfDF4A/PPtEgP+cHR28XMHvJZi1jen+/lLCdqM=
Received: from mail-ie0-f178.google.com (mail-ie0-f178.google.com [209.85.223.178])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: nico@cryptonector.com)
	by homiemail-a85.g.dreamhost.com (Postfix) with ESMTPSA id 0FFB4BBA06A
	for <git@vger.kernel.org>; Tue, 29 Jul 2014 08:44:11 -0700 (PDT)
Received: by mail-ie0-f178.google.com with SMTP id rd18so8788951iec.37
        for <git@vger.kernel.org>; Tue, 29 Jul 2014 08:44:11 -0700 (PDT)
X-Received: by 10.42.252.201 with SMTP id mx9mr6771933icb.78.1406648651291;
 Tue, 29 Jul 2014 08:44:11 -0700 (PDT)
Received: by 10.107.128.169 with HTTP; Tue, 29 Jul 2014 08:44:11 -0700 (PDT)
In-Reply-To: <87r4147agk.fsf@osv.gnss.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254445>

On Tue, Jul 29, 2014 at 4:58 AM, Sergei Organov <osv@javad.com> wrote:
> Nico Williams <nico@cryptonector.com> writes:
>> That exception aside, keeping all local commits "on top" by always
>> rebasing them onto the upstream is extremely useful: a) in simplifying
>> conflict resolution, b) making it easy to identify as-yet-unintegrated
>> local commits, c) making it easy to contribute local commits.
>
> But 'pull --rebase=preserve' does rebase local commits onto the
> upstream, and result is exactly the same as 'pull --rebase=true', unless
> you have some of your own merges to be rebased. That's where the
> difference between these two options appears. It's --rebase=false that
> performs merges rather than rebase.

Local merge commits mean that you either didn't rebase to keep all
your local commits on top of the upstream, or that you have multiple
upstreams (the example exception I gave).

Conversely, if you always rebase your local commits on top of the
upstream then you won't have merge commits to worry about.

Nico
--
