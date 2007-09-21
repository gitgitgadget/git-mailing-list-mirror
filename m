From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Move option parsing code to parse-options.[ch].
Date: Fri, 21 Sep 2007 12:44:14 -0700
Message-ID: <7vsl57iz1t.fsf@gitster.siamese.dyndns.org>
References: <1190401278-2869-1-git-send-email-krh@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Kristian =?utf-8?Q?H=C3=B8gsberg?= <krh@redhat.com>
X-From: git-owner@vger.kernel.org Fri Sep 21 21:44:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IYoQP-0006a8-1P
	for gcvg-git-2@gmane.org; Fri, 21 Sep 2007 21:44:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761890AbXIUToU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 21 Sep 2007 15:44:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761774AbXIUToU
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Sep 2007 15:44:20 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:40177 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761447AbXIUToT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Sep 2007 15:44:19 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 830CB139794;
	Fri, 21 Sep 2007 15:44:38 -0400 (EDT)
In-Reply-To: <1190401278-2869-1-git-send-email-krh@redhat.com> (Kristian
	=?utf-8?Q?H=C3=B8gsberg's?= message of "Fri, 21 Sep 2007 15:01:17 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58871>

Kristian H=C3=B8gsberg <krh@redhat.com> writes:

> Signed-off-by: Kristian H=C3=B8gsberg <krh@redhat.com>
> ---
>  Makefile         |    2 +-
>  builtin-commit.c |  117 ++++++++------------------------------------=
----------
>  parse-options.c  |   74 ++++++++++++++++++++++++++++++++++
>  parse-options.h  |   29 +++++++++++++
>  4 files changed, 121 insertions(+), 101 deletions(-)
>  create mode 100644 parse-options.c
>  create mode 100644 parse-options.h

Hmmmmmmm. Is it too much to ask to pretend as if the previous
"builtin-commit.c" that had these parts that did not belong to
it in the first place never happened?
