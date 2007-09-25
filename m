From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add ability to specify SMTP server port when using git-send-email.
Date: Tue, 25 Sep 2007 16:12:10 -0700
Message-ID: <7vzlza2vcl.fsf@gitster.siamese.dyndns.org>
References: <1190759927-19493-1-git-send-email-glenn@rempe.us>
	<Pine.LNX.4.64.0709260004090.28395@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Glenn Rempe <glenn@rempe.us>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Sep 26 01:12:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IaJZr-0002Kz-1q
	for gcvg-git-2@gmane.org; Wed, 26 Sep 2007 01:12:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751499AbXIYXMS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Sep 2007 19:12:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751303AbXIYXMR
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Sep 2007 19:12:17 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:43266 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751486AbXIYXMR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Sep 2007 19:12:17 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id C9BB313BBF7;
	Tue, 25 Sep 2007 19:12:34 -0400 (EDT)
In-Reply-To: <Pine.LNX.4.64.0709260004090.28395@racer.site> (Johannes
	Schindelin's message of "Wed, 26 Sep 2007 00:05:02 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59191>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Tue, 25 Sep 2007, Glenn Rempe wrote:
>
>> +if (($smtp_server =~ /:\d+/) && (defined $smtp_server_port)) {
>
> Not that I want to be a PITA, but this breaks down with IPv6, right?

Right.  Do we care about symbolic "server.addre.ss:smtp"
notation as well, I wonder?
