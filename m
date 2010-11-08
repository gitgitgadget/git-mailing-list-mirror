From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: Understanding and improving --word-diff
Date: Mon, 8 Nov 2010 17:33:06 +0100
Message-ID: <201011081733.06502.trast@student.ethz.ch>
References: <20101108151601.GF22067@login.drsnuggles.stderr.nl> <vpqlj53zuum.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, <git@vger.kernel.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Matthijs Kooijman <matthijs@stdin.nl>
X-From: git-owner@vger.kernel.org Mon Nov 08 17:33:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFUei-0007eN-Pi
	for gcvg-git-2@lo.gmane.org; Mon, 08 Nov 2010 17:33:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754224Ab0KHQdK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Nov 2010 11:33:10 -0500
Received: from gwse.ethz.ch ([129.132.178.237]:53236 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754081Ab0KHQdJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Nov 2010 11:33:09 -0500
Received: from CAS11.d.ethz.ch (172.31.38.211) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.254.0; Mon, 8 Nov
 2010 17:33:06 +0100
Received: from pctrast.inf.ethz.ch (129.132.153.233) by CAS11.d.ethz.ch
 (172.31.38.211) with Microsoft SMTP Server (TLS) id 14.1.218.12; Mon, 8 Nov
 2010 17:33:07 +0100
User-Agent: KMail/1.13.5 (Linux/2.6.36-90-desktop; KDE/4.5.3; x86_64; ; )
In-Reply-To: <vpqlj53zuum.fsf@bauges.imag.fr>
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160946>

Matthieu Moy wrote:
> Matthijs Kooijman <matthijs@stdin.nl> writes:
> 
> > Lastly, the "porcelain" word-diff format seems a bit weird to me. Is
> > the format specified somewhere, or are there any programs that use it
> > currently? I couldn't find any users inside the git.git tree itself?
> 
> There's a pending patch for "gitk --color-words". Actually, the
> porcelain format was precisely implemented to allow this patch to
> exist IIRC.

Also, my intent was to specify the format fully under its option
description.  It's rather simple, but if you think the
explanation/definition is inadequate, please provide a patch.  We'd
really want the writers of consumers (GUIs and such) to be very clear
about how it is formatted.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
