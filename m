From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Move all dashed form git commands to libexecdir
Date: Thu, 29 Nov 2007 00:01:26 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711290000430.27959@racer.site>
References: <20071127150229.GA14859@laptop> <20071127160423.GA22807@laptop>
 <Pine.LNX.4.64.0711271617350.27959@racer.site> <20071128000731.GD9174@efreet.light.src>
 <7v8x4jb295.fsf@gitster.siamese.dyndns.org>
 <fcaeb9bf0711280036p33583824ge59af93bbe3f0a78@mail.gmail.com>
 <7vfxyq2c9b.fsf@gitster.siamese.dyndns.org> <Pine.LNX.4.64.0711282334250.27959@racer.site>
 <7vr6ia0w4i.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, Jan Hudec <bulb@ucw.cz>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 29 01:02:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxWqq-0007ZA-MI
	for gcvg-git-2@gmane.org; Thu, 29 Nov 2007 01:01:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757821AbXK2ABi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2007 19:01:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757756AbXK2ABi
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 19:01:38 -0500
Received: from mail.gmx.net ([213.165.64.20]:33291 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751007AbXK2ABh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2007 19:01:37 -0500
Received: (qmail invoked by alias); 29 Nov 2007 00:01:35 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp057) with SMTP; 29 Nov 2007 01:01:35 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+PLb9xCuSPhSzI/CXDHXWCfZZq7FkpPeR3OYcTh2
	6x6DbRbWVJ8NKQ
X-X-Sender: gene099@racer.site
In-Reply-To: <7vr6ia0w4i.fsf@gitster.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66471>

Hi,

On Wed, 28 Nov 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > The fundamental problem is that we cannot move 
> > handle_internal_command() into libgit.a, because it has pointers to 
> > all builtin cmd_*() functions.
> 
> What's wrong with having cmd_* functions in the library to begin with?

I was considering it not desirable (after all, the library is meant to 
have common functions in it), but you're right...

Ciao,
Dscho
