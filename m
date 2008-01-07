From: Junio C Hamano <gitster@pobox.com>
Subject: Re: CRLF problems with Git on Win32
Date: Mon, 07 Jan 2008 02:00:59 -0800
Message-ID: <7vzlviymxw.fsf@gitster.siamese.dyndns.org>
References: <Pine.LNX.4.64.0801071010340.1864@ds9.cixit.se>
	<5C0F88FD-AB2F-4BAD-ADEC-75428F14260F@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Peter Karlsson <peter@softwolves.pp.se>,
	Git Mailing List <git@vger.kernel.org>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Mon Jan 07 11:02:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JBonv-0003NY-UI
	for gcvg-git-2@gmane.org; Mon, 07 Jan 2008 11:02:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754628AbYAGKBJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jan 2008 05:01:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754551AbYAGKBJ
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Jan 2008 05:01:09 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:46035 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754628AbYAGKBI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jan 2008 05:01:08 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 5FD08676B;
	Mon,  7 Jan 2008 05:01:06 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 96D706766;
	Mon,  7 Jan 2008 05:01:01 -0500 (EST)
In-Reply-To: <5C0F88FD-AB2F-4BAD-ADEC-75428F14260F@zib.de> (Steffen Prohaska's
	message of "Mon, 7 Jan 2008 10:57:52 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69777>

Steffen Prohaska <prohaska@zib.de> writes:

> Per default, CRLF conversion is disabled in msysgit.

That's interesting, as core.autocrlf was invented _specifically_
for use on Windows.
