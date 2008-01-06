From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Allow git-mergetool to handle paths with a leading space
Date: Sun, 06 Jan 2008 02:18:54 -0800
Message-ID: <7vodbz5ka9.fsf@gitster.siamese.dyndns.org>
References: <47809E7E.2090708@dawes.za.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Rogan Dawes <rogan@dawes.za.net>
X-From: git-owner@vger.kernel.org Sun Jan 06 11:19:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JBSbO-0006UF-L4
	for gcvg-git-2@gmane.org; Sun, 06 Jan 2008 11:19:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752373AbYAFKTG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jan 2008 05:19:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752319AbYAFKTF
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Jan 2008 05:19:05 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:57713 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751174AbYAFKTE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jan 2008 05:19:04 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id D26C49863;
	Sun,  6 Jan 2008 05:19:00 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 76C559862;
	Sun,  6 Jan 2008 05:18:56 -0500 (EST)
In-Reply-To: <47809E7E.2090708@dawes.za.net> (Rogan Dawes's message of "Sun,
	06 Jan 2008 11:25:18 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69722>

Rogan Dawes <rogan@dawes.za.net> writes:

> Signed-off-by: Rogan Dawes <rogan@dawes.za.net>
>
> ---
> I am working on a project which has the root directory constructed
> with a leading space. i.e. ./ dir/. "read" skips the leading space
> char, and ends up with an incorrect filename, which can then not be
> found. Setting IFS=\n solves this problem.

Does the project have a file that has letter 'n' (en) in its name?
Have you tested your patch while having a conflict in that file?
