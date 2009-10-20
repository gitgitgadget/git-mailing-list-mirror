From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [RFC/PATCH] fsck: default to "git fsck --full"
Date: Tue, 20 Oct 2009 15:00:31 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0910201457310.21460@xanadu.home>
References: <loom.20091019T094924-194@post.gmane.org>
 <4ADC2D45.3020803@viscovery.net>
 <alpine.DEB.1.00.0910191202020.4985@pacific.mpi-cbg.de>
 <7v7hur1a0h.fsf@alter.siamese.dyndns.org> <vpqy6n6shri.fsf@bauges.imag.fr>
 <7vfx9esgvt.fsf@alter.siamese.dyndns.org>
 <81b0412b0910200225g47220cc9wa2e82290a853c85d@mail.gmail.com>
 <alpine.DEB.1.00.0910201221250.4985@pacific.mpi-cbg.de>
 <vpq1vkygtx6.fsf@bauges.imag.fr> <7v3a5doqcg.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Alex Riesen <raa.lkml@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Sergio Callegari <sergio.callegari@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 20 21:00:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0Jwl-0001Ci-Ax
	for gcvg-git-2@lo.gmane.org; Tue, 20 Oct 2009 21:00:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752079AbZJTTA3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Oct 2009 15:00:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751603AbZJTTA3
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Oct 2009 15:00:29 -0400
Received: from relais.videotron.ca ([24.201.245.36]:21959 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751356AbZJTTA2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Oct 2009 15:00:28 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KRT0064VU4V9D80@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 20 Oct 2009 15:00:32 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <7v3a5doqcg.fsf_-_@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130826>

On Tue, 20 Oct 2009, Junio C Hamano wrote:

> diff --git a/Documentation/RelNotes-1.6.6.txt b/Documentation/RelNotes-1.6.6.txt
> index 5f1fecb..1896e05 100644
> --- a/Documentation/RelNotes-1.6.6.txt
> +++ b/Documentation/RelNotes-1.6.6.txt
> @@ -1,6 +1,13 @@
>  GIT v1.6.6 Release Notes
>  ========================
>  
> +In this release, "git fsck" defaults to "git fsck --full" and checks
> +packfiles.  If you prefer a quicker check only on loose objects (the
             ^^

Might be worth mentioning explicitly that, because of that change, plain 
fsck is now going to take much longer to complete.


Nicolas
