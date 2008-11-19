From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix deletion of last character in levenshtein distance
Date: Wed, 19 Nov 2008 05:13:46 -0800
Message-ID: <7vhc63svsl.fsf@gitster.siamese.dyndns.org>
References: <20081118185326.12721.71576.stgit@arrakis.enst.fr>
 <alpine.DEB.1.00.0811190151000.30769@pacific.mpi-cbg.de>
 <2008-11-19-09-42-45+trackit+sam@rfc1149.net>
 <alpine.DEB.1.00.0811191053250.30769@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Samuel Tardieu <sam@rfc1149.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Nov 19 14:15:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L2mu0-0008Dy-6W
	for gcvg-git-2@gmane.org; Wed, 19 Nov 2008 14:15:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752857AbYKSNON (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Nov 2008 08:14:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752852AbYKSNON
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Nov 2008 08:14:13 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:33281 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752824AbYKSNOM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Nov 2008 08:14:12 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 6508F7FC61;
	Wed, 19 Nov 2008 08:14:10 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id D43E37FC60; Wed,
 19 Nov 2008 08:13:53 -0500 (EST)
In-Reply-To: <alpine.DEB.1.00.0811191053250.30769@pacific.mpi-cbg.de>
 (Johannes Schindelin's message of "Wed, 19 Nov 2008 10:57:26 +0100 (CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: F400B660-B63B-11DD-A035-9CEDC82D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101339>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Okay, I understand now, _after_ having looked at the original 
> levenshtein.c.
>
> IOW you could have made my task of reviewing your patch much easier.
>
> Anyway, here is my
>
> 	Acked-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> Thanks for the bugfix,

In other words, even the original author's head exploded without looking
at extra context lines around the patch.

It is a sure sign that the original implementation was too scantily
described, and that the fix was not explained well in the proposed commit
log message (i.e. in what corner cases the original was bad in what way,
and how the patch fixes it).

I shouldn't have to decipher the original and the fixed version with
pencil and paper when re-reviewing Dscho's Ack.
