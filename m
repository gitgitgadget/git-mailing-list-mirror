From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] archive: specfile support (--pretty=format: in archive files)
Date: Mon, 03 Sep 2007 16:53:49 -0700
Message-ID: <7vtzqb8fw2.fsf@gitster.siamese.dyndns.org>
References: <46DC4D45.4030208@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Michael Gernoth <simigern@cip.informatik.uni-erlangen.de>,
	Thomas Glanzmann <thomas@glanzmann.de>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Tue Sep 04 01:54:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISLk3-00021G-21
	for gcvg-git@gmane.org; Tue, 04 Sep 2007 01:54:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750975AbXICXx5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 3 Sep 2007 19:53:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750855AbXICXx5
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Sep 2007 19:53:57 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:58746 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750852AbXICXx4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Sep 2007 19:53:56 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id C4B4112B9B0;
	Mon,  3 Sep 2007 19:54:12 -0400 (EDT)
In-Reply-To: <46DC4D45.4030208@lsrfire.ath.cx> (=?utf-8?Q?Ren=C3=A9?=
 Scharfe's message of
	"Mon, 03 Sep 2007 20:07:01 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57509>

Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> The attribute is useful for creating auto-updating specfiles.  It is
> limited by the underlying function format_commit_message(), though.
> E.g. currently there is no placeholder for git-describe like output,
> and expanded specfiles can't contain NUL bytes.  That can be fixed
> in format_commit_message() later and will then benefit users of
> git-log, too.

Interesting.  I however wonder if "specfile" is a good name for
this attribute, although I admit I do not think of anything
better offhand.

> Why did it take me that long to come up with such a simple patch?
> There was a vacation and a feature freeze in between, but above all
> I was only recently able to convince myself (using ugly code) that
> format_commit_message() can indeed be made to expand placeholders
> to git-describe strings..

Thanks.  Will take a look.
