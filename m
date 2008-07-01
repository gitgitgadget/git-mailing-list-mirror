From: "Mikael Magnusson" <mikachu@gmail.com>
Subject: Re: [OT] Your branch is ahead of the tracked remote branch 'origin/master' by 50 commits.
Date: Tue, 1 Jul 2008 14:46:56 +0200
Message-ID: <237967ef0807010546m3eb6f824vd5514c5824c00ddd@mail.gmail.com>
References: <20080701091347.GA11817@elte.hu>
	 <7vlk0mne5d.fsf@gitster.siamese.dyndns.org>
	 <20080701100725.GE31309@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Ingo Molnar" <mingo@elte.hu>
X-From: git-owner@vger.kernel.org Tue Jul 01 14:48:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDfGx-0005mX-I4
	for gcvg-git-2@gmane.org; Tue, 01 Jul 2008 14:47:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754383AbYGAMq5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jul 2008 08:46:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754104AbYGAMq5
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Jul 2008 08:46:57 -0400
Received: from rv-out-0506.google.com ([209.85.198.230]:61713 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754380AbYGAMq4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jul 2008 08:46:56 -0400
Received: by rv-out-0506.google.com with SMTP id k40so2228396rvb.1
        for <git@vger.kernel.org>; Tue, 01 Jul 2008 05:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=C5TCC31b3ixfbUQBpyOBDBujy4lK+Bq5f/007qJERVg=;
        b=LYdgWt8MuaE9A+RvGdfAYygee8fVlacPVfNZq7Ztwh/aDbASvQzFgOdZkV3Y7oPXVI
         IQ4b5sz3YHPAFzLfMYtbcUPRNRsNDGSeqiyjXH2wOS4kUv17dAc7OIGWzEwyW7Uz9jYz
         QYkNaDJnZoXMJuxsIOHn0KOTqNm2prmF6bTgM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=VEcKkUeDWPoLZGMCFNJGZ5uqycfn1eM05fU+8Fi+eieyx6+FaSrS7E6MCLVhRiGCgo
         IHxTIg//EiBPfscfpu+gITi7doyImRjz9BBdFAECmmvzRyMa5Emz/WwgDbUmHc1HGPIX
         gB0t5LMVkr+B1BV9nxeqPvOTrcYrcE+pgRHw8=
Received: by 10.141.89.13 with SMTP id r13mr3433678rvl.177.1214916416122;
        Tue, 01 Jul 2008 05:46:56 -0700 (PDT)
Received: by 10.141.68.4 with HTTP; Tue, 1 Jul 2008 05:46:56 -0700 (PDT)
In-Reply-To: <20080701100725.GE31309@elte.hu>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87031>

2008/7/1 Ingo Molnar <mingo@elte.hu>:
> * Junio C Hamano <gitster@pobox.com> wrote:
>
>> Ingo Molnar <mingo@elte.hu> writes:
>>
>> > i recently switched to 1.5.6.1.89.gd5446 and i'm getting this:
>> >
>> >   Switched to branch "master"
>> >   Your branch is ahead of the tracked remote branch 'origin/master' by 50 commits.
>> >
>> > it's a very useful detail! It's especially useful when two branches
>> > diverge in a non-trivial way.
>> > ...
>> > but having a reminder at checkout time is even better (and faster as
>> > well). Kudos.
[snippy]
> There's a small detail i was thinking about: is there a way to get this
> extra output without actually switching branches? Right now i do this:
>
>  earth4:~/tip> git-checkout tip; git-checkout master
>  Checking out files: 100% (2437/2437), done.
>  Switched to branch "tip"
>  Switched to branch "master"
>  Your branch is ahead of the tracked remote branch 'origin/master' by 50 commits.
>
> (Which is an admitted lame solution but the best i could figure.)

{14:44:16|~code/git}% git checkout master
Checking out files: 100% (180/180), done.
Switched to branch "master"
{14:44:24|~code/git}% git shard HEAD\~5
HEAD is now at 8e69d78 Merge branch 'maint'
{14:44:28|~code/git}% git checkout HEAD
Your branch is behind the tracked remote branch 'origin/master' by 6 commits,
and can be fast-forwarded.

-- 
Mikael Magnusson
