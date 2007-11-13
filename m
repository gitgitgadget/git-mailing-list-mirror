From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Cloning empty repositories, was Re: What is the idea for bare repositories?
Date: Tue, 13 Nov 2007 10:41:39 -0800
Message-ID: <7vir46t2cc.fsf@gitster.siamese.dyndns.org>
References: <86k5on8v6p.fsf@lola.quinscape.zz>
	<20071112131927.GA1701@c3sl.ufpr.br>
	<Pine.LNX.4.64.0711121355380.4362@racer.site>
	<200711121719.54146.wielemak@science.uva.nl>
	<Pine.LNX.4.64.0711121624330.4362@racer.site>
	<vpq3avbv2ju.fsf@bauges.imag.fr>
	<Pine.LNX.4.64.0711121715090.4362@racer.site>
	<18232.35893.243300.179076@lisa.zopyra.com>
	<Pine.LNX.4.64.0711121727130.4362@racer.site>
	<vpq7iknqrtp.fsf@bauges.imag.fr>
	<Pine.LNX.4.64.0711121755460.4362@racer.site>
	<vpqy7d3pck0.fsf@bauges.imag.fr>
	<Pine.LNX.4.64.0711121804400.4362@racer.site>
	<vpqoddzpc88.fsf@bauges.imag.fr>
	<7v4pfr2kmh.fsf@gitster.siamese.dyndns.org>
	<vpqzlxiiii6.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Bill Lear <rael@zopyra.com>,
	Jan Wielemaker <wielemak@science.uva.nl>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Tue Nov 13 19:42:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Is0iI-00020U-MR
	for gcvg-git-2@gmane.org; Tue, 13 Nov 2007 19:42:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758586AbXKMSlt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2007 13:41:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758060AbXKMSlt
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Nov 2007 13:41:49 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:52083 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752118AbXKMSls (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2007 13:41:48 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 9B5522FB;
	Tue, 13 Nov 2007 13:42:08 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 06A3E9546B;
	Tue, 13 Nov 2007 13:42:02 -0500 (EST)
In-Reply-To: <vpqzlxiiii6.fsf@bauges.imag.fr> (Matthieu Moy's message of "Tue,
	13 Nov 2007 10:48:01 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64824>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> To create an initial commit in a bare repository, the most natural way
> for me is to clone it, create the commit in the clone, and then push.
>
> Bare-ness _does_ matter for that.

You are still wrong.

The most natural is to create a commit in a non-bare repository
you create, and push into a bare empty repository.  The
repository that is pushed into can be non-bare, but bareness of
that does _NOT_ matter.

Where bareness matters is on your end, the local private
repository you create the initial commit in.
