From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Rename ".dotest/" to ".git/rebase" and ".dotest-merge"
 to "rebase-merge"
Date: Wed, 23 Jul 2008 13:40:14 -0700
Message-ID: <7vod4obahd.fsf@gitster.siamese.dyndns.org>
References: <73fd69b50807151408i6a916da6p7b89fe81e65fc717@mail.gmail.com>
 <20080715212211.GL6244@leksak.fem-net> <487D1B3D.70500@lsrfire.ath.cx>
 <alpine.DEB.1.00.0807160245440.2841@eeepc-johanness>
 <20080716012619.GM8185@mit.edu> <7viqv5r637.fsf@gitster.siamese.dyndns.org>
 <4882350B.6020003@free.fr> <7v3am5zfea.fsf@gitster.siamese.dyndns.org>
 <20080722234703.GD5904@leksak.fem-net>
 <7vbq0pifwq.fsf@gitster.siamese.dyndns.org>
 <20080723011341.GE5904@leksak.fem-net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Olivier Marin <dkr+ml.git@free.fr>, Theodore Tso <tytso@mit.edu>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	Joe Fiorini <joe@faithfulgeek.org>, git@vger.kernel.org,
	Jari Aalto <jari.aalto@cante.net>
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Wed Jul 23 22:41:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLl9N-0006sW-Pp
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 22:41:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755015AbYGWUk2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2008 16:40:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755002AbYGWUk2
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 16:40:28 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:40621 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754402AbYGWUk1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 16:40:27 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 207C139B5B;
	Wed, 23 Jul 2008 16:40:26 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 38BDC39B55; Wed, 23 Jul 2008 16:40:16 -0400 (EDT)
In-Reply-To: <20080723011341.GE5904@leksak.fem-net> (Stephan Beyer's message
 of "Wed, 23 Jul 2008 03:13:41 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 946B38C0-58F7-11DD-8E5A-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89768>

Stephan Beyer <s-beyer@gmx.net> writes:

>> Just being a bit defensive -- in this case I think it might be Ok to say
>> "read-tree --reset -u ORIG_HEAD", but I haven't checked in a conflicted
>> case.
>
> Well, the test suite fails:
> ...
> So no reason to be defensive ;)

Ok, so it is not just being defensive but actually is necessary.
