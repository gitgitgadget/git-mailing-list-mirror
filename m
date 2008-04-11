From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] When a remote is added but not fetched, tell the user.
Date: Fri, 11 Apr 2008 16:15:32 -0700
Message-ID: <7vbq4gouej.fsf@gitster.siamese.dyndns.org>
References: <20080409101428.GA2637@elte.hu>
 <1207869946-17013-1-git-send-email-g2p.code@gmail.com>
 <alpine.DEB.1.00.0804111621080.31025@eeepc-johanness>
 <20080411203501.7095b866@localhost> <20080411190816.GA17277@mithlond>
 <7v4pa8rs00.fsf@gitster.siamese.dyndns.org>
 <bd6139dc0804111535y8073d22w79845341394c2067@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Teemu Likonen" <tlikonen@iki.fi>, Gabriel <g2p.code@gmail.com>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: sverre@rabbelier.nl
X-From: git-owner@vger.kernel.org Sat Apr 12 01:16:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JkSUA-0000V5-6r
	for gcvg-git-2@gmane.org; Sat, 12 Apr 2008 01:16:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758295AbYDKXPv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Apr 2008 19:15:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758196AbYDKXPv
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Apr 2008 19:15:51 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:36927 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758253AbYDKXPu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Apr 2008 19:15:50 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 3F3CA1FD8;
	Fri, 11 Apr 2008 19:15:48 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 6E0E11FD7; Fri, 11 Apr 2008 19:15:42 -0400 (EDT)
In-Reply-To: <bd6139dc0804111535y8073d22w79845341394c2067@mail.gmail.com>
 (Sverre Rabbelier's message of "Sat, 12 Apr 2008 00:35:39 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79307>

"Sverre Rabbelier" <alturin@gmail.com> writes:

> On Fri, Apr 11, 2008 at 11:39 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>  If the user tells you not to fetch, the command should not bother the user
>>  with excess messages, unless the user explicitly asks to, either.
>
> I fully agree here, but is there a way for the user to do so?
> Especially the beginning user? Perhaps in the form of a -v(erbose)
> switch,...

Yeah, I am not sure if that should be called --verbose, but a "training
wheel" mode of operation somebody else mentioned the other day that echoes
back what the command thinks it was told to do by the user, together with
help text that explains what other things the user could have told to the
command to enrich its operation, might be an interesting addition.
