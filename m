From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] Introduce .git/BRANCH to point to the current branch
Date: Tue, 04 Dec 2007 14:06:53 -0800
Message-ID: <7v63ze3yiq.fsf@gitster.siamese.dyndns.org>
References: <4755B3B3.80704@gmail.com> <vpqbq96jjrf.fsf@bauges.imag.fr>
	<m34peyur8r.fsf@roke.D-201> <4755CD32.7040204@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Git Mailing List <git@vger.kernel.org>
To: Salikh Zakirov <salikh@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 04 23:07:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzfvF-0003Zm-L0
	for gcvg-git-2@gmane.org; Tue, 04 Dec 2007 23:07:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751684AbXLDWHA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Dec 2007 17:07:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751717AbXLDWHA
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Dec 2007 17:07:00 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:35360 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751613AbXLDWG7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Dec 2007 17:06:59 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 47DF8325;
	Tue,  4 Dec 2007 17:07:21 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id B78EF9C008;
	Tue,  4 Dec 2007 17:07:16 -0500 (EST)
In-Reply-To: <4755CD32.7040204@gmail.com> (Salikh Zakirov's message of "Wed,
	05 Dec 2007 06:57:06 +0900")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67089>

Salikh Zakirov <salikh@gmail.com> writes:

> Jakub Narebski wrote:
> ...
>> Please search the archives for idea of BASE extension to index
>> (instead of your separate file under .git/refs), and why it is
>> not in current git.
>
> I never realized this idea has been already tried. Thanks for the pointer!
> I would try to use BASE extension.

Start reading from here.

http://thread.gmane.org/gmane.comp.version-control.git/44360/focus=44508

All of the articles in that thread is worth a read to understand why the
idea did not quite pan out and the whole series was reverted.

052737e33a898af8eb4f1bd97be046e05ecb9bea reverts the series from 'next'.
309202782399878a2d7973e21e6e62ba3b9fde50 was the last of the index-base
series.
