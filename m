From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [StGit PATCH 1/6] Split git.merge into two functions
Date: Mon, 20 Aug 2007 16:52:10 -0700
Message-ID: <7vejhxrcgl.fsf@gitster.siamese.dyndns.org>
References: <11875975232619-git-send-email-davidk@lysator.liu.se>
	<1187597523433-git-send-email-davidk@lysator.liu.se>
	<87odh2d1q7.fsf@morpheus.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>, <ukleinek@informatik.uni-freiburg.de>
To: David =?utf-8?Q?K=C3=A5gedal?= <davidk@lysator.liu.se>
X-From: git-owner@vger.kernel.org Tue Aug 21 01:52:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INH2s-0000mA-Pb
	for gcvg-git@gmane.org; Tue, 21 Aug 2007 01:52:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751528AbXHTXw1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 20 Aug 2007 19:52:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751555AbXHTXw1
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Aug 2007 19:52:27 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:40961 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751048AbXHTXw1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Aug 2007 19:52:27 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 420EA122753;
	Mon, 20 Aug 2007 19:52:45 -0400 (EDT)
In-Reply-To: <87odh2d1q7.fsf@morpheus.local> (David =?utf-8?Q?K=C3=A5gedal?=
 =?utf-8?Q?'s?= message of "Mon,
	20 Aug 2007 10:55:28 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56268>

David K=C3=A5gedal <davidk@lysator.liu.se> writes:

> David K=C3=A5gedal <davidk@lysator.liu.se> writes:
>
> It seems that git-send-email didn't like me for some reason.  Double
> UTF-8 encoding is not very pretty.

I believe Uwe (CC'ed) had a few patches to deal with this area.
Do they help?
