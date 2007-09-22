From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Allow shell scripts to run with non-Bash /bin/sh
Date: Fri, 21 Sep 2007 17:18:16 -0700
Message-ID: <7vvea3h7sn.fsf@gitster.siamese.dyndns.org>
References: <20070921214346.GF97288@void.codelabs.ru>
	<7v8x6zinjf.fsf@gitster.siamese.dyndns.org>
	<86abrfy377.fsf@lola.quinscape.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Sat Sep 22 02:18:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IYshZ-0006J5-2D
	for gcvg-git-2@gmane.org; Sat, 22 Sep 2007 02:18:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753069AbXIVASY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Sep 2007 20:18:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752566AbXIVASY
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Sep 2007 20:18:24 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:44287 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753084AbXIVASX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Sep 2007 20:18:23 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 3A5FD13547B;
	Fri, 21 Sep 2007 20:18:42 -0400 (EDT)
In-Reply-To: <86abrfy377.fsf@lola.quinscape.zz> (David Kastrup's message of
	"Sat, 22 Sep 2007 02:05:32 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58900>

David Kastrup <dak@gnu.org> writes:

> But doing a break inside of the while _condition_ rather than the body
> just feels wrong to me.

Sorry, but that is not the issue on the thread is about.
BSD shell is failing the whole case statement when there is no
matching case arm.
