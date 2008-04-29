From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH 7/7] make "git fetch" update all fetch repositories
Date: Tue, 29 Apr 2008 23:33:23 +0200
Message-ID: <20080429213323.GA2413@steel.home>
References: <20080428181012.GB6710@steel.home> <48161544.90500@gnu.org> <20080428213339.GC10600@steel.home> <4816A989.2010204@gnu.org> <20080429053814.GA3332@steel.home> <4816C527.4000406@gnu.org> <4816CB46.1050100@op5.se> <4816D505.1000208@gnu.org> <20080429204417.GC6301@steel.home> <48178FD6.90104@gnu.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Ericsson <ae@op5.se>, git@vger.kernel.org,
	spearce@spearce.org, gitster@pobox.com, peff@peff.net,
	johannes.schindelin@gmx.de, srb@cuci.nl
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Tue Apr 29 23:34:16 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqxSo-0000cZ-BF
	for gcvg-git-2@gmane.org; Tue, 29 Apr 2008 23:34:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752691AbYD2Vd1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2008 17:33:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752686AbYD2Vd0
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Apr 2008 17:33:26 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:39829 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752161AbYD2VdZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2008 17:33:25 -0400
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: z4gYkBuibEUndJ36PWMnarO+D1WRsg==
Received: from tigra.home (Fabc8.f.strato-dslnet.de [195.4.171.200])
	by post.webmailer.de (klopstock mo15) (RZmta 16.27)
	with ESMTP id U06328k3THNCJM ; Tue, 29 Apr 2008 23:33:24 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 83E7D277BD;
	Tue, 29 Apr 2008 23:33:23 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 3F36156D28; Tue, 29 Apr 2008 23:33:23 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <48178FD6.90104@gnu.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80741>

Paolo Bonzini, Tue, Apr 29, 2008 23:15:02 +0200:
>>> 2) the patch does not touch refs/heads/* unless you are tweaking your 
>>>  configuration (and quite heavily so).  IMHO that's using enough rope 
>>>  that you really ought to know about the reflog and... look for 
>>> backwards  incompatible changes in the release notes!
>>
>> Since when do you depend on people reading release notes and
>> immediately and correctly changing their behaviour?
>
> I don't, that's why I never expected all patches to go in 1.5.6.
>

Oh, the next minor release...

> I sent them together to provide a single coherent series and an aim for  
> a transition plan -- which I'd prefer to work out with the git  
> community, who knows the release mechanics much better than I do.  Jeff  
> King's reply to the cover letter is a start towards that; your e-mails  

Hmm... Which one do you mean? I cannot find his reply to message-id
<cover.1209391614.git.bonzini@gnu.org>

> are also a start towards that, even though I don't think your transition  
> plan is feasible (also because it would break "git remote update"  
> completely).

Which part of "warn people in git-fetch" will break "git remote update"?
Or what will break after the "git remote add" start setting
skipDefaultUpdate?

>>> 4) one man's stupidity is another man's... [fill in]  In particular, 
>>> did  you understand the rationale for this change?  Do you have any   
>>> alternative ideas?
>>
>> Do you have a convincing one by now?
>
> See the (long) cover letter.
>

It is not. It seem to propose, instead of fixing existing behaviour,
change it incompatibly. And dangerously, I believe.
