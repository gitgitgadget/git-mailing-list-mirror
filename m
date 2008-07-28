From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [Fundamental problem with relative system paths] [PATCH 2/2]
 run-command (Windows): Run dashless "git <cmd>"
Date: Mon, 28 Jul 2008 00:38:50 -0700
Message-ID: <7vfxputq45.fsf@gitster.siamese.dyndns.org>
References: <1217224228-31303-1-git-send-email-prohaska@zib.de>
 <1217224228-31303-2-git-send-email-prohaska@zib.de>
 <7vvdyqv9bf.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <johannes.sixt@telecom.at>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Mon Jul 28 09:40:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNNKq-0002Fi-J2
	for gcvg-git-2@gmane.org; Mon, 28 Jul 2008 09:40:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752773AbYG1Hi7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2008 03:38:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752746AbYG1Hi7
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jul 2008 03:38:59 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:37149 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752742AbYG1Hi7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2008 03:38:59 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id C157846EF1;
	Mon, 28 Jul 2008 03:38:57 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 2E12C46EF0; Mon, 28 Jul 2008 03:38:52 -0400 (EDT)
In-Reply-To: <7vvdyqv9bf.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sun, 27 Jul 2008 22:58:44 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 3CDAEA5E-5C78-11DD-A36D-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90428>

Junio C Hamano <gitster@pobox.com> writes:

> Steffen Prohaska <prohaska@zib.de> writes:
>
>> ...  It is either used as
>> 'bin/git' (1 directory) or as 'libexec/git-core/git-*'
>> (2 directories).
>
> I thought Hannes already fixed that one; we shouldn't have the latter. 

Oops, I misread your message.  You are worried about the builtins.  Sorry.
