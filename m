From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Shift object enumeration out of upload-pack
Date: Sun, 07 Jun 2009 19:36:51 -0700
Message-ID: <7vvdn78n98.fsf@alter.siamese.dyndns.org>
References: <c77435a80906071834m1600d23dpb4a1b58c7a61361d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>, sam@vilain.net, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Andreas Ericsson <exon@op5.se>,
	Christian Couder <christian@couder.net>,
	Jeff King <peff@peff.net>
To: Nick Edelen <sirnot@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 08 04:37:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDUjJ-0003BC-Np
	for gcvg-git-2@gmane.org; Mon, 08 Jun 2009 04:36:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754703AbZFHCgu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Jun 2009 22:36:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754407AbZFHCgu
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Jun 2009 22:36:50 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:55205 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754580AbZFHCgt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jun 2009 22:36:49 -0400
Received: from fed1rmimpo03.cox.net ([70.169.32.75])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090608023651.RYAT25927.fed1rmmtao106.cox.net@fed1rmimpo03.cox.net>;
          Sun, 7 Jun 2009 22:36:51 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo03.cox.net with bizsmtp
	id 1Ecr1c0014aMwMQ04EcrUP; Sun, 07 Jun 2009 22:36:51 -0400
X-VR-Score: -100.00
X-Authority-Analysis: v=1.0 c=1 a=6T3YdD5i54EA:10 a=7Bo2R7OvxYYA:10
 a=pGLkceISAAAA:8 a=6VC1-P1-AAAA:8 a=lNKms3FrE3tQq5Wp9d0A:9
 a=Fv0HF69H1viZwkoROkH-84zGmL4A:4 a=MSl-tDqOz04A:10 a=LRnQQUT8V1QA:10
X-CM-Score: 0.00
In-Reply-To: <c77435a80906071834m1600d23dpb4a1b58c7a61361d@mail.gmail.com> (Nick Edelen's message of "Mon\, 8 Jun 2009 03\:34\:28 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121031>

Nick Edelen <sirnot@gmail.com> writes:

> okie dokie.  is this good?

No.  The above line should be after "---".

> From: Nick Edelen <sirnot@gmail.com>
> Subject: [PATCH] Shift object enumeration out of upload-pack

And these two are not necessary, as you are not forwarding somebody else's
mail nor sending from an account that you do not to be recorded as the
author (i.e. your RFC2822 "From: " header is the same as this one).

> Offload object enumeration in upload-pack to pack-objects, but fall
> back on internal revision walker for shallow interaction.  Test t5530
> updated to reflect mechanism change.

Here, "to reflect mechanism change" is not quite a good enough
description.  Your explanation to Nico was much better.

> Signed-off-by: Nick Edelen <sirnot@gmail.com>
> Acked-by: Nicolas Pitre <nico@cam.org>

By the way, the proposed commit log message describes what the patch does
(i.e. "shifts enumeration from one process to the other"), but does not
answer more important question.  Please say _why_ it is a good idea to do
so in the message.

Thanks.
