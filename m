From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] git-fetch: follow tag only when tracking remote branch.
Date: Wed, 22 Feb 2006 22:19:42 +0100
Message-ID: <43FCD56E.5090804@op5.se>
References: <43FB6C42.5000208@gorzow.mm.pl>	<BAYC1-PASMTP03A58A4F389365AC85DA68AEFC0@CEZ.ICE>	<Pine.LNX.4.64.0602211635450.30245@g5.osdl.org>	<20060222011338.GL5000@delft.aura.cs.cmu.edu>	<7v3bicupgb.fsf@assigned-by-dhcp.cox.net>	<20060222031136.GN5000@delft.aura.cs.cmu.edu>	<7vacckt6vr.fsf@assigned-by-dhcp.cox.net> <7vfymbm72x.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org,
	Jan Harkes <jaharkes@cs.cmu.edu>
X-From: git-owner@vger.kernel.org Wed Feb 22 22:20:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FC1Ol-0000Uz-9H
	for gcvg-git@gmane.org; Wed, 22 Feb 2006 22:19:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751303AbWBVVTo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Feb 2006 16:19:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751282AbWBVVTo
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Feb 2006 16:19:44 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:59880 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1751303AbWBVVTn
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Feb 2006 16:19:43 -0500
Received: from [192.168.1.20] (host-213.88.215.14.addr.se.sn.net [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id D0CB26BCBE; Wed, 22 Feb 2006 22:19:42 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vfymbm72x.fsf_-_@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16616>

Junio C Hamano wrote:
> Unless --no-tags flag was given, git-fetch tried to always
> follow remote tags that point at the commits we picked up.
> 
> It is not very useful to pick up tags from remote unless storing
> the fetched branch head in a local tracking branch.  This is
> especially true if the fetch is done to merge the remote branch
> into our current branch as one-shot basis (i.e. "please pull"),
> and is even harmful if the remote repository has many irrelevant
> tags.
> 
> This proposed update disables the automated tag following unless
> we are storing the a fetched branch head in a local tracking
> branch.
> 
> Signed-off-by: Junio C Hamano <junkio@cox.net>
> 
> ---
> 
>  * Likes, dislikes?
> 

Likes a lot. This is a Good Thing.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
