From: Junio C Hamano <gitster@pobox.com>
Subject: Re: something fishy with Git commit and log from file
Date: Wed, 06 Aug 2008 08:38:04 -0700
Message-ID: <7v3alirw6b.fsf@gitster.siamese.dyndns.org>
References: <48997D2E.9030708@obry.net>
 <20080806104432.GG7121@bit.office.eurotux.com> <4899848C.6030800@obry.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Luciano Rocha <luciano@eurotux.com>, git list <git@vger.kernel.org>
To: pascal@obry.net
X-From: git-owner@vger.kernel.org Wed Aug 06 17:39:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQl76-0003CB-5q
	for gcvg-git-2@gmane.org; Wed, 06 Aug 2008 17:39:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759520AbYHFPiR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Aug 2008 11:38:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759517AbYHFPiQ
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Aug 2008 11:38:16 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:33799 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759475AbYHFPiM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Aug 2008 11:38:12 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id AF4C34D4B6;
	Wed,  6 Aug 2008 11:38:09 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 1F12C4D4B1; Wed,  6 Aug 2008 11:38:05 -0400 (EDT)
In-Reply-To: <4899848C.6030800@obry.net> (Pascal Obry's message of "Wed, 06
 Aug 2008 13:01:32 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: AC0E0922-63CD-11DD-BD3F-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91521>

Pascal Obry <pascal@obry.net> writes:

> So definitely a Git bug! Can be reproduced with:
>
>    $ mkdir repo && cd repo
>    $ git init
>    $ mkdir dir
>    $ cd dir
>    $ echo file > file
>    $ echo log > log
>    $ git add file
>    $ git commit --file=log
>    fatal: could not read log file 'log': No such file or directory

Try it without cding down to "dir".
