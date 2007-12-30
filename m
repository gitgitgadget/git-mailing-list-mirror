From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Force new line at end of commit message
Date: Sun, 30 Dec 2007 03:45:10 -0800
Message-ID: <7vprwo8kzd.fsf@gitster.siamese.dyndns.org>
References: <87ve6ub3u7.fsf@gollum.intra.norang.ca>
	<8763yof9lg.fsf@gollum.intra.norang.ca>
	<Pine.LNX.4.64.0712241835210.14355@wbgn129.biozentrum.uni-wuerzburg.de>
	<20071225044202.GO14735@spearce.org>
	<7v4pe5nt8m.fsf@gitster.siamese.dyndns.org>
	<Pine.LNX.4.64.0712291426500.14355@wbgn129.biozentrum.uni-wuerzburg.de>
	<7vodc99gpy.fsf@gitster.siamese.dyndns.org>
	<Pine.LNX.4.64.0712301124510.14355@wbgn129.biozentrum.uni-wuerzburg.de>
	<7v63yga20u.fsf@gitster.siamese.dyndns.org>
	<Pine.LNX.4.64.0712301201570.14355@wbgn129.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Bernt Hansen <bernt@alumni.uwaterloo.ca>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Dec 30 12:45:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J8wc0-0000eV-Ch
	for gcvg-git-2@gmane.org; Sun, 30 Dec 2007 12:45:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752024AbXL3LpV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Dec 2007 06:45:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752016AbXL3LpV
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Dec 2007 06:45:21 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:33409 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751891AbXL3LpU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Dec 2007 06:45:20 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 8037956A9;
	Sun, 30 Dec 2007 06:45:18 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id F3BE756A8;
	Sun, 30 Dec 2007 06:45:12 -0500 (EST)
In-Reply-To: <Pine.LNX.4.64.0712301201570.14355@wbgn129.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Sun, 30 Dec 2007 12:03:28 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69354>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Not that I care too deeply, but does that not add a newline regardless 
> whether it is needed or not?

Heh, I can see that you do not care---the original did not even
add a newline when necessary (and that is why we have this
thread).  Instead you were adding a newline regardless to the
end of the first commit, but not doing so for the other ones.

The patch just moves that unconditional "echo"; instead of
adding one to the end of the first commit (and only the first
one), it adds before the new commit's title message.
