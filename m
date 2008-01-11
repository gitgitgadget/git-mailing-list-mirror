From: Junio C Hamano <gitster@pobox.com>
Subject: Re: CRLF problems with Git on Win32
Date: Thu, 10 Jan 2008 17:15:57 -0800
Message-ID: <7v63y15fhu.fsf@gitster.siamese.dyndns.org>
References: <7vmyrgry20.fsf@gitster.siamese.dyndns.org>
	<C3AC2971.10D2D%jefferis@gmail.com> <47868530.2010501@dawes.za.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Gregory Jefferis <jefferis@gmail.com>,
	Steffen Prohaska <prohaska@zib.de>,
	Git Mailing List <git@vger.kernel.org>
To: Rogan Dawes <lists@dawes.za.net>
X-From: git-owner@vger.kernel.org Fri Jan 11 02:16:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JD8Vm-0002k4-MG
	for gcvg-git-2@gmane.org; Fri, 11 Jan 2008 02:16:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754014AbYAKBQO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jan 2008 20:16:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755610AbYAKBQO
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jan 2008 20:16:14 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:52947 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753762AbYAKBQN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jan 2008 20:16:13 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 22F714951;
	Thu, 10 Jan 2008 20:16:12 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id B8C66494F;
	Thu, 10 Jan 2008 20:16:03 -0500 (EST)
In-Reply-To: <47868530.2010501@dawes.za.net> (Rogan Dawes's message of "Thu,
	10 Jan 2008 22:50:56 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70114>

Rogan Dawes <lists@dawes.za.net> writes:

> One example that bit me recently was "git-apply --whitespace=strip"

You might want to go back the list archive for a few days to
find this patch:

    [PATCH 2/2] core.whitespace cr-at-eol-is-ok

and try it out.
