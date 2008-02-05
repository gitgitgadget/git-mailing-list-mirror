From: Junio C Hamano <gitster@pobox.com>
Subject: Re: man pages are littered with .ft C and others
Date: Mon, 04 Feb 2008 16:28:28 -0800
Message-ID: <7vd4rci6vn.fsf@gitster.siamese.dyndns.org>
References: <alpine.DEB.1.00.0802021055180.21831@an.sumeria>
	<200802031139.48752.jnareb@gmail.com> <20080204220120.GA23798@diku.dk>
	<200802050026.22262.jnareb@gmail.com> <20080205000048.GA28020@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, Adam Flott <adam@npjh.com>,
	git@vger.kernel.org
To: Jonas Fonseca <fonseca@diku.dk>
X-From: git-owner@vger.kernel.org Tue Feb 05 01:29:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMBgb-0006GL-R2
	for gcvg-git-2@gmane.org; Tue, 05 Feb 2008 01:29:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757521AbYBEA2p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2008 19:28:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757503AbYBEA2p
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Feb 2008 19:28:45 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:51616 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757479AbYBEA2o (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2008 19:28:44 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 057C22455;
	Mon,  4 Feb 2008 19:28:43 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 4C03C2454;
	Mon,  4 Feb 2008 19:28:36 -0500 (EST)
In-Reply-To: <20080205000048.GA28020@diku.dk> (Jonas Fonseca's message of
	"Tue, 5 Feb 2008 01:00:48 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72594>

Jonas Fonseca <fonseca@diku.dk> writes:

> Jakub Narebski <jnareb@gmail.com> wrote Tue, Feb 05, 2008:
>
>> P.S. writing subset of AsciiDoc in Perl, which would write manpages, HTML
>> and perhaps info/texinfo files directly, without fragile xmlto toolchain,
>> looks better and better...
>
> But not as easy as just pulling the documentation branches.

But your approach has a small flaw of chicken-and-egg problem
;-).
