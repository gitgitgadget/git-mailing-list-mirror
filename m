From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [PATCH 7/7] make "git fetch" update all fetch repositories
Date: Tue, 29 Apr 2008 23:41:57 +0200
Message-ID: <48179625.3050704@gnu.org>
References: <20080428181012.GB6710@steel.home> <48161544.90500@gnu.org> <20080428213339.GC10600@steel.home> <4816A989.2010204@gnu.org> <20080429053814.GA3332@steel.home> <4816C527.4000406@gnu.org> <4816CB46.1050100@op5.se> <4816D505.1000208@gnu.org> <20080429204417.GC6301@steel.home> <48178FD6.90104@gnu.org> <20080429213323.GA2413@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Andreas Ericsson <ae@op5.se>, git@vger.kernel.org,
	spearce@spearce.org, gitster@pobox.com, peff@peff.net,
	johannes.schindelin@gmx.de, srb@cuci.nl
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 29 23:42:54 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jqxb7-0003vR-Ez
	for gcvg-git-2@gmane.org; Tue, 29 Apr 2008 23:42:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752777AbYD2VmB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2008 17:42:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752686AbYD2VmA
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Apr 2008 17:42:00 -0400
Received: from hu-out-0506.google.com ([72.14.214.231]:27437 "EHLO
	hu-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752596AbYD2VmA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2008 17:42:00 -0400
Received: by hu-out-0506.google.com with SMTP id 19so193763hue.21
        for <git@vger.kernel.org>; Tue, 29 Apr 2008 14:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding:sender;
        bh=mJHrryrILcb0RPHXTw2ecTRqvmusuLejo1dxz3sYDwc=;
        b=IMjdd7L2LAXy7+y200doHnepKeCDIDGGDWY3AgPjf6MPOjkZeLqh9YBbosLi8jFnzMg5eCu/mswHl/ruE2CsERJlcqYLAJuYGxOQVUxaq9NTrGxsTAJmVlFfQBYVC3SetVVP2ZBcimCsqFvYiAJi2uJzpaCHAfxbdxvVCyeq3vw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding:sender;
        b=L2wqN24hR9fVFOGrL07K+2o7eYu31KP0VAEYcJVHWviklwuFErUwVXcbbZqL3lMHNyhAxr88HM5yoDN7eV3s8jsUTw7b2VVOd/rw483Xt+qN9nyLzAaWc1/lJuRZDsH0w5Q32yh7oecBrzXMJG9bZ9rakBGhouFUKfjLCOmv0kM=
Received: by 10.86.59.18 with SMTP id h18mr429520fga.22.1209505317398;
        Tue, 29 Apr 2008 14:41:57 -0700 (PDT)
Received: from scientist-2.lan ( [213.140.22.65])
        by mx.google.com with ESMTPS id d4sm353711fga.2.2008.04.29.14.41.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 29 Apr 2008 14:41:56 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.12 (Macintosh/20080213)
In-Reply-To: <20080429213323.GA2413@steel.home>
X-Enigmail-Version: 0.95.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80747>


>> I sent them together to provide a single coherent series and an aim for  
>> a transition plan -- which I'd prefer to work out with the git  
>> community, who knows the release mechanics much better than I do.  Jeff  
>> King's reply to the cover letter is a start towards that; your e-mails  
> 
> Hmm... Which one do you mean? I cannot find his reply to message-id
> <cover.1209391614.git.bonzini@gnu.org>

http://permalink.gmane.org/gmane.comp.version-control.git/80720

>> are also a start towards that, even though I don't think your transition  
>> plan is feasible (also because it would break "git remote update"  
>> completely).
> 
> Which part of "warn people in git-fetch" will break "git remote update"?
> Or what will break after the "git remote add" start setting
> skipDefaultUpdate?

People will expect the new remotes to be, ehm, updated by "git remote 
update".

> It is not. It seem to propose, instead of fixing existing behaviour,

Do you know how to "fix" existing behavior?

I mean, I just wonder why as long as I had one remote only, I could 
write "git push", while now I have to write "git push origin && git push 
mirror".  The patch to "git fetch" comes from this observation too, and 
I think it is a good idea, even though I'm less attached to it and it 
would influence my workflow much less.

Paolo
