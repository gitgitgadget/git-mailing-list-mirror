From: Andreas Ericsson <ae@op5.se>
Subject: Re: [Census] So who uses git?
Date: Thu, 02 Feb 2006 15:59:18 +0100
Message-ID: <43E21E46.4040502@op5.se>
References: <46a038f90601251810m1086d353ne8c7147edee4962a@mail.gmail.com>	<Pine.LNX.4.64.0601272345540.2909@evo.osdl.org>	<46a038f90601272133o53438987ka6b97c21d0cdf921@mail.gmail.com>	<1138446030.9919.112.camel@evo.keithp.com>	<7vzmlgt5zt.fsf@assigned-by-dhcp.cox.net>	<20060130185822.GA24487@hpsvcnb.fc.hp.com>	<Pine.LNX.4.63.0601311127250.25248@wbgn013.biozentrum.uni-wuerzburg.de>	<Pine.LNX.4.64.0601311750270.25300@iabervon.org>	<7vek2oot7z.fsf@assigned-by-dhcp.cox.net>	<Pine.LNX.4.64.0601311623240.7301@g5.osdl.org>	<7v4q3jlgw2.fsf@assigned-by-dhcp.cox.net>	<Pine.LNX.4.64.0602011125370.5397@localhost.localdomain>	<7vhd7ibza2.fsf@assigned-by-dhcp.cox.net>	<Pine.LNX.4.64.0602011307250.21884@g5.osdl.org>	<7v8xsu91vf.fsf@assigned-by-dhcp.cox.net>	<Pine.LNX.4.64.0602011717010.5397@localhost.localdomain> <7v8xsu7kys.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Nicolas Pitre <nico@cam.org>, Linus Torvalds <torvalds@osdl.org>,
	git@vger.kernel.org, Joel Becker <Joel.Becker@oracle.com>
X-From: git-owner@vger.kernel.org Fri Feb 03 09:10:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F4w16-0002Wa-Oy
	for gcvg-git@gmane.org; Fri, 03 Feb 2006 09:10:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751220AbWBCIJY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Feb 2006 03:09:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751234AbWBCIJX
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Feb 2006 03:09:23 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:51119 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1751224AbWBCIJX
	(ORCPT <rfc822;git@vger.kernel.org>); Fri, 3 Feb 2006 03:09:23 -0500
Received: from [192.168.1.104] (gprs2.vodafone.se [217.174.67.69])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id DEA276BCFE; Fri,  3 Feb 2006 09:09:16 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v8xsu7kys.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15534>

Junio C Hamano wrote:
> 
> I do not particularly have much preference among --also,
> --with-index, or --incremental, but:
> 
>  - 'with-index' is precise but might be too technical;
>  - 'incremental' is not really incremental -- you can use it
>    only once.
> 
> Because you do not have to say "git commit --also" without paths
> (which _is_ awkward) to get the traditional behaviour, maybe it
> is a good name for that flag (it is also the shortest).
> 

Except that -a, which is the logical shorthand, is already taken. How 
about --include (or --include-index, or --index) and -i? commit being a 
fairly commonly used command, I think it's safe to assume that most 
people will read the man-page or the help output if there's something 
they don't undetstand.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
