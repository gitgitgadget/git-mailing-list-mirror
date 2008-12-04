From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 0/3] gitweb: Optional grouping of projects by category
Date: Wed, 03 Dec 2008 16:43:32 -0800
Message-ID: <7vy6yw7osr.fsf@gitster.siamese.dyndns.org>
References: <87wsei1uvp.wl%seb@cine7.net>
 <200812030036.13562.jnareb@gmail.com> <87prk91got.wl%seb@cine7.net>
 <7viqq0c1pg.fsf@gitster.siamese.dyndns.org> <87ljuw22q1.wl%seb@cine7.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	Petr Baudis <pasky@suse.cz>,
	Gustavo Sverzut Barbieri <barbieri@profusion.mobi>
To: =?utf-8?Q?S=C3=A9bastien?= Cevey <seb@cine7.net>
X-From: git-owner@vger.kernel.org Thu Dec 04 01:45:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L82L5-0006Fo-PM
	for gcvg-git-2@gmane.org; Thu, 04 Dec 2008 01:45:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753240AbYLDAnn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Dec 2008 19:43:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752984AbYLDAnn
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Dec 2008 19:43:43 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:61951 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752812AbYLDAnm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Dec 2008 19:43:42 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 22B388421B;
	Wed,  3 Dec 2008 19:43:41 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id CB53B84218; Wed,
  3 Dec 2008 19:43:34 -0500 (EST)
In-Reply-To: <87ljuw22q1.wl%seb@cine7.net> (=?utf-8?Q?S=C3=A9bastien?=
 Cevey's message of "Thu, 04 Dec 2008 01:39:18 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 98A99982-C19C-11DD-B420-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102315>

S=C3=A9bastien Cevey <seb@cine7.net> writes:

> [1] OT: I didn't find a simple command to do this:
>
>     $ git diff ..the-end-state > finish.patch
>     $ patch -p1 < finish.patch
>     $ git commit -a -s
>
>     (where the original HEAD and the-end-state have an older MRCA wit=
h
>      rewritten history inbetween, and I don't want to apply that
>      history and solve conflicts, just "get my tree to the end state"=
=2E)
>
>     Any tip?

$ git read-tree -m -u the-end-state
$ git commit -a -s
