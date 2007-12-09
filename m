From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/4] Use strbuf in http code
Date: Sun, 09 Dec 2007 10:36:53 -0800
Message-ID: <7vy7c3ogu2.fsf@gitster.siamese.dyndns.org>
References: <1197219900-19334-1-git-send-email-mh@glandium.org>
	<1197219900-19334-2-git-send-email-mh@glandium.org>
	<7vy7c3pwek.fsf@gitster.siamese.dyndns.org>
	<20071209182408.GA9427@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Nick Hengeveld <nickh@reactrix.com>
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Sun Dec 09 19:37:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1R2D-0001CK-Rs
	for gcvg-git-2@gmane.org; Sun, 09 Dec 2007 19:37:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752895AbXLIShH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Dec 2007 13:37:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751009AbXLIShG
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Dec 2007 13:37:06 -0500
Received: from a-sasl-quonix.pobox.com ([208.72.237.25]:39076 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751659AbXLIShE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Dec 2007 13:37:04 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 4A7AF4445;
	Sun,  9 Dec 2007 13:36:59 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id DA9124444;
	Sun,  9 Dec 2007 13:36:55 -0500 (EST)
In-Reply-To: <20071209182408.GA9427@glandium.org> (Mike Hommey's message of
	"Sun, 9 Dec 2007 19:24:08 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67649>

Mike Hommey <mh@glandium.org> writes:

> Both codes are also buggy in case the ref is a symbolic ref, and that
> happens. I got bitten by this while testing.
>
> Considering the assumption being made that refs are all properly filled
> with sha1s, both codes are mostly equally bad.
>
> Fixing the issue would obviously be the subject for another patch.

Ok, I'll reject [2/4] and expect a reroll.
