From: Auke Schrijnen <auke@schrijnen.nl>
Subject: Re: [PATCH] git-completion: offer remotes for 'git remote update'
Date: Wed, 28 Sep 2011 10:52:29 +0200
Message-ID: <8afccd5cb106493a55415bec66328063@schrijnen.nl>
References: <347b845858abcc62551d83df324e5c10@schrijnen.nl>
 <7v8vp9trvu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 28 10:52:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8psb-0000a3-SX
	for gcvg-git-2@lo.gmane.org; Wed, 28 Sep 2011 10:52:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751355Ab1I1Iwc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Sep 2011 04:52:32 -0400
Received: from server6.bhosted.nl ([94.124.120.40]:1177 "HELO
	server6.bhosted.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750926Ab1I1Iwc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Sep 2011 04:52:32 -0400
Received: (qmail 27392 invoked by uid 1011); 28 Sep 2011 10:52:29 +0200
In-Reply-To: <7v8vp9trvu.fsf@alter.siamese.dyndns.org>
X-Sender: auke@schrijnen.nl
User-Agent: Roundcube Webmail/0.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182301>

On Tue, 27 Sep 2011 17:47:17 -0700, Junio C Hamano wrote:
> Auke Schrijnen <auke@schrijnen.nl> writes:
>
>> Completion for 'git remote update' only offers configured remote
>> groups.
>
> I have this suspicion that it might even be a feature. I am a bad 
> person
> to make the judgement, as I do not use the "grouping" feature at all.
>
> If you throw in individual remotes that are not grouped in the mix, 
> the
> users of "git remote update" auto-completion, who have been happily
> relying on seeing only the configured groups, suddenly will start 
> seeing
> many individual repositories offered, cluttering the available 
> choices.
> Besides, if you want to fetch from a single source, why not use "git
> fetch" directly?
>
> Back when "git fetch" didn't allow fetching from multiple 
> repositories in
> one go, "remote update" was written as a wrapper for the explicit 
> purpose
> of fetching from more than one remote by defining remote groups. 
> Since
> late 2009, "git fetch" can update from multiple remotes itself, and I
> suspect "git remote update" outlived its usefulness in some sense, 
> but
> that is a tangent.

I see your point and obviously i'm also not using the grouping feature. 
I could just use git fetch but i'm so used to type 'git remote 
update'... So i'll cook another patch.

Auke
