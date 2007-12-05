From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] Allow update hooks to update refs on their own.
Date: Wed, 05 Dec 2007 14:29:19 -0800
Message-ID: <7v8x48n5c0.fsf@gitster.siamese.dyndns.org>
References: <7vr6i8sfsa.fsf@gitster.siamese.dyndns.org>
	<20071202212224.GA22117@midwinter.com>
	<20071203021333.GC8322@coredump.intra.peff.net>
	<7vlk8csetl.fsf@gitster.siamese.dyndns.org>
	<5920F34B-A94B-4C24-A95B-D35F35A4F0C0@midwinter.com>
	<7vhciwn5rl.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Steven Grimm <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Wed Dec 05 23:29:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J02kV-0003da-Jc
	for gcvg-git-2@gmane.org; Wed, 05 Dec 2007 23:29:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752254AbXLEW30 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Dec 2007 17:29:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752247AbXLEW3Z
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Dec 2007 17:29:25 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:44575 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752218AbXLEW3Z (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Dec 2007 17:29:25 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 61F7F2F9;
	Wed,  5 Dec 2007 17:29:46 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id E30619D503;
	Wed,  5 Dec 2007 17:29:42 -0500 (EST)
In-Reply-To: <7vhciwn5rl.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Wed, 05 Dec 2007 14:19:58 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67207>

Junio C Hamano <gitster@pobox.com> writes:

> Ok, but the output from fetch is meant to be human readable and we do
> not promise parsability, so if we go this route (which I think you made

s/parsability/machine &/;

> a sensible argument for) we would need a hook on the pushing end to act
> on this (perhaps record the correspondence of pushed and rewritten sha1
> somewhere for the hook's own use).

s/on this/& information/;
s/own use/& in machine readable way/;
