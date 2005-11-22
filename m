From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] speedup allocation in pack-redundant.c
Date: Tue, 22 Nov 2005 15:08:52 -0800
Message-ID: <7vr798b7qz.fsf@assigned-by-dhcp.cox.net>
References: <81b0412b0511220656l528436b1xea80ee18965e4dda@mail.gmail.com>
	<7vek58ct4b.fsf@assigned-by-dhcp.cox.net>
	<4383A053.8020100@etek.chalmers.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 23 00:10:11 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EehFy-0000FU-3R
	for gcvg-git@gmane.org; Wed, 23 Nov 2005 00:08:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030234AbVKVXIz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 22 Nov 2005 18:08:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030235AbVKVXIy
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Nov 2005 18:08:54 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:56736 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1030234AbVKVXIy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Nov 2005 18:08:54 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051122230825.EMOK15695.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 22 Nov 2005 18:08:25 -0500
To: Lukas =?iso-8859-1?Q?Sandstr=F6m?= <lukass@etek.chalmers.se>
In-Reply-To: <4383A053.8020100@etek.chalmers.se> (Lukas =?iso-8859-1?Q?San?=
 =?iso-8859-1?Q?dstr=F6m's?= message
	of "Tue, 22 Nov 2005 23:48:51 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12582>

Lukas Sandstr=F6m <lukass@etek.chalmers.se> writes:

> Did someone else notice an improvement?

Not me.  I merged it only for its clean-up value, not immediate
performance reasons.
