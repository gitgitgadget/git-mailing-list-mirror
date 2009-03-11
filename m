From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Removed unnecessary use of global variables.
Date: Wed, 11 Mar 2009 15:00:48 -0700
Message-ID: <7vab7r3ejz.fsf@gitster.siamese.dyndns.org>
References: <1236730168-7164-1-git-send-email-kusmabite@gmail.com>
 <alpine.DEB.1.00.0903111126280.10279@pacific.mpi-cbg.de>
 <20090312064237.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Erik Faye-Lund <kusmabite@gmail.com>, git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Wed Mar 11 23:05:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhWW3-0005U7-7Q
	for gcvg-git-2@gmane.org; Wed, 11 Mar 2009 23:03:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755468AbZCKWA7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Mar 2009 18:00:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755395AbZCKWA6
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Mar 2009 18:00:58 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:43092 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755444AbZCKWA5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Mar 2009 18:00:57 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 76587A14B2;
	Wed, 11 Mar 2009 18:00:55 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id DB35AA14B1; Wed,
 11 Mar 2009 18:00:49 -0400 (EDT)
In-Reply-To: <20090312064237.6117@nanako3.lavabit.com> (Nanako Shiraishi's
 message of "Thu, 12 Mar 2009 06:42:37 +0900")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 185A7286-0E88-11DE-9961-CFA5EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112981>

Nanako Shiraishi <nanako3@lavabit.com> writes:

> 1. Are you and Junio one same person, and if so what made you change your mind during these 8 hours ;-)?

Last year during Gittogether, Dscho and I were seen in a room sitting
parhaps 4 meters apart; I suspect we are different people.

http://picasaweb.google.com/dsymonds/GitTogether08#5263025230667494002

> 2. Junio said "ef90d6d (Provide git_config with a callback-data parameter, 2008-05-14)" and yours is slightly different. Both are equally readable but I think it would help to make sure everybody uses the same format within one project. Do we need a helper command that everybody can use?

I use these two aliases while I am writing e-mails quite often:

[alias]
	one = "!sh -c 'git show -s --pretty=\"format:%h (%s, %ai\" \"$@\" | sed -e \"s/ [012][0-9]:[0-5][0-9]:[0-5][0-9] [-+][0-9][0-9][0-9][0-9]$/)/\"' -"
	who = "!sh -c 'git log -1 --pretty=\"format:%an <%ae>\" --author=\"$1\"' -"
