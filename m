From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] gitweb: quote commands properly when calling the shell
Date: Tue, 17 Jun 2008 16:41:08 -0700
Message-ID: <7vtzfr3a0b.fsf@gitster.siamese.dyndns.org>
References: <7vd4mg9824.fsf@gitster.siamese.dyndns.org>
 <1213739195-29284-1-git-send-email-LeWiemann@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Lea Wiemann <lewiemann@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 18 01:42:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8kod-0005lI-7y
	for gcvg-git-2@gmane.org; Wed, 18 Jun 2008 01:42:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754915AbYFQXlZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2008 19:41:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756271AbYFQXlY
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jun 2008 19:41:24 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:54688 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754899AbYFQXlY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2008 19:41:24 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 45BDE11D9F;
	Tue, 17 Jun 2008 19:41:21 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 8086F11D9C; Tue, 17 Jun 2008 19:41:16 -0400 (EDT)
In-Reply-To: <1213739195-29284-1-git-send-email-LeWiemann@gmail.com> (Lea
 Wiemann's message of "Tue, 17 Jun 2008 23:46:35 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: E3B900A8-3CC6-11DD-B204-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85344>

Lea Wiemann <lewiemann@gmail.com> writes:

> This eliminates the function git_cmd_str, which was used for composing
> command lines, and adds a quote_command function, which quotes all of
> its arguments (as in quote.c).

Looks sane.  Thanks.
