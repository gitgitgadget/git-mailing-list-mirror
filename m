From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] git-what: explain what to do next
Date: Tue, 27 May 2008 13:24:37 -0700
Message-ID: <7v3ao31omy.fsf@gitster.siamese.dyndns.org>
References: <1211877299-27255-1-git-send-email-sbejar@gmail.com>
 <alpine.DEB.1.00.0805271151430.30431@racer>
 <8aa486160805270558v40e7faabh7d4426731693f917@mail.gmail.com>
 <alpine.DEB.1.00.0805271411520.30431@racer>
 <8aa486160805270637m3fc640bfr9fa51eb917460e5c@mail.gmail.com>
 <20080527135259.GA12551@cuci.nl>
 <8aa486160805270721q64dff3f0gfbb9eb5384db027d@mail.gmail.com>
 <e06498070805271108t66a45abfy9abb5ed065e59e35@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?Q?Santi_B=C3=A9jar?= <sbejar@gmail.com>,
	"Stephen R. van den Berg" <srb@cuci.nl>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Steven Walter" <stevenrwalter@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 27 22:25:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K15jr-0003zZ-3v
	for gcvg-git-2@gmane.org; Tue, 27 May 2008 22:25:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758015AbYE0UYv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 May 2008 16:24:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757960AbYE0UYu
	(ORCPT <rfc822;git-outgoing>); Tue, 27 May 2008 16:24:50 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:61373 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757974AbYE0UYt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 May 2008 16:24:49 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 7CB7D5A9B;
	Tue, 27 May 2008 16:24:48 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id A01785A97; Tue, 27 May 2008 16:24:41 -0400 (EDT)
In-Reply-To: <e06498070805271108t66a45abfy9abb5ed065e59e35@mail.gmail.com>
 (Steven Walter's message of "Tue, 27 May 2008 14:08:35 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: F401C424-2C2A-11DD-9F5E-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83042>

"Steven Walter" <stevenrwalter@gmail.com> writes:

> Surely it has happened to everyone that you start a rebase, walk away
> and then continue hacking and committing with the rebase still in
> progress.  It isn't too bad for an experienced user to recover from
> this state, but prevention is much better than cure.  A simple "git
> what" command that could remind you of what you were doing would be a
> welcome addition, in my mind.

I haven't looked at the patch in question, but I'd agree with the above,
and that is why I use the $PS1 support in bash completion (especially the
resent one can tell between "am" and "rebase", which made it even nicer).
