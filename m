From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] http-push: remove MOVE step after PUT when sending
 objects to server
Date: Sun, 18 Jan 2009 22:14:44 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901182214180.3586@pacific.mpi-cbg.de>
References: <be6fef0d0901171224y35c3d95cn2d38639ac03c3b8f@mail.gmail.com> <7viqod5thi.fsf@gitster.siamese.dyndns.org> <be6fef0d0901171919ub28dda7ref6443abec3627aa@mail.gmail.com> <alpine.DEB.1.00.0901181425420.3586@pacific.mpi-cbg.de>
 <7vocy4wfb2.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Ray Chuan <rctay89@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 18 22:16:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOf0J-0003v2-VC
	for gcvg-git-2@gmane.org; Sun, 18 Jan 2009 22:16:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757368AbZARVOp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Jan 2009 16:14:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755915AbZARVOo
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jan 2009 16:14:44 -0500
Received: from mail.gmx.net ([213.165.64.20]:43524 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755889AbZARVOo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jan 2009 16:14:44 -0500
Received: (qmail invoked by alias); 18 Jan 2009 21:14:41 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp061) with SMTP; 18 Jan 2009 22:14:41 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19gbUh/VANgCa9VqD2DLlZcmGzQBG3IDNqKRFqM0F
	Xk+nq2Ujcd75p8
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <7vocy4wfb2.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.74
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106283>

Hi,

On Sun, 18 Jan 2009, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > Which unfortunately means that put && move must stay.
> 
> I still do not understand why it is unfortunate.

Because it is slow.

Ciao,
Dscho
