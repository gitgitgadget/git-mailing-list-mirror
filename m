From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Rename ".dotest/" to ".git/rebase" and ".dotest-merge"
 to "rebase-merge"
Date: Tue, 15 Jul 2008 18:10:28 -0700
Message-ID: <7v4p6qzla3.fsf@gitster.siamese.dyndns.org>
References: <73fd69b50807151408i6a916da6p7b89fe81e65fc717@mail.gmail.com>
 <20080715212211.GL6244@leksak.fem-net> <487D1B3D.70500@lsrfire.ath.cx>
 <alpine.DEB.1.00.0807160245440.2841@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	gitster@pobox.com, Stephan Beyer <s-beyer@gmx.net>,
	Joe Fiorini <joe@faithfulgeek.org>, git@vger.kernel.org,
	Jari Aalto <jari.aalto@cante.net>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jul 16 03:11:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIvYT-000547-Gr
	for gcvg-git-2@gmane.org; Wed, 16 Jul 2008 03:11:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753783AbYGPBKn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jul 2008 21:10:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752326AbYGPBKn
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jul 2008 21:10:43 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:35460 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751087AbYGPBKm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jul 2008 21:10:42 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 8BD342DACA;
	Tue, 15 Jul 2008 21:10:40 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 9278C2DAC9; Tue, 15 Jul 2008 21:10:31 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0807160245440.2841@eeepc-johanness> (Johannes
 Schindelin's message of "Wed, 16 Jul 2008 02:47:33 +0200 (CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 01AC6DF2-52D4-11DD-949B-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88621>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Since the files generated and used during a rebase are never to be
> tracked, they should live in $GIT_DIR.  While at it, avoid the rather
> meaningless term "dotest" to "rebase", and unhide ".dotest-merge".

I understand moving away from .dotest/ to .git/something, but I do not
follow the logic of making that something to rebase at all.  It is a
scratch area for "am" (and applymbox), isn't it?
