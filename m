From: Rogan Dawes <lists@dawes.za.net>
Subject: Re: why is git destructive by default? (i suggest it not be!)
Date: Tue, 24 Jun 2008 14:46:57 +0200
Message-ID: <4860ECC1.9020608@dawes.za.net>
References: <200806241322.14224.jnareb@gmail.com> <28156.2147582465$1214307807@news.gmane.org> <4860E63B.6040709@dawes.za.net> <20080624123527.GA6149@dualtron.vpn.rwth-aachen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: David Jeske <jeske@google.com>, Jakub Narebski <jnareb@gmail.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
To: Johannes Gilger <heipei@hackvalue.de>
X-From: git-owner@vger.kernel.org Tue Jun 24 14:49:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KB7wu-0005WD-3H
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 14:48:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751097AbYFXMrn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 08:47:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751105AbYFXMrn
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 08:47:43 -0400
Received: from sd-green-bigip-207.dreamhost.com ([208.97.132.207]:45133 "EHLO
	spunkymail-a20.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751061AbYFXMrm (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Jun 2008 08:47:42 -0400
X-Greylist: delayed 1671 seconds by postgrey-1.27 at vger.kernel.org; Tue, 24 Jun 2008 08:47:42 EDT
Received: from [192.168.201.100] (unknown [41.247.117.167])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by spunkymail-a20.g.dreamhost.com (Postfix) with ESMTP id B3DD7E2501;
	Tue, 24 Jun 2008 05:47:37 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.14 (Windows/20080421)
In-Reply-To: <20080624123527.GA6149@dualtron.vpn.rwth-aachen.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86049>

Johannes Gilger wrote:
> On 24/06/08 14:19, Rogan Dawes wrote:
>> One thing that I haven't seen addressed in this thread is the fact that if 
>> you have a dirty working directory, and you "git reset --hard", whatever 
>> was dirty (not yet in the index, or committed) will be blown away, and no 
>> amount of reflog archeology will help you get it back.
> 
> I think the name of the command "reset" itself is a name which should 
> prompt everyone to read a manpage before using it. I could understand 
> that if "status" did something destructive people would get upset.
> Other than that, git reset itself doesn't do anything destructive. Yeah, 
> git reset --hard does, but hello, this is *reset* and *hard*, someone 
> using this must really want what's about to happen. Nobody complaines 
> about rm --force or anything.
> 
> As for putting safety-measure everywhere, I think that any further 
> restricting of commands would be nonsense and just hindering the 
> workflow. git is not something with a GUI and a recycle-bin. And it 
> still is really hard to accidentaly lose anything in git.
> 
> Regards,
> Jojo
> 

Right. I was simply pointing out to the original poster that for all the 
talk about reflogs, if you use "reset --hard", all bets are off. I was 
not complaining about the existence of that option, or its name . . .

I agree that adding nanny-guards to git would be counter productive.

Rogan
