From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 4/4] fast-import: only store commit objects
Date: Mon, 6 May 2013 23:32:29 -0500 (CDT)
Message-ID: <alpine.DEB.1.00.1305062331190.8213@s15462909.onlinehome-server.info>
References: <1367555502-4706-1-git-send-email-felipe.contreras@gmail.com> <1367555502-4706-5-git-send-email-felipe.contreras@gmail.com> <87y5bw3q1s.fsf@hexa.v.cablecom.net> <CAMP44s1R9hAMZ=DQoPiTVi3+40NpADjVFU7tYovZA8W-PWEhhg@mail.gmail.com>
 <518785B3.3050606@alum.mit.edu> <87ip2wflg0.fsf@linux-k42r.v.cablecom.net> <518789D1.4010905@alum.mit.edu> <7v38u0t9va.fsf@alter.siamese.dyndns.org> <CAMP44s1HASAuF0ECCvJr66WeqopDzLZQ12pKFsc-j5_VCDrizg@mail.gmail.com> <CAMP44s2KHH1n0vHB0Mdv-M2xV97KA9FMc6UrPyYyxD+2jsvfTA@mail.gmail.com>
 <518871A0.8030707@alum.mit.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@inf.ethz.ch>, git@vger.kernel.org,
	Antoine Pelisse <apelisse@gmail.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue May 07 06:32:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZZZv-0007dL-4r
	for gcvg-git-2@plane.gmane.org; Tue, 07 May 2013 06:32:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759667Ab3EGEcf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 May 2013 00:32:35 -0400
Received: from mout.gmx.net ([212.227.15.19]:49328 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759661Ab3EGEcd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 May 2013 00:32:33 -0400
Received: from mailout-de.gmx.net ([10.1.76.20]) by mrigmx.server.lan
 (mrigmx002) with ESMTP (Nemesis) id 0M5JXV-1UM3Wa0yWl-00zSva for
 <git@vger.kernel.org>; Tue, 07 May 2013 06:32:31 +0200
Received: (qmail invoked by alias); 07 May 2013 04:32:31 -0000
Received: from s15462909.onlinehome-server.info (EHLO s15462909.onlinehome-server.info) [87.106.4.80]
  by mail.gmx.net (mp020) with SMTP; 07 May 2013 06:32:31 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19EMYVMiihEcVC5Ib0Ex8s24Dwbp+jNsM/FNNgWlH
	TGitdubdo6yLwf
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <518871A0.8030707@alum.mit.edu>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223540>

Hi Michael,

On Tue, 7 May 2013, Michael Haggerty wrote:

> I knew about the "type" command but I was under the impression that it
> is intended for text files and can corrupt binary files.  Are you sure
> that using "type" as you suggest is binary-clean?

"type" is not binary-clean. At least on some Windows versions, "type" also
has a limit on file size.

Ciao,
Dscho
