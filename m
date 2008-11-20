From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git commit won't add an untracked file given on the command line
Date: Wed, 19 Nov 2008 16:36:39 -0800
Message-ID: <7vwsezqlm0.fsf@gitster.siamese.dyndns.org>
References: <20081118211237.234d8035@crow>
 <200811182227.20076.fge@one2team.com> <20081118214730.005fc72d@crow>
 <alpine.DEB.1.00.0811190206170.30769@pacific.mpi-cbg.de>
 <20081119095452.3018d2de@crow>
 <alpine.DEB.1.00.0811191226530.30769@pacific.mpi-cbg.de>
 <7vd4grsveo.fsf@gitster.siamese.dyndns.org>
 <alpine.LNX.1.00.0811191247560.19665@iabervon.org>
 <7v7i6zs4ay.fsf@gitster.siamese.dyndns.org>
 <alpine.LNX.1.00.0811191809430.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mark Burton <markb@ordern.com>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Thu Nov 20 01:39:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L2xZe-0003Xe-Ml
	for gcvg-git-2@gmane.org; Thu, 20 Nov 2008 01:39:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751026AbYKTAhz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Nov 2008 19:37:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751929AbYKTAhz
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Nov 2008 19:37:55 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:41130 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751009AbYKTAhy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Nov 2008 19:37:54 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 03F5217188;
	Wed, 19 Nov 2008 19:37:50 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id CDF4617183; Wed,
 19 Nov 2008 19:36:41 -0500 (EST)
In-Reply-To: <alpine.LNX.1.00.0811191809430.19665@iabervon.org> (Daniel
 Barkalow's message of "Wed, 19 Nov 2008 18:52:36 -0500 (EST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 759784A6-B69B-11DD-ABEC-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101385>

Daniel Barkalow <barkalow@iabervon.org> writes:

> There are two possible limits that would preserve your case while handling 
> Mark's case: one is to only look at untracked files at all for names that 
> don't match any tracked files, and the other (independantly) is to treat 
> names as single filenames instead of patterns for untracked files.
>
> Either of these (or both) should keep the existing behavior for using a 
> pattern on the command line as a filter for which of the tracked files to 
> commit (since any pattern of tracked files won't be the name of an 
> individual untracked file).

Perhaps.  I am starting to think that "Did you forget to 'git add'?" is
actually the best behaviour we can have ;-)
