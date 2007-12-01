From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] "color.diff = true" is not "always" anymore.
Date: Fri, 30 Nov 2007 22:10:35 -0800
Message-ID: <7vd4tr6j38.fsf@gitster.siamese.dyndns.org>
References: <474B42EC.1000408@wanadoo.fr>
	<7vr6icej23.fsf@gitster.siamese.dyndns.org>
	<7vd4tuakzj.fsf_-_@gitster.siamese.dyndns.org>
	<20071128190439.GA11396@coredump.intra.peff.net>
	<7v4pf39m4j.fsf@gitster.siamese.dyndns.org>
	<20071201041549.GB30725@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Dec 01 07:11:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IyLZ8-0001OI-Kz
	for gcvg-git-2@gmane.org; Sat, 01 Dec 2007 07:11:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750768AbXLAGKm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Dec 2007 01:10:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750754AbXLAGKl
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Dec 2007 01:10:41 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:60673 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750730AbXLAGKk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Dec 2007 01:10:40 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 9689A2EF;
	Sat,  1 Dec 2007 01:11:01 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 2D7AB98CF8;
	Sat,  1 Dec 2007 01:10:59 -0500 (EST)
In-Reply-To: <20071201041549.GB30725@coredump.intra.peff.net> (Jeff King's
	message of "Fri, 30 Nov 2007 23:15:49 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66699>

Jeff King <peff@peff.net> writes:

> On Fri, Nov 30, 2007 at 06:36:44PM -0800, Junio C Hamano wrote:
>
>> > It would be nice to have a "git config --colorbool" option, but it has
>> > the unfortunate problem that the stdout of "git config" is piped back to
>> > the caller, so the isatty check is meaningless (and the "pager in use"
>> > is similarly tricky). Perhaps it should go in Git.pm, so it at least
>> > only needs to be written once.
>> 
>> About the isatty(3) check, you do not have to use the stdout to report
>> the result, though.  IOW, you could use the exit code from the command.
>
> I thought about that, but it feels a little wrong since it is so unlike
> all of the other interfaces to git-config.

Yeah, that is why I did not seriously suggest it.  The message you were
responding to was sitting in my "I do not know if this should go out"
box for a few days and was sent out purely by accident ;-)
