From: Junio C Hamano <gitster@pobox.com>
Subject: Re: msgmft segfaulting on tiger
Date: Wed, 27 Feb 2008 14:14:01 -0800
Message-ID: <7vablmqc7q.fsf@gitster.siamese.dyndns.org>
References: <46a038f90802211553g735215c6q260ddc49ac149bb5@mail.gmail.com>
 <46a038f90802211559w457c5460k7447ba8b38352713@mail.gmail.com>
 <20080222065836.GE8410@spearce.org>
 <46a038f90802220957y7db67d8nb6b7ad784124546a@mail.gmail.com>
 <47C5A974.7080207@gmail.com> <alpine.LSU.1.00.0802271825330.22527@racer.site>
 <47C5AEFA.5020004@gmail.com> <alpine.LSU.1.00.0802272203270.22527@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Gabriel =?utf-8?Q?Salda=C3=B1a?= <gsaldana@gmail.com>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Feb 27 23:15:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUUYV-0005T1-EC
	for gcvg-git-2@gmane.org; Wed, 27 Feb 2008 23:15:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761962AbYB0WOX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Feb 2008 17:14:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759873AbYB0WOX
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Feb 2008 17:14:23 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:34245 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761913AbYB0WOW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Feb 2008 17:14:22 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 701C72148;
	Wed, 27 Feb 2008 17:14:19 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 6A6D62132; Wed, 27 Feb 2008 17:14:06 -0500 (EST)
In-Reply-To: <alpine.LSU.1.00.0802272203270.22527@racer.site> (Johannes
 Schindelin's message of "Wed, 27 Feb 2008 22:04:34 +0000 (GMT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75309>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> $ msgfmt --tcl; echo $?
>> msgfmt: unrecognized option `--tcl'
>> Try `msgfmt --help' for more information.
>> 1
>
> Darn.  I think that's the same exit code as for any other invocation 
> without filename.
>
> So it seems that there is no easy way to tell a --tcl aware msgfmt from 
> the other.

How about...

    $ msgfmt --tcl -l C -d . /dev/null; echo $?
