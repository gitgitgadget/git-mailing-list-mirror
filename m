From: Asheesh Laroia <asheesh@asheesh.org>
Subject: Re: Help! My ISP blocks repo.or.cz. How to push changes?
Date: Tue, 13 Jan 2009 12:13:22 -0800 (PST)
Message-ID: <alpine.DEB.2.00.0901131212390.14410@vellum.laroia.net>
References: <200901120246.28364.jnareb@gmail.com> <200901121213.45858.jnareb@gmail.com> <alpine.DEB.2.00.0901120324490.18989@vellum.laroia.net> <200901130039.48340.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 13 21:15:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMpf4-0003mi-SU
	for gcvg-git-2@gmane.org; Tue, 13 Jan 2009 21:14:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754200AbZAMUNb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jan 2009 15:13:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754049AbZAMUNa
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Jan 2009 15:13:30 -0500
Received: from rose.makesad.us ([219.105.37.19]:45827 "EHLO rose.makesad.us"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753945AbZAMUN3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jan 2009 15:13:29 -0500
Received: from vellum.laroia.net (localhost [127.0.0.1])
	by rose.makesad.us (Postfix) with ESMTP id A9BA6A016D;
	Tue, 13 Jan 2009 15:13:27 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by vellum.laroia.net (Postfix) with ESMTPS id 897613A62B9;
	Tue, 13 Jan 2009 12:13:22 -0800 (PST)
X-X-Sender: paulproteus@vellum.laroia.net
In-Reply-To: <200901130039.48340.jnareb@gmail.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
X-OpenPGP-Key-ID: 0x70096AD1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105528>

On Tue, 13 Jan 2009, Jakub Narebski wrote:

> Asheesh Laroia wrote:
>> On Mon, 12 Jan 2009, Jakub Narebski wrote:
>>
>>> But I have to run
>>>
>>> $ ssh -f -N -L 2222:repo.or.cz:22 jnareb@host.example.com
>>>
>>> first. Is there any way to automate this?
>>
>> Check out 'gstm' or 'autossh'.
>
> I don't know about gSTM (Gnome SSH Tunnel Manager), but autossh
> does only provide reconnect in the case the gateway host closes
> connection. I still have to run it, perhaps from startup script.

Yeah, gSTM is pretty manual in that regard. autossh from a startup script 
makes sense.

-- Asheesh.

-- 
Q:	How many marketing people does it take to change a light bulb?
A:	I'll have to get back to you on that.
