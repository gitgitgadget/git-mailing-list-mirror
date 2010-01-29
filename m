From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH] checkout: warn about 'branch name' rather than 'local
 branch'
Date: Fri, 29 Jan 2010 16:40:39 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1001291621020.1681@xanadu.home>
References: <fabb9a1e1001291256j71e2c95cic21cb5a6a0cc1fe8@mail.gmail.com>
 <1264799342-11093-1-git-send-email-srabbelier@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Ron1 <ron1@flownet.com>, Jacob Helwig <jacob.helwig@gmail.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 29 22:42:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NaybT-0006Jl-O6
	for gcvg-git-2@lo.gmane.org; Fri, 29 Jan 2010 22:42:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754369Ab0A2VmA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jan 2010 16:42:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754296Ab0A2Vl7
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jan 2010 16:41:59 -0500
Received: from relais.videotron.ca ([24.201.245.36]:37857 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754064Ab0A2Vl7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jan 2010 16:41:59 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-MR-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0KX100FRJ2VRT9C0@VL-MR-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 29 Jan 2010 16:40:40 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <1264799342-11093-1-git-send-email-srabbelier@gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138371>

On Fri, 29 Jan 2010, Sverre Rabbelier wrote:

> These days, you can say "git checkout topic" to automagically create
> a local "topic" branch that forks from "origin/topic" remote tracking
> branch when you have one, thanks to Dscho's UI improvement ideas. As
> such it is more appropriate to say that the user is checking out
> something that is not a branch name, rather than saying it is not a
> 'local branch'.
> 
> Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>

For the record, I'm providing a NAK.  First I don't agree with the UI 
"improvement" if there is no way to check out a remote branch without 
creating soon-to-be-stall local branches with the same name.

Next, the message can be made yet more clear and give the user more of a 
hint with what is going on.  Something like:

	"%s is not a local branch head: creating a detached HEAD\n"

plus the remaining clue lines.  This way people will have a much greater 
chance of understanding what state they're in, and a simple Google 
search for detached HEAD gives you the Git manual page with the needed 
info.


Nicolas
