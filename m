From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git stash: one bug and one feature request
Date: Fri, 04 Jan 2008 16:31:49 -0800
Message-ID: <7vtzltglje.fsf@gitster.siamese.dyndns.org>
References: <e5bfff550801040814n82f34b2g17c485a207093440@mail.gmail.com>
	<Pine.LNX.4.64.0801041030420.31161@torch.nrlssc.navy.mil>
	<477E6D26.9020809@obry.net>
	<e5bfff550801040944p7f8e722asfa726b34a4a712fa@mail.gmail.com>
	<477E7439.9090209@nrlssc.navy.mil>
	<e5bfff550801041005x3ab682dam8535c7bde75038dc@mail.gmail.com>
	<477E7C3D.8030501@nrlssc.navy.mil>
	<e5bfff550801041046p534b4869l2919494a8e4ef711@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Brandon Casey" <casey@nrlssc.navy.mil>,
	"Pascal Obry" <pascal@obry.net>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Marco Costalba" <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 05 01:32:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JAwxj-0006go-M3
	for gcvg-git-2@gmane.org; Sat, 05 Jan 2008 01:32:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754097AbYAEAcF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jan 2008 19:32:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754081AbYAEAcF
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Jan 2008 19:32:05 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:49929 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754071AbYAEAcC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jan 2008 19:32:02 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id D37A3646B;
	Fri,  4 Jan 2008 19:31:58 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 1B0586468;
	Fri,  4 Jan 2008 19:31:50 -0500 (EST)
In-Reply-To: <e5bfff550801041046p534b4869l2919494a8e4ef711@mail.gmail.com>
	(Marco Costalba's message of "Fri, 4 Jan 2008 19:46:51 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69621>

"Marco Costalba" <mcostalba@gmail.com> writes:

> I'm very bad at naming, so I don't argue any more.
>
> Just one thing (that is the only that matters) call this command as
> you want but let it take one argument, the name of the reflog to
> remove:
>
> git stash drop stash@{3}
>
> should be allowed.
>
> git stash drop
>
> defaults to  stash@{0}

I do not care the wording either way, but my prediction is that
people will mistype "stash clear" when they meant "stash drop",
and we will end up not allowing the implicit "drop the top one
only" behaviour.
