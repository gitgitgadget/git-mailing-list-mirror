From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git init: optionally allow a directory argument
Date: Sat, 25 Jul 2009 02:26:10 -0700
Message-ID: <7vd47pun9p.fsf@alter.siamese.dyndns.org>
References: <20090725065928.6117@nanako3.lavabit.com>
 <7v7hxxz2lt.fsf@alter.siamese.dyndns.org> <200907250945.18398.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sat Jul 25 11:26:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUdWK-0004wK-Uh
	for gcvg-git-2@gmane.org; Sat, 25 Jul 2009 11:26:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751760AbZGYJ0R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Jul 2009 05:26:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751652AbZGYJ0R
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Jul 2009 05:26:17 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:38048 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751589AbZGYJ0Q (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Jul 2009 05:26:16 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 74B891104D;
	Sat, 25 Jul 2009 05:26:16 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 259951104C; Sat, 25 Jul 2009
 05:26:11 -0400 (EDT)
In-Reply-To: <200907250945.18398.j6t@kdbg.org> (Johannes Sixt's message of
 "Sat\, 25 Jul 2009 09\:45\:18 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 3422C4CA-78FD-11DE-B392-AEF1826986A2-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123997>

Johannes Sixt <j6t@kdbg.org> writes:

> On Samstag, 25. Juli 2009, Junio C Hamano wrote:
>> +test_expect_success 'init notices EPERM' '
>> +	rm -fr newdir &&
>> +	(
>> +		mkdir newdir &&
>> +		chmod -w newdir &&
>> +		test_must_fail git init newdir/a/b
>> +	)
>> +'
>
> This test will require POSIXPERM prerequisite.

Heh, I knew it ;-)

Thanks.
