From: Andreas Ericsson <ae@op5.se>
Subject: git shorthands (was: Re: Wine + GIT)
Date: Tue, 06 Dec 2005 22:22:27 +0100
Message-ID: <43960113.8000209@op5.se>
References: <20051206173909.GE17457@fieldses.org> <1133891589.8577.63.camel@cashmere.sps.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Dec 06 22:25:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EjkGh-00068T-B2
	for gcvg-git@gmane.org; Tue, 06 Dec 2005 22:22:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030251AbVLFVWa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Dec 2005 16:22:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030252AbVLFVWa
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Dec 2005 16:22:30 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:16093 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1030251AbVLFVW3
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 6 Dec 2005 16:22:29 -0500
Received: from [192.168.1.19] (1-2-9-7a.gkp.gbg.bostream.se [82.182.116.44])
	by smtp-gw1.op5.se (Postfix) with ESMTP id E76396BCBE
	for <git@vger.kernel.org>; Tue,  6 Dec 2005 22:22:27 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Git List <git@vger.kernel.org>
In-Reply-To: <1133891589.8577.63.camel@cashmere.sps.mot.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13292>

Jon Loeliger wrote:
> 
> That way:
>     "git mer" would fail
>     "git merge" would run "git-merge"
>     "git merge-" would fail
>     "git merge-o" would fail,
>     "git-merge-oc" would run "git-merge-octopus".
> 
> Any interest?  Overkill?  Bad idea?
> 

I think it's overkill. It would be better, methinks, to add mnemonic-ish 
shorthands for the porcelainish commands, so that

	git fp   => git-format-patch
	git co   => git-checkout
	git up   => git-update-index
	git octo => git-merge-octopus
	git fsck => git-fsck-objects
	git hash => git-hash-object

and so on...


This because non-ambiguous is rarely logical (for git at least, which 
has 'git-<family>-<action | object-type>) unless one knows the entire 
command anyways. Ambiguity may also be introduced by later commands, and 
then you'll need to re-learn them. I always find that annoying.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
