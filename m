From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/2] Teach @{-1} to git merge
Date: Wed, 25 Feb 2009 16:11:23 -0800
Message-ID: <7v8wnuys44.fsf@gitster.siamese.dyndns.org>
References: <7v4oyxzeay.fsf@gitster.siamese.dyndns.org>
 <76718490902132311j5add87bcpb103c951a8192b05@mail.gmail.com>
 <7vzlgpxz4g.fsf@gitster.siamese.dyndns.org>
 <7vskmhuzla.fsf_-_@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0902142332210.10279@pacific.mpi-cbg.de>
 <7vfxigqwsp.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0902151212320.10279@pacific.mpi-cbg.de>
 <7v1vtzf234.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0902161140160.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jay Soffian <jaysoffian@gmail.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Feb 26 01:13:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcTsI-0006xN-94
	for gcvg-git-2@gmane.org; Thu, 26 Feb 2009 01:13:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757267AbZBZALe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Feb 2009 19:11:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756284AbZBZALd
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Feb 2009 19:11:33 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:56659 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756244AbZBZALd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Feb 2009 19:11:33 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id F36D91BFC;
	Thu, 26 Feb 2009 19:11:27 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 4B2471BF9; Thu,
 26 Feb 2009 19:11:24 -0500 (EST)
In-Reply-To: <alpine.DEB.1.00.0902161140160.10279@pacific.mpi-cbg.de>
 (Johannes Schindelin's message of "Mon, 16 Feb 2009 11:41:00 +0100 (CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 2D885670-0463-11DE-ABDD-8D02133F2F75-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111513>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi,
>
> On Sun, 15 Feb 2009, Junio C Hamano wrote:
>
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>> 
>> > However, IMO there is a much worse issue lurking: people might want to 
>> > _know_ what "@{-2}" would expand to, _without_ switching branches.
>> 
>> "git branch --history" anyone?
>
> For a moment, you had me convinced it already exists, and I only 
> understood after "git grep history builtin-branch.c" came up empty.
>
> ;-)

$ git rev-parse --symbolic-full-name @{-24}

seem to work for this purpose ;-)
