From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/2] Teach @{-1} to git merge
Date: Sun, 15 Feb 2009 02:02:33 -0800
Message-ID: <7vbpt4nhl2.fsf@gitster.siamese.dyndns.org>
References: <7v4oyxzeay.fsf@gitster.siamese.dyndns.org>
 <76718490902132311j5add87bcpb103c951a8192b05@mail.gmail.com>
 <7vzlgpxz4g.fsf@gitster.siamese.dyndns.org>
 <7vskmhuzla.fsf_-_@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0902142332210.10279@pacific.mpi-cbg.de>
 <7vfxigqwsp.fsf@gitster.siamese.dyndns.org>
 <20090215182405.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, Jay Soffian <jaysoffian@gmail.com>
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Sun Feb 15 11:07:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYdu2-0006n2-CH
	for gcvg-git-2@gmane.org; Sun, 15 Feb 2009 11:07:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751596AbZBOKCo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Feb 2009 05:02:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751492AbZBOKCn
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Feb 2009 05:02:43 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:55728 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751285AbZBOKCn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Feb 2009 05:02:43 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id DAA4B99B28;
	Sun, 15 Feb 2009 05:02:41 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id DA2FD99B25; Sun,
 15 Feb 2009 05:02:35 -0500 (EST)
In-Reply-To: <20090215182405.6117@nanako3.lavabit.com> (Nanako Shiraishi's
 message of "Sun, 15 Feb 2009 18:24:05 +0900")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: C8A72E3A-FB47-11DD-ACF4-0433C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109987>

Nanako Shiraishi <nanako3@lavabit.com> writes:

> What I don't understand is your comments about 'git-show-branch'. It
> also takes any commits, not just branch names, and it's output doesn't
> seem to treat a branch name any specially from other commits.
>
> I think Johannes'es analogy with HEAD is correct.

I agree with you after thinking about it again; I stand corrected.
