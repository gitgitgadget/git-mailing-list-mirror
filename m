From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: branch description
Date: Tue, 15 Apr 2008 18:33:48 -0700 (PDT)
Message-ID: <m3abjushvs.fsf@localhost.localdomain>
References: <9b3e2dc20804150951scf8b3c7x26f3a56eab1f9840@mail.gmail.com>
	<f9d2a5e10804151031o1d09c1f9od0ad78dcf9b746c5@mail.gmail.com>
	<C55CA6EB-D427-4CF5-923E-DE0071D2F870@silverinsanity.com>
	<7vej97x78v.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brian Gernhardt <benji@silverinsanity.com>,
	Russ Dill <russ.dill@gmail.com>,
	"Stephen Sinclair" <radarsat1@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 16 07:22:23 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JlwXm-0000hE-LO
	for gcvg-git-2@gmane.org; Wed, 16 Apr 2008 03:34:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753102AbYDPBdx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Apr 2008 21:33:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752591AbYDPBdx
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Apr 2008 21:33:53 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:9157 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752818AbYDPBdw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Apr 2008 21:33:52 -0400
Received: by ug-out-1314.google.com with SMTP id z38so823992ugc.16
        for <git@vger.kernel.org>; Tue, 15 Apr 2008 18:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        bh=WvN10fUeCY5GJ13GaazIXmKIKjCFJsJnvM01ESe/ftI=;
        b=SLJkw4QzpvKAIso3zhiO6DuF9umvI60ffL4l0pDazBRwfqMr263QYFdlEatfkVIca8l3E2/tYnwdgdR2PemBqNAGAsoadvQKJFCNIqJ+So3R3sBZ1MQ0rsJ1hJS60xHxMEeVgZ0kEINo2SWGliKBFUigxs/Nq/LGRRyj6H5TCbc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        b=bHAwJFlevkZJ50xf7t71O6CEVVLlY8lqQIK/48osLu20Wzlp4egOt5cnylrkK8dGciNHQmauMp5SbSijn3DAbPG7iwFGIW66x8HdpmQQWKMHJtlz2EH+rv3foTYdhYehTu93vlAKK5BvPGOaDDq9w/bQOVEsAcXtk8GRRANugFQ=
Received: by 10.67.20.11 with SMTP id x11mr6202097ugi.29.1208309630892;
        Tue, 15 Apr 2008 18:33:50 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.244.53])
        by mx.google.com with ESMTPS id 5sm3148009ugc.25.2008.04.15.18.33.47
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 15 Apr 2008 18:33:48 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m3G1Xjqv023894;
	Wed, 16 Apr 2008 03:33:46 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m3G1XhSM023891;
	Wed, 16 Apr 2008 03:33:43 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <7vej97x78v.fsf@gitster.siamese.dyndns.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79659>

Junio C Hamano <gitster@pobox.com> writes:

> Brian Gernhardt <benji@silverinsanity.com> writes:
> 
>> On Apr 15, 2008, at 1:31 PM, Russ Dill wrote:
>>
>>> The problem is that a branch is just a floating name for a line of
>>> development. Its not really a "thing" in the repository like a tag or
>>> a commit. You'd need to make some sort of special tag that describes
>>> the branch or somesuch.
>>
>> No special tags needed.  A simple file that I'll call .git/info/
>> ref_names could be a set of lines that have "<ref>\t<description>",
>> like the following:
>>
>> refs/heads/master	Collection point for all my work
>> refs/heads/ref_names	Add descriptions for branches
>> refs/heads/segfault	Trying to fix bug #12345
[...]
>> Now if you want to propagate these descriptions when you push and
>> pull, things get a lot more complicated.
> 
> Not complicated at all.  Put that description in-tree in a known location
> (say, "help-branch") in-tree and your propagation problem is solved.
> 
> And have a scriptlet in $HOME/bin/git-help-branch to grep from that file.

Please, let's don't repeat Mercurial mistake of placing unversioned
information (such as branch names in case of Mercurial, or branches
descriptions in this case) in-tree, i.e. version it.  Think of what
would happen if you reset to the state (or checkout to some branch
with the state) which is before some branch was created, or before
some branch got description.  Mercurial deals with this using
"special" not lika in-tree treatment of such a file... I don't think
it is a good idea.

I think it wouldb be better to put branches descriptions somewhere
outside object repository, be it .git/info/ref_names of .git/config.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
