From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-svn: Protect against "diff.color = true".
Date: Fri, 31 Aug 2007 14:46:55 -0700
Message-ID: <7vtzqfwf5c.fsf@gitster.siamese.dyndns.org>
References: <46aeb24f0708310558t2defc547v483586f116d8b8ac@mail.gmail.com>
	<7vveav21uv.fsf@gitster.siamese.dyndns.org>
	<20070831152153.GA30745@muzzle>
	<7v4pifzawc.fsf@gitster.siamese.dyndns.org>
	<7v4pifxuia.fsf_-_@gitster.siamese.dyndns.org>
	<Pine.LNX.4.64.0708312237340.28586@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Wong <normalperson@yhbt.net>,
	Robert Newson <robert.newson@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Aug 31 23:47:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IREKc-0000MF-0U
	for gcvg-git@gmane.org; Fri, 31 Aug 2007 23:47:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752844AbXHaVrG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 31 Aug 2007 17:47:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752680AbXHaVrF
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Aug 2007 17:47:05 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:44012 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752350AbXHaVrE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Aug 2007 17:47:04 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id DC6C712BFF7;
	Fri, 31 Aug 2007 17:47:21 -0400 (EDT)
In-Reply-To: <Pine.LNX.4.64.0708312237340.28586@racer.site> (Johannes
	Schindelin's message of "Fri, 31 Aug 2007 22:38:32 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57224>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Fri, 31 Aug 2007, Junio C Hamano wrote:
>
>>   I do not have an easy access to SVN repo
>>   to interoperate with, so a testing by real-world users and an
>>   Ack is appreciated.
>
> I just tested on a busybox clone: Works as expected.  Without your patch, 
> I get the uninitialised values, with your patch it is fine.
>
> ACK.

Thanks.

It's customary that the privilege to issue Ack is reserved to
the primary owner of the code.  We are a relatively small
friendly community and it is not a big deal, but if you ever
work on the kernel, be somewhat more careful.  People are picky
over there on such details.
