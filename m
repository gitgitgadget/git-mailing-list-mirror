From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: A design for subrepositories
Date: Sun, 14 Oct 2012 21:32:05 +0200
Message-ID: <507B1335.10105@web.de>
References: <20121013163322.685276teuhqhjc82.lealanko@webmail.helsinki.fi> <7vd30m2sbr.fsf@alter.siamese.dyndns.org> <20121014002304.14167k2j2ctspiuw.lealanko@webmail.helsinki.fi> <7vzk3p1xh3.fsf@alter.siamese.dyndns.org> <20121014131928.25943ezwa6fveyls.lealanko@webmail.helsinki.fi> <507ABDF3.4040106@web.de> <20121014182746.42895rwvalv4uoz6.lealanko@webmail.helsinki.fi> <507AE773.1010301@web.de> <7v4nlxylpm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Lauri Alanko <la@iki.fi>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Oct 14 21:32:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNTvM-0004NU-6t
	for gcvg-git-2@plane.gmane.org; Sun, 14 Oct 2012 21:32:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751438Ab2JNTcV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Oct 2012 15:32:21 -0400
Received: from mout.web.de ([212.227.17.12]:54600 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751414Ab2JNTcU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Oct 2012 15:32:20 -0400
Received: from [192.168.178.41] ([79.193.81.106]) by smtp.web.de (mrweb002)
 with ESMTPA (Nemesis) id 0MhULy-1T0yz52UvS-00MmwI; Sun, 14 Oct 2012 21:32:09
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:16.0) Gecko/20121010 Thunderbird/16.0.1
In-Reply-To: <7v4nlxylpm.fsf@alter.siamese.dyndns.org>
X-Provags-ID: V02:K0:hBgjudnhOytNKrWE49HUjYD4toSKXHyFzWDhZ/S0OUV
 pdeLpiMy/XsZ42zLMSIYXbcEnE/qeG7IPR20/wocBwfridkaX0
 fywahIkH3T3MHEy6voI5DhtLqwzcDPtNfWtYhPopNpGjwXyfk7
 Ha6HTwYuPVlz4KCTBUcFwgvGDSLByCTshJ1Hvth1UmvyvPkE2O
 ngDG6ntRHg9jCEFiakAxQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207683>

Am 14.10.2012 20:04, schrieb Junio C Hamano:
> Jens Lehmann <Jens.Lehmann@web.de> writes:
> 
>> Again, the user experience is currently suboptimal.
> 
> You mentioned multiple things in your responses that you are
> planning to address, but I am wondering if the first step before
> doing anything else is to have a list of known-to-be-suboptimal
> things and publish it somewhere other people can find it.  Then
> Lauri or others may able to help code the design of the approach to
> address them for items you already have designs for, and they may
> even be able to help designing the approach for the ones you don't.

I'm keeping such a list in the "Issues still to be tackled in this
repo" section of the Wiki page of my github repo:
   https://github.com/jlehmann/git-submod-enhancements/wiki

Currently that's just a collection of things to do and bugs to fix,
but if people are interested I'm willing to add descriptions of the
solutions I have in mind for those topics.

> More importantly, they do not have to waste time coming up with
> incompatible tools.  Adding "works in this scenario that is
> different from those other slightly different tools" to the mix of
> third-party tool set would fragment and confuse the user base
> ("which one of 47 different tools, all of which are incomplete,
> should I use?") and dilute developer attention.  They all at some
> point want to interact with the core side, and without an overall
> consistent design and coordination, some of their demand on the core
> side would end up being imcompatible.
> 
> The "just let .gitmodules record which branch is of interest,
> without checking out a specific commit bound to the superproject
> tree and using as a base for diff" (aka floating submodule) could be
> one of the items on the list, for example; to support it, we should
> not have to throw the entire "git submodule" with the bathwater.

Yup, that's also on that list under "always tip" mode.
