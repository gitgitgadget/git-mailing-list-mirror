From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Make the git metapackage require the same version of the subpackages.
Date: Sun, 06 Jan 2008 13:24:30 -0800
Message-ID: <7vhchq4pgx.fsf@gitster.siamese.dyndns.org>
References: <20080106173501.GB9349@spitfire>
	<7vprwe4s8e.fsf@gitster.siamese.dyndns.org>
	<3f80363f0801061313o514fa01bje354503483db47ab@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "James Bowes" <jbowes@dangerouslyinc.com>
X-From: git-owner@vger.kernel.org Sun Jan 06 22:25:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JBczO-0003Oh-Eh
	for gcvg-git-2@gmane.org; Sun, 06 Jan 2008 22:25:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753877AbYAFVYg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jan 2008 16:24:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753642AbYAFVYg
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Jan 2008 16:24:36 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:62323 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753536AbYAFVYf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jan 2008 16:24:35 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 4570EAAD2;
	Sun,  6 Jan 2008 16:24:34 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id DEE0FAAD0;
	Sun,  6 Jan 2008 16:24:31 -0500 (EST)
In-Reply-To: <3f80363f0801061313o514fa01bje354503483db47ab@mail.gmail.com>
	(James Bowes's message of "Sun, 6 Jan 2008 16:13:26 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69747>

"James Bowes" <jbowes@dangerouslyinc.com> writes:

> I believe the obsolete is still needed, as you'd need a way to tell
> rpm to just get rid of git-p4 entirely.

Thanks.

I am also wondering what should happen to spec file if we were
to later re-introduce git-p4, but that is not an immediate
concern.
