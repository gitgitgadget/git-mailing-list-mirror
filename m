From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git help -t <topic>: list the help of the commands in a given topic
Date: Mon, 10 Dec 2007 17:07:14 -0800
Message-ID: <7v7ijmjayl.fsf@gitster.siamese.dyndns.org>
References: <1197299021-28463-1-git-send-email-sbejar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Santi =?utf-8?Q?B=C3=A9jar?= <sbejar@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 11 02:07:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1tbH-0000VA-7N
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 02:07:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751818AbXLKBHd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 10 Dec 2007 20:07:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751713AbXLKBHd
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Dec 2007 20:07:33 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:40260 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751425AbXLKBHd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Dec 2007 20:07:33 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id BB4DE219C;
	Mon, 10 Dec 2007 20:07:27 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 65DCF2192;
	Mon, 10 Dec 2007 20:07:22 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67773>

Santi B=C3=A9jar <sbejar@gmail.com> writes:

> With 'git help -t' lists the available topics.
>
> Show a hint to get a longer list when listing the common commands.

I like the idea of making the categorized command list in git(7)
available, and agree with you that renaming common_cmds[] to cmd_list[]
and place everything in there would be the way to go.

However, I doubt about your presentation.  Who are the intended
audience and what is the expected way this is used?

I highly suspect that it would be much easier to use if you add a mode
to "git help" that runs the pager over the categoized command list part
of git(7) manual page, without taking "show me list of topics" nor "sho=
w
commands only in this topic" parameters.  It is highly unlikely that a
user knows which category an obscure command whose name he wants to
recall is in, or can guess which category it would be classified in
after seeing the "category list".  It would be much more likely that he
finds it easier to scan (perhaps with "/<string>") the command list wit=
h
one line description in the pager.
