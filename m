From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH] clean: confirm before cleaning files and directories
Date: Fri, 26 Apr 2013 10:53:09 +0200
Message-ID: <87y5c565ca.fsf@linux-k42r.v.cablecom.net>
References: <1826d070612808b301f9295838e226e02d8097ad.1366963586.git.worldhello.net@gmail.com>
	<vpqfvydhfbx.fsf@grenoble-inp.fr>
	<CANYiYbFzEoEgJzKsB_hiKNy2JCxaTDX30wXNjnzComOzJJF_cw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 26 10:53:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVeP9-0007pI-Cc
	for gcvg-git-2@plane.gmane.org; Fri, 26 Apr 2013 10:53:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755292Ab3DZIxN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Apr 2013 04:53:13 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:56254 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751228Ab3DZIxM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Apr 2013 04:53:12 -0400
Received: from CAS12.d.ethz.ch (172.31.38.212) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Fri, 26 Apr
 2013 10:53:06 +0200
Received: from linux-k42r.v.cablecom.net.ethz.ch (129.132.153.233) by
 CAS12.d.ethz.ch (172.31.38.212) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Fri, 26 Apr 2013 10:53:09 +0200
In-Reply-To: <CANYiYbFzEoEgJzKsB_hiKNy2JCxaTDX30wXNjnzComOzJJF_cw@mail.gmail.com>
	(Jiang Xin's message of "Fri, 26 Apr 2013 16:41:19 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222515>

Jiang Xin <worldhello.net@gmail.com> writes:

> I don't know how many programmers had been bitten by runing `git clean -fdx`,
> but I bet there were some. I think safety should be put to the 1st place.
> It is because "clean.requireForce" defaults to true, all people trend to run
> 'git clean' with the '--force/-f' option.

But if that's the real problem, wouldn't it be better to introduce
something like clean.requireForce=interactive (or 'ask', or whatever you
make up) which will be like clean.requireForce=true except that when on
a TTY, we ask the user?

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
