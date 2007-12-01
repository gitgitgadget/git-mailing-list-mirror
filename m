From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] transport.c: call dash-less form of receive-pack and upload-pack on remote
Date: Fri, 30 Nov 2007 18:36:25 -0800
Message-ID: <7vlk8f9m52.fsf@gitster.siamese.dyndns.org>
References: <20071127150229.GA14859@laptop> <20071127160423.GA22807@laptop>
	<Pine.LNX.4.64.0711271617350.27959@racer.site>
	<20071128000731.GD9174@efreet.light.src>
	<7v8x4jb295.fsf@gitster.siamese.dyndns.org>
	<fcaeb9bf0711280036p33583824ge59af93bbe3f0a78@mail.gmail.com>
	<7vfxyq2c9b.fsf@gitster.siamese.dyndns.org>
	<fcaeb9bf0711281917p56cc4228m6c401286439e2a34@mail.gmail.com>
	<alpine.LFD.0.99999.0711290905510.9605@xanadu.home>
	<7vd4tsvfvk.fsf@gitster.siamese.dyndns.org>
	<DB613F3E-85CC-4AF0-928C-4F4E4C8E9FB8@orakel.ntnu.no>
	<Pine.LNX.4.64.0711301207020.27959@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eyvind Bernhardsen <eyvind-git-list@orakel.ntnu.no>,
	Nicolas Pitre <nico@cam.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Jan Hudec <bulb@ucw.cz>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Dec 01 03:36:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IyIDs-0003eS-Us
	for gcvg-git-2@gmane.org; Sat, 01 Dec 2007 03:36:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758425AbXLACgf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Nov 2007 21:36:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758414AbXLACgf
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Nov 2007 21:36:35 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:40277 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758397AbXLACge (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Nov 2007 21:36:34 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 97EAF2F2;
	Fri, 30 Nov 2007 21:36:55 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 025309B9ED;
	Fri, 30 Nov 2007 21:36:48 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66679>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Since we plan to move the dash-form (git-<whatever>) into an execdir, it
> make sense to prepare our git protocol users for it.
>
> Noticed by Eyvind Bernhardsen.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>
> 	On Fri, 30 Nov 2007, Eyvind Bernhardsen wrote:
>
> 	> - When pushing to my system over ssh, git-receive-pack and
> 	> git-upload-pack are expected to be in $PATH.  I resolved the 
> 	> problem by putting symlinks in /usr/local/bin.
>
> 	How about this?  (I only compile-tested it...)

I only eyeball-tested it and looks Okay, but that does not assure us
much ;-).  Is this change easy to test using local transport?
