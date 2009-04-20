From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH RFC3.5 06/12] send-email: Cleanup and streamline the SMTP
  code in send_message
Date: Sun, 19 Apr 2009 23:43:34 -0700
Message-ID: <7veivnlt9l.fsf@gitster.siamese.dyndns.org>
References: <1240074128-16132-1-git-send-email-mfwitten@gmail.com>
 <1240074128-16132-2-git-send-email-mfwitten@gmail.com>
 <1240074128-16132-3-git-send-email-mfwitten@gmail.com>
 <1240074128-16132-4-git-send-email-mfwitten@gmail.com>
 <1240074128-16132-5-git-send-email-mfwitten@gmail.com>
 <1240074128-16132-6-git-send-email-mfwitten@gmail.com>
 <1240074128-16132-7-git-send-email-mfwitten@gmail.com>
 <7vskk4nlrg.fsf@gitster.siamese.dyndns.org>
 <b4087cc50904192238j744f353dtf5f6a616cada8cd8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 20 08:45:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LvnFs-0003uQ-VI
	for gcvg-git-2@gmane.org; Mon, 20 Apr 2009 08:45:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753430AbZDTGnm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Apr 2009 02:43:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753125AbZDTGnm
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Apr 2009 02:43:42 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:64557 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753161AbZDTGnl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Apr 2009 02:43:41 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 39213AC336;
	Mon, 20 Apr 2009 02:43:40 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 0D3A4AC335; Mon,
 20 Apr 2009 02:43:36 -0400 (EDT)
In-Reply-To: <b4087cc50904192238j744f353dtf5f6a616cada8cd8@mail.gmail.com>
 (Michael Witten's message of "Mon, 20 Apr 2009 00:38:50 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 954F761C-2D76-11DE-A6DA-C121C5FC92D5-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116938>

Michael Witten <mfwitten@gmail.com> writes:

> In any case, I also like:
>
>     condition and/or (do something);
>
> or:
>
>     condition and/or do something;

I do not have problem with (condition and/or do this).

What I complained about was statement modifier that interrupts your
thought process and forces you to read things twice.  You see "DIE", and
you have to stop "Huh?".  You only realize that the author did not mean to
say "always die here" after seeing the modifier that changes the meaning
of "die" to "only under this rare condition--sorry, I did not say this
upfront, but I am checking for errors."

I just do not want to hear "sorry, I did not say this upfront" part.  IOW,
I have much less problem with this:

	do this;
	do that;
	condition that usually holds true
        	or die ...
	do some other thing;
