From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Perl warning in git-svn (git v1.5.3-rc7-16-ge340d7d)
Date: Fri, 31 Aug 2007 14:22:44 -0700
Message-ID: <7vd4x3xuu3.fsf@gitster.siamese.dyndns.org>
References: <46aeb24f0708310558t2defc547v483586f116d8b8ac@mail.gmail.com>
	<7vveav21uv.fsf@gitster.siamese.dyndns.org>
	<20070831152153.GA30745@muzzle>
	<7v4pifzawc.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Robert Newson <robert.newson@gmail.com>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Fri Aug 31 23:23:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRDxr-0002oL-LI
	for gcvg-git@gmane.org; Fri, 31 Aug 2007 23:23:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965550AbXHaVWy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 31 Aug 2007 17:22:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965440AbXHaVWx
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Aug 2007 17:22:53 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:43639 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965786AbXHaVWw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Aug 2007 17:22:52 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id BBFD512BF02;
	Fri, 31 Aug 2007 17:23:07 -0400 (EDT)
In-Reply-To: <7v4pifzawc.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Fri, 31 Aug 2007 13:50:27 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57215>

Junio C Hamano <gitster@pobox.com> writes:

> I was almost going to suggest us to change "*.color = true" to
> mean 'auto'.  Because git can internally use pager and has a way
> for the user to control enabling/disabling colors when the pager
> is used, there is no _logical_ reason to enable pager when the
> output is not going to a tty.

Gaah, sorry; I meant "no logical reason to enable _color_ when
the output is not going to a tty".
