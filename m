From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2 v2] git-gui: "Stage Line": Treat independent changes
 in adjacent lines better
Date: Thu, 17 Jul 2008 23:21:25 -0700
Message-ID: <7vod4vd862.fsf@gitster.siamese.dyndns.org>
References: <20080716003503.GA24339@spearce.org>
 <1216300911-5170-1-git-send-email-johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Fri Jul 18 08:22:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJjMO-0001LN-H4
	for gcvg-git-2@gmane.org; Fri, 18 Jul 2008 08:22:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752408AbYGRGVd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jul 2008 02:21:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752492AbYGRGVd
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jul 2008 02:21:33 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:39162 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752307AbYGRGVd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jul 2008 02:21:33 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id D43152CD7F;
	Fri, 18 Jul 2008 02:21:31 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 4ABAF2CD7E; Fri, 18 Jul 2008 02:21:28 -0400 (EDT)
In-Reply-To: <1216300911-5170-1-git-send-email-johannes.sixt@telecom.at>
 (Johannes Sixt's message of "Thu, 17 Jul 2008 15:21:51 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: C389E684-5491-11DD-A46F-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88996>

Johannes Sixt <johannes.sixt@telecom.at> writes:

> Assume that we want to commit these states:
>
>   Old state == HEAD    Intermediate state   New state
>   --------------------------------------------------------
>   context before       context before       context before
>   old 1                new 1                new 1
>   old 2                old 2                new 2
>   context after        context after        context after

Much easier to understand.  Thanks.
