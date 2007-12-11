From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Brown paper bag fix to previous send-email change
Date: Mon, 10 Dec 2007 23:04:36 -0800
Message-ID: <7v3au9hfuj.fsf@gitster.siamese.dyndns.org>
References: <1197356116-12176-1-git-send-email-mh@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Tue Dec 11 08:05:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1zAy-0007BV-Nz
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 08:05:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751092AbXLKHEr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2007 02:04:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751832AbXLKHEq
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 02:04:46 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:52808 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751092AbXLKHEq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2007 02:04:46 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id DF4FC4E7D;
	Tue, 11 Dec 2007 02:04:41 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 780194E7C;
	Tue, 11 Dec 2007 02:04:38 -0500 (EST)
In-Reply-To: <1197356116-12176-1-git-send-email-mh@glandium.org> (Mike
	Hommey's message of "Tue, 11 Dec 2007 07:55:16 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67814>

Mike Hommey <mh@glandium.org> writes:

> My previous change led to the In-Reply-To header being <> when the given
> value was empty. This fixes it.
>
> Signed-off-by: Mike Hommey <mh@glandium.org>
> ---
>
>  I think I have an antispam problem somewhere with this patch, because even
>  keeping sending it, it never reached the list. And Junio didn't answer to my
>  private message about it, so I guess that was some server being smart with
>  the subject line. *sigh*
>
>  PS: sorry Junio if you get this patch multiple time.

No, I happened to have noticed the same and have an almost identical fix
(I said "defined $initial_reply_to") already queued in my tree.
