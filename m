From: Eyvind Bernhardsen <eyvind-git-list@orakel.ntnu.no>
Subject: Re: [PATCH] Move all dashed form git commands to libexecdir
Date: Fri, 30 Nov 2007 12:28:18 +0100
Message-ID: <DB613F3E-85CC-4AF0-928C-4F4E4C8E9FB8@orakel.ntnu.no>
References: <20071127150229.GA14859@laptop> <20071127160423.GA22807@laptop> <Pine.LNX.4.64.0711271617350.27959@racer.site> <20071128000731.GD9174@efreet.light.src> <7v8x4jb295.fsf@gitster.siamese.dyndns.org> <fcaeb9bf0711280036p33583824ge59af93bbe3f0a78@mail.gmail.com> <7vfxyq2c9b.fsf@gitster.siamese.dyndns.org> <fcaeb9bf0711281917p56cc4228m6c401286439e2a34@mail.gmail.com> <alpine.LFD.0.99999.0711290905510.9605@xanadu.home> <7vd4tsvfvk.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Nicolas Pitre <nico@cam.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Jan Hudec <bulb@ucw.cz>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 30 13:09:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iy4gU-0001r7-Sp
	for gcvg-git-2@gmane.org; Fri, 30 Nov 2007 13:09:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761477AbXK3MI5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Nov 2007 07:08:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759160AbXK3MI5
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Nov 2007 07:08:57 -0500
Received: from 97.84-49-228.nextgentel.com ([84.49.228.97]:54027 "EHLO
	eyvind.bernhardsens.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762217AbXK3MI4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Nov 2007 07:08:56 -0500
X-Greylist: delayed 2412 seconds by postgrey-1.27 at vger.kernel.org; Fri, 30 Nov 2007 07:08:55 EST
Received: from [192.168.2.243] (pat-gw.osl.fast.no [217.144.235.5])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by eyvind.bernhardsens.net (Postfix) with ESMTP id C8A5C62A3CA;
	Fri, 30 Nov 2007 12:28:39 +0100 (CET)
In-Reply-To: <7vd4tsvfvk.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66637>

On 29. nov. 2007, at 23.36, Junio C Hamano wrote:

[...]

> If people are really serious about reducing the number of commands in
> the path, I would expect fixes and bugreports saying "I am setting
> gitexecdir different from bindir in _my_ installation when I build  
> git,
> and here are the things that does not work if I do so".  Within the  
> span
> of more than 20 months (77cb17e9 introduced gitexecdir in Jan 2006), I
> do not think there was a single such report or patch, other than the
> message from Nguyen that started this thread.

I'm setting gitexecdir different from bindir in my installation, and  
here are the things that don't work:

- When pushing to my system over ssh, git-receive-pack and git-upload- 
pack are expected to be in $PATH.  I resolved the problem by putting  
symlinks in /usr/local/bin.

I haven't seen any other problems, but then again, I only use git  
plumbing commands and my own scripts.

Eyvind
