From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] transport.c: call dash-less form of receive-pack and
 upload-pack on remote
Date: Sat, 1 Dec 2007 23:15:52 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0712012314190.27959@racer.site>
References: <20071127150229.GA14859@laptop> <20071127160423.GA22807@laptop>
 <Pine.LNX.4.64.0711271617350.27959@racer.site> <20071128000731.GD9174@efreet.light.src>
 <7v8x4jb295.fsf@gitster.siamese.dyndns.org>
 <fcaeb9bf0711280036p33583824ge59af93bbe3f0a78@mail.gmail.com>
 <7vfxyq2c9b.fsf@gitster.siamese.dyndns.org>
 <fcaeb9bf0711281917p56cc4228m6c401286439e2a34@mail.gmail.com>
 <alpine.LFD.0.99999.0711290905510.9605@xanadu.home> <7vd4tsvfvk.fsf@gitster.siamese.dyndns.org>
 <DB613F3E-85CC-4AF0-928C-4F4E4C8E9FB8@orakel.ntnu.no>
 <Pine.LNX.4.64.0711301207020.27959@racer.site> <7vlk8f9m52.fsf@gitster.siamese.dyndns.org>
 <Pine.LNX.4.64.0712010959180.27959@racer.site> <7vzlwu43i4.fsf@gitster.siamese.dyndns.org>
 <Pine.LNX.4.64.0712012300440.27959@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Eyvind Bernhardsen <eyvind-git-list@orakel.ntnu.no>,
	Nicolas Pitre <nico@cam.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Jan Hudec <bulb@ucw.cz>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Dec 02 00:16:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IybZl-0003V7-M7
	for gcvg-git-2@gmane.org; Sun, 02 Dec 2007 00:16:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752745AbXLAXQS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Dec 2007 18:16:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752537AbXLAXQQ
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Dec 2007 18:16:16 -0500
Received: from mail.gmx.net ([213.165.64.20]:33166 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751409AbXLAXQO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Dec 2007 18:16:14 -0500
Received: (qmail invoked by alias); 01 Dec 2007 23:16:12 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp027) with SMTP; 02 Dec 2007 00:16:12 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/7vF9/S4n7GFbmL/jar+4O5CxXlaVK49kowcKCZf
	sQumm/8XiJYppO
X-X-Sender: gene099@racer.site
In-Reply-To: <Pine.LNX.4.64.0712012300440.27959@racer.site>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66744>

Hi,

On Sat, 1 Dec 2007, Johannes Schindelin wrote:

> Will investigate right now,

The problem is that "git <command>" will call execv_git_cmd() for 
non-builtins, which in turn will execute "git <command>", ... ad 
infinitum.

Ciao,
Dscho
