From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Brown paper bag fix to previous send-email change
Date: Tue, 11 Dec 2007 00:02:09 -0800
Message-ID: <7vsl29fym6.fsf@gitster.siamese.dyndns.org>
References: <1197356116-12176-1-git-send-email-mh@glandium.org>
	<7v3au9hfuj.fsf@gitster.siamese.dyndns.org>
	<20071211074427.GA12959@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Tue Dec 11 09:02:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J204r-0002xC-Ij
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 09:02:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751984AbXLKIC1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2007 03:02:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752010AbXLKIC1
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 03:02:27 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:54615 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750847AbXLKIC0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2007 03:02:26 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 72DBB40A3;
	Tue, 11 Dec 2007 03:02:20 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id E4BFC40A2;
	Tue, 11 Dec 2007 03:02:16 -0500 (EST)
In-Reply-To: <20071211074427.GA12959@glandium.org> (Mike Hommey's message of
	"Tue, 11 Dec 2007 08:44:28 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67821>

Mike Hommey <mh@glandium.org> writes:

> On Mon, Dec 10, 2007 at 11:04:36PM -0800, Junio C Hamano wrote:
>> Mike Hommey <mh@glandium.org> writes:
>> 
>> > My previous change led to the In-Reply-To header being <> when the given
>> > value was empty. This fixes it.
>> >
>> > Signed-off-by: Mike Hommey <mh@glandium.org>
>> > ---
>> >
>> >  I think I have an antispam problem somewhere with this patch, because even
>> >  keeping sending it, it never reached the list. And Junio didn't answer to my
>> >  private message about it, so I guess that was some server being smart with
>> >  the subject line. *sigh*
>> >
>> >  PS: sorry Junio if you get this patch multiple time.
>> 
>> No, I happened to have noticed the same and have an almost identical fix
>> (I said "defined $initial_reply_to") already queued in my tree.
>
> Testing "defined $initial_reply_to" might not be enough, because $initial_reply_to
> can be defined and empty.

And if empty what does your regexp do?  Produce "<>"?  How's that
useful?
