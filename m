From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Make guilt work even after git-sh-setup is moved out
 of the user's path
Date: Mon, 07 Jul 2008 18:17:19 -0700
Message-ID: <7viqvhxjhc.fsf@gitster.siamese.dyndns.org>
References: <1215475392-26221-1-git-send-email-tytso@mit.edu>
 <1215475392-26221-2-git-send-email-tytso@mit.edu>
 <1215475392-26221-3-git-send-email-tytso@mit.edu>
 <20080708003256.GB1880@josefsipek.net>
 <7vwsjxxkfd.fsf@gitster.siamese.dyndns.org>
 <20080708011413.GC1880@josefsipek.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Theodore Ts'o" <tytso@MIT.EDU>, git@vger.kernel.org
To: "Josef 'Jeff' Sipek" <jeffpc@josefsipek.net>
X-From: git-owner@vger.kernel.org Tue Jul 08 03:18:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KG1ql-0005Hl-5e
	for gcvg-git-2@gmane.org; Tue, 08 Jul 2008 03:18:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755348AbYGHBRh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jul 2008 21:17:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755344AbYGHBRh
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Jul 2008 21:17:37 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:51579 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755332AbYGHBRg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jul 2008 21:17:36 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 1B55827006;
	Mon,  7 Jul 2008 21:17:34 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 6BD7E27005; Mon,  7 Jul 2008 21:17:30 -0400 (EDT)
In-Reply-To: <20080708011413.GC1880@josefsipek.net> (Josef Sipek's message of
 "Mon, 7 Jul 2008 21:14:13 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: A4DB85D4-4C8B-11DD-9930-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87681>

"Josef 'Jeff' Sipek" <jeffpc@josefsipek.net> writes:

> A fresh clone (from master.kernel.org over ssh) gets me:
>
> $ git describe
> v1.5.6.2-247-g9237122
> $ git --version
> git version 1.5.6.GIT
> $ git --exec-path
> /home/jeffpc/git-bin/bin
>
> You seem to have a different HEAD for the master branch than I do.

Oh, my private 'master' almost always is ahead of the public one after
work.

But I do not have any new changes around this area lately.  Promise ;-).
