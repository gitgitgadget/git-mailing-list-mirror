From: Junio C Hamano <gitster@pobox.com>
Subject: Re: confused about preserved permissions
Date: Thu, 23 Aug 2007 00:57:32 -0700
Message-ID: <7vfy2avg2b.fsf@gitster.siamese.dyndns.org>
References: <20070820164411.GA15637@piper.oerlikon.madduck.net>
	<6031FB22-648E-47DE-92EE-2E7255322C27@lrde.epita.fr>
	<7v8x83i5ma.fsf@gitster.siamese.dyndns.org>
	<20070823060052.GA25153@piper.oerlikon.madduck.net>
	<85mywiixtp.fsf@lola.goethe.zz>
	<B38B8F2F-92B0-48F4-9093-54724FA862C2@lrde.epita.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Kastrup <dak@gnu.org>,
	git discussion list <git@vger.kernel.org>
To: Benoit SIGOURE <tsuna@lrde.epita.fr>
X-From: git-owner@vger.kernel.org Thu Aug 23 09:57:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IO7ZW-0008Gs-FX
	for gcvg-git@gmane.org; Thu, 23 Aug 2007 09:57:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752024AbXHWH5j (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Aug 2007 03:57:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751978AbXHWH5i
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Aug 2007 03:57:38 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:57865 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751090AbXHWH5i (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Aug 2007 03:57:38 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 779DA126A81;
	Thu, 23 Aug 2007 03:57:56 -0400 (EDT)
In-Reply-To: <B38B8F2F-92B0-48F4-9093-54724FA862C2@lrde.epita.fr> (Benoit
	SIGOURE's message of "Thu, 23 Aug 2007 09:48:23 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56469>

Benoit SIGOURE <tsuna@lrde.epita.fr> writes:

> Let's look at the problem from another point of view then: I want my
> *working tree* to be group readable even though my umask is 066.

I have to wonder if there is any sane development tool that
supports that kind of thing.  E.g. vi, emacs, gcc,...?  If you
allowed a tool to do that, what's the point of having a umask?
