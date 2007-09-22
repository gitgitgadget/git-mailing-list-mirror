From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Allow shell scripts to run with non-Bash /bin/sh
Date: Fri, 21 Sep 2007 17:21:05 -0700
Message-ID: <7vr6krh7ny.fsf@gitster.siamese.dyndns.org>
References: <20070921214346.GF97288@void.codelabs.ru>
	<7v8x6zinjf.fsf@gitster.siamese.dyndns.org>
	<86abrfy377.fsf@lola.quinscape.zz>
	<7vvea3h7sn.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Sat Sep 22 02:21:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IYskH-0006sT-Sb
	for gcvg-git-2@gmane.org; Sat, 22 Sep 2007 02:21:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753379AbXIVAVM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Sep 2007 20:21:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753269AbXIVAVL
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Sep 2007 20:21:11 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:44340 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753192AbXIVAVK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Sep 2007 20:21:10 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id DFB23139986;
	Fri, 21 Sep 2007 20:21:28 -0400 (EDT)
In-Reply-To: <7vvea3h7sn.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Fri, 21 Sep 2007 17:18:16 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58901>

Junio C Hamano <gitster@pobox.com> writes:

> David Kastrup <dak@gnu.org> writes:
>
>> But doing a break inside of the while _condition_ rather than the body
>> just feels wrong to me.
>
> Sorry, but that is not the issue on the thread is about.
> BSD shell is failing the whole case statement when there is no
> matching case arm.

I did not mean "BSD shell" in general here.  The shell Eygene
uses on his (unspecified version of) FreeBSD box is failing.
