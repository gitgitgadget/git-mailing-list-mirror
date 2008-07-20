From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] git-add -a: add all files
Date: Sun, 20 Jul 2008 12:56:42 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807201250530.3305@eeepc-johanness>
References: <alpine.DEB.1.00.0807161804400.8950@racer>  <7vmykhpn6z.fsf@gitster.siamese.dyndns.org>  <20080717155538.GE11759@fieldses.org>  <alpine.DEB.1.00.0807171915420.8986@racer>  <7vtzeofjpi.fsf@gitster.siamese.dyndns.org>  <alpine.DEB.1.00.0807171940160.8986@racer>
  <48806897.1080404@fastmail.fm>  <76718490807181318o228171f9j836aaca2edb9b377@mail.gmail.com>  <7vsku5grpr.fsf@gitster.siamese.dyndns.org>  <7vk5fhgrm6.fsf_-_@gitster.siamese.dyndns.org> <905315640807192120k45b8c0e3k5b341e77c466dde@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Michael J Gruber <michaeljgruber+gmane@fastmail.fm>,
	Jay Soffian <jaysoffian@gmail.com>
To: Tarmigan <tarmigan+git@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 20 12:56:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKWb1-0003Rr-Aj
	for gcvg-git-2@gmane.org; Sun, 20 Jul 2008 12:56:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755877AbYGTKzy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jul 2008 06:55:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755863AbYGTKzy
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jul 2008 06:55:54 -0400
Received: from mail.gmx.net ([213.165.64.20]:44827 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754556AbYGTKzy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jul 2008 06:55:54 -0400
Received: (qmail invoked by alias); 20 Jul 2008 10:55:52 -0000
Received: from 88-107-142-10.dynamic.dsl.as9105.com (EHLO eeepc-johanness.st-andrews.ac.uk) [88.107.142.10]
  by mail.gmx.net (mp047) with SMTP; 20 Jul 2008 12:55:52 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19wKYZf93Zwwd1DUWnqFNARUVGFGbwR9hpOWoE/ua
	80RCafX4KGEq89
X-X-Sender: user@eeepc-johanness
In-Reply-To: <905315640807192120k45b8c0e3k5b341e77c466dde@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.72
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89182>

Hi,

On Sat, 19 Jul 2008, Tarmigan wrote:

> It's too bad that 'commit -a' and 'add -a' will have different
> meanings.

Two things:

- add and commit are two _different_ operations, not only in name, but 
  also in nature.  The fact that "commit -a" calls "add" is a _pure_ 
  convenience.  It does not change the fact that "add" and "commit" are 
  completely, utterly different.

- if you are a heavy user of "commit -a", chances are that your history is 
  not really useful, because you committed unrelated changes accidentally 
  in the same commit.

The latter point, BTW, is the reason I _never_ teach the "-a" option 
(actually, I teach no option at all) in my first two Git lessons.

Ciao,
Dscho
