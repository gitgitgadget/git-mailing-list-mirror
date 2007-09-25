From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Supplant the "while case ... break ;; esac" idiom
Date: Mon, 24 Sep 2007 23:29:04 -0700
Message-ID: <7v4phj6yxb.fsf@gitster.siamese.dyndns.org>
References: <853ax5mb1j.fsf@lola.goethe.zz> <85myvdktb3.fsf@lola.goethe.zz>
	<7vhcllc9bz.fsf@gitster.siamese.dyndns.org>
	<85ps08k2fj.fsf@lola.goethe.zz> <86bqbsta3g.fsf@lola.quinscape.zz>
	<7vodfr8wts.fsf@gitster.siamese.dyndns.org>
	<85hcljgtlr.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Tue Sep 25 08:29:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ia3v3-0006w4-J3
	for gcvg-git-2@gmane.org; Tue, 25 Sep 2007 08:29:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751648AbXIYG3L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Sep 2007 02:29:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751400AbXIYG3K
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Sep 2007 02:29:10 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:58238 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750917AbXIYG3J (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Sep 2007 02:29:09 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id E5926139EAF;
	Tue, 25 Sep 2007 02:29:27 -0400 (EDT)
In-Reply-To: <85hcljgtlr.fsf@lola.goethe.zz> (David Kastrup's message of "Tue,
	25 Sep 2007 08:13:52 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59095>

David Kastrup <dak@gnu.org> writes:

> As a completely irrelevant side note: the autoconf documentation
> mentions that "false" is more portable than "true" since calling it
> returns a non-zero exit status even when it is not installed or
> built-in.

Ah, I like that ;-)  It is obvious when you think about it, and
it is so true but in a very twisted way...
