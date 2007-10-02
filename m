From: Junio C Hamano <gitster@pobox.com>
Subject: Re: merging .gitignore
Date: Tue, 02 Oct 2007 12:55:41 -0700
Message-ID: <7vodfhjnpe.fsf@gitster.siamese.dyndns.org>
References: <20071001130314.GA5932@lapse.madduck.net>
	<Pine.LNX.4.64.0710011457120.28395@racer.site>
	<20071001130314.GA5932@lapse.madduck.net>
	<200710011448.17701.andyparkins@gmail.com>
	<20071002195148.GA14171@lapse.madduck.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Andy Parkins <andyparkins@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: martin f krafft <madduck@madduck.net>
X-From: git-owner@vger.kernel.org Tue Oct 02 21:55:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IcnqX-0003kO-OR
	for gcvg-git-2@gmane.org; Tue, 02 Oct 2007 21:55:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753271AbXJBTzt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Oct 2007 15:55:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752877AbXJBTzt
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Oct 2007 15:55:49 -0400
Received: from rune.pobox.com ([208.210.124.79]:54785 "EHLO rune.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752588AbXJBTzs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Oct 2007 15:55:48 -0400
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id 64CBF140639;
	Tue,  2 Oct 2007 15:56:10 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id A4CCE14044E;
	Tue,  2 Oct 2007 15:56:05 -0400 (EDT)
In-Reply-To: <20071002195148.GA14171@lapse.madduck.net> (martin f. krafft's
	message of "Tue, 2 Oct 2007 20:51:48 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59719>

martin f krafft <madduck@madduck.net> writes:

> Basically I am saying that it should be
>
>   cat $gitignore_files | sort -u
>
> and obviously, this is something for a specific merge driver, as
> Johannes suggested.

Perhaps you can use the existing union merge there.
