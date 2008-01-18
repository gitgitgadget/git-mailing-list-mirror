From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git submodule when submodule is not a clone of a repository
Date: Fri, 18 Jan 2008 15:26:42 -0800
Message-ID: <7v3asubtql.fsf@gitster.siamese.dyndns.org>
References: <loom.20080118T171433-93@post.gmane.org>
	<8c5c35580801180946q3ba824e2s4c32ac504166c684@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Sergio Callegari" <sergio.callegari@gmail.com>,
	git@vger.kernel.org
To: "Lars Hjemli" <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 19 00:27:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JG0cQ-000416-Es
	for gcvg-git-2@gmane.org; Sat, 19 Jan 2008 00:27:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757262AbYARX0z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jan 2008 18:26:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758094AbYARX0y
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jan 2008 18:26:54 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:48360 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757119AbYARX0y (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jan 2008 18:26:54 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id D653C7399;
	Fri, 18 Jan 2008 18:26:52 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 687997395;
	Fri, 18 Jan 2008 18:26:49 -0500 (EST)
In-Reply-To: <8c5c35580801180946q3ba824e2s4c32ac504166c684@mail.gmail.com>
	(Lars Hjemli's message of "Fri, 18 Jan 2008 18:46:03 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71075>

"Lars Hjemli" <hjemli@gmail.com> writes:

> Actually, we could (and probably should) teach git-submodule not to
> fetch if the requested SHA1 is already available in the submodule,..

I think that is a very sensible optimization.
