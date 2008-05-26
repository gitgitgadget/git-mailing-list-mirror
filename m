From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] hg-to-git: add --verbose option
Date: Mon, 26 May 2008 10:19:25 -0700
Message-ID: <7vlk1xc7aa.fsf@gitster.siamese.dyndns.org>
References: <alpine.DEB.1.00.0805261344420.30431@racer>
 <200805261509.49841.johan@herland.net>
 <alpine.DEB.1.00.0805261414140.30431@racer>
 <bd6139dc0805260628l1b073f52i1f33bd0c707a4329@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Johan Herland" <johan@herland.net>, git@vger.kernel.org,
	"Stelian Pop" <stelian@popies.net>, gitster@pobox.com
To: sverre@rabbelier.nl
X-From: git-owner@vger.kernel.org Mon May 26 19:20:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K0gNK-0005uX-EH
	for gcvg-git-2@gmane.org; Mon, 26 May 2008 19:20:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754238AbYEZRTm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 May 2008 13:19:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754041AbYEZRTm
	(ORCPT <rfc822;git-outgoing>); Mon, 26 May 2008 13:19:42 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:33860 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753876AbYEZRTl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 May 2008 13:19:41 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 85A025440;
	Mon, 26 May 2008 13:19:39 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id CE0F3543F; Mon, 26 May 2008 13:19:32 -0400 (EDT)
In-Reply-To: <bd6139dc0805260628l1b073f52i1f33bd0c707a4329@mail.gmail.com>
 (Sverre Rabbelier's message of "Mon, 26 May 2008 15:28:54 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: EC22A73E-2B47-11DD-B156-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82942>

"Sverre Rabbelier" <alturin@gmail.com> writes:

> On Mon, May 26, 2008 at 3:14 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
>> Now, that is not even funny, as that was my initial version, and Python
>> complained about not knowing "false".
>
> That is because in python the keyword is "False" (note the capital 'F').

I too write True/False in my recent Python code, but I vaguely recall they
were relatively new to the language.  I think it was 2.3 which is probably
5 years old by now, so if that is the case we probably are safe (and they
are used in p4import anyway).

I think I spotted a bug in Python documentation, by the way ;-)

http://docs.python.org/ref/ref.html does not even list "True" and "False"
in its section 2.4 (Literals) yet, and that document is for version 2.5.2.
