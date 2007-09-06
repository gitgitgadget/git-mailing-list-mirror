From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] Convert builin-mailinfo.c to use The Better String Library.
Date: Thu, 06 Sep 2007 02:35:15 -0700
Message-ID: <7vhcm8b0h8.fsf@gitster.siamese.dyndns.org>
References: <vpq642pkoln.fsf@bauges.imag.fr>
	<4AFD7EAD1AAC4E54A416BA3F6E6A9E52@ntdev.corp.microsoft.com>
	<20070906045942.GR18160@spearce.org> <46DFC490.3060200@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Dmitry Kakurin <dmitry.kakurin@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, Git <git@vger.kernel.org>
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Thu Sep 06 11:35:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITDlq-0005ri-4e
	for gcvg-git@gmane.org; Thu, 06 Sep 2007 11:35:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754163AbXIFJfZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Sep 2007 05:35:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754155AbXIFJfZ
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Sep 2007 05:35:25 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:48797 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753206AbXIFJfY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Sep 2007 05:35:24 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id BAB4C12F56F;
	Thu,  6 Sep 2007 05:35:38 -0400 (EDT)
In-Reply-To: <46DFC490.3060200@op5.se> (Andreas Ericsson's message of "Thu, 06
	Sep 2007 11:12:48 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57849>

Andreas Ericsson <ae@op5.se> writes:

> Git is cheating a bit though. Its primary audience was (and is) the
> various integrators working on the Linux kernel, all of whom are fairly
> competent C programmers.

Do we still have a huge overlap with the kernel people?  I had
an impression that patches from the kernel folks, with notable
exception from a handful (you know who you are), have petered
out rapidly after the first several weeks.
