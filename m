From: Jan Engelhardt <jengelh@inai.de>
Subject: Re: How to create the " [PATCH 0/5]" first email?
Date: Sun, 23 Sep 2012 14:03:33 +0200 (CEST)
Message-ID: <alpine.LNX.2.01.1209231401500.9625@nerf07.vanv.qr>
References: <1347710524-15404-1-git-send-email-pclouds@gmail.com> <F93DBBE1DDAA44A28C9020F9A58FD825@PhilipOakley> <7vzk4rz00y.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Philip Oakley <philipoakley@iee.org>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 23 14:03:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TFkuZ-00049H-DV
	for gcvg-git-2@plane.gmane.org; Sun, 23 Sep 2012 14:03:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753156Ab2IWMDi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Sep 2012 08:03:38 -0400
Received: from ares07.inai.de ([5.9.24.206]:46177 "EHLO seven.medozas.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752918Ab2IWMDi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Sep 2012 08:03:38 -0400
Received: by seven.medozas.de (Postfix, from userid 25121)
	id 7AD0E96A07C4; Sun, 23 Sep 2012 14:03:33 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by seven.medozas.de (Postfix) with ESMTP id 45ECC96A0307;
	Sun, 23 Sep 2012 14:03:33 +0200 (CEST)
In-Reply-To: <7vzk4rz00y.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.01 (LNX 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206237>


On Saturday 2012-09-15 19:08, Junio C Hamano wrote:
>
>If you plan to use "git send-email" to send the final results out,
>you should consider "git send-email" as your "MUA" in the quoted
>paragraph.  And that will be very platform independent viewpoint to
>see things from.
>
>"git format-patch -o my-series/ --cover-letter ..."  would treat
>"my-series/" directory as "MUA's drafts folder" and prepares the
>messages you would want to send out, and you can proof-read and edit
>the files in there before telling your "MUA" to send them out, with
>"git send-email ... my-series/*.patch" or something.

One can also send [0/n] with a normal MUA, and then use

 git send-email --in-reply-to '<messageidof0@yourhost.no>' commitrange


It's not like 0/n has to be emitted at the same second 1/n is :)
