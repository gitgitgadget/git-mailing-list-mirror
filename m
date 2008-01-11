From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Use commit template when cherry picking
Date: Fri, 11 Jan 2008 10:59:09 -0800
Message-ID: <7v7iig2npe.fsf@gitster.siamese.dyndns.org>
References: <20080111074505.GC14022@plexity.net>
	<alpine.LSU.1.00.0801111208020.31053@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Deepak Saxena <dsaxena@plexity.net>, git@vger.kernel.org,
	Perry Wagle <pwagle@mvista.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jan 11 19:59:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDP6e-0003Yh-Cp
	for gcvg-git-2@gmane.org; Fri, 11 Jan 2008 19:59:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761331AbYAKS7Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jan 2008 13:59:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761329AbYAKS7Z
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jan 2008 13:59:25 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:42768 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761322AbYAKS7Y (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jan 2008 13:59:24 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id C865C58B3;
	Fri, 11 Jan 2008 13:59:21 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 508C158B0;
	Fri, 11 Jan 2008 13:59:17 -0500 (EST)
In-Reply-To: <alpine.LSU.1.00.0801111208020.31053@racer.site> (Johannes
	Schindelin's message of "Fri, 11 Jan 2008 12:10:37 +0000 (GMT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70190>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> I would do a combination of "cherry-pick -n", "cat-file commit <commit> | 
> sed '1,/^$/d'" and "commit -F" or "commit -f".

Doesn't cherry-pick have -e switch to allow you further edit the
message?
