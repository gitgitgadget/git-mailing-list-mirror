From: Junio C Hamano <gitster@pobox.com>
Subject: Re: a475e8095aeb898c1ca60673b82df97d2300cc95 broken for docs
Date: Wed, 22 Aug 2007 01:13:55 -0700
Message-ID: <7vir78j8ak.fsf@gitster.siamese.dyndns.org>
References: <86odh0ojx4.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: merlyn@stonehenge.com (Randal L. Schwartz)
X-From: git-owner@vger.kernel.org Wed Aug 22 10:14:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INlMH-0006ex-8H
	for gcvg-git@gmane.org; Wed, 22 Aug 2007 10:14:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758722AbXHVIOG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Aug 2007 04:14:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758764AbXHVIOF
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Aug 2007 04:14:05 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:38790 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758732AbXHVIOB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Aug 2007 04:14:01 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 241FA125FDC;
	Wed, 22 Aug 2007 04:14:18 -0400 (EDT)
In-Reply-To: <86odh0ojx4.fsf@blue.stonehenge.com> (Randal L. Schwartz's
	message of "Tue, 21 Aug 2007 10:51:35 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56355>

Is this only with "make git-rev-list.1"?

Can your setup format d56651c0^ aka 14cd5607 correctly?  IOW, does

	$ git checkout 14cd5607 && cd Documentation && make git-rev-list.1

work well while

	$ git checkout a475e809 && cd Documentation && make git-rev-list.1

doesn't?
