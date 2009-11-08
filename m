From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Automatically remote prune
Date: Sun, 08 Nov 2009 11:08:18 -0800
Message-ID: <7vocncdecd.fsf@alter.siamese.dyndns.org>
References: <43d8ce650911040242l44bbf87dm35494e04ce9039aa@mail.gmail.com>
 <7v639qi2un.fsf@alter.siamese.dyndns.org>
 <43d8ce650911041741w4b39d137ha2a1529a15256d27@mail.gmail.com>
 <7viqdpemki.fsf@alter.siamese.dyndns.org>
 <43d8ce650911050005l6d120cb0h374f3c04b3948b25@mail.gmail.com>
 <7v3a4sagau.fsf@alter.siamese.dyndns.org>
 <76718490911051509r65af2dd2k2574e2e521fed6f2@mail.gmail.com>
 <20091106001751.GF17748@machine.or.cz>
 <76718490911051638w7cd5306bx65ed8d9ac525d2c3@mail.gmail.com>
 <20091106103100.GG17748@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	John Tapsell <johnflux@gmail.com>,
	Git List <git@vger.kernel.org>
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Sun Nov 08 20:08:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N7D7v-0004Ul-Oj
	for gcvg-git-2@lo.gmane.org; Sun, 08 Nov 2009 20:08:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755007AbZKHTI2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Nov 2009 14:08:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755005AbZKHTI2
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Nov 2009 14:08:28 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:38595 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755003AbZKHTI1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Nov 2009 14:08:27 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A31C497BA0;
	Sun,  8 Nov 2009 14:08:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=NsXPShGlRgJtMx3P9+/e3BaYZXc=; b=LMsIkcXqhlabXOYCQPiag9p
	kfNi7UWzz5WuYRp3ILfEq3x2tJGfibiohGtreyDTHJGq6YwM9DLEN1geuIOCWdi2
	7KeHSBpJfPoAWe3khIatkDM4DVja6VXWezWczepES0EdbiSrwPKJ2/CPXvyfOBd8
	l45suGgoPgKB3QkRFTgU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=xlMDX8v0briSVHL8B8Rze51U+WJVeelyQF8flsLF0VohTFgxB
	3nnXMN89h5nmneDIopLCxzinTwaECWBSIeaAQgF/+AuFDx06R+QpLOeb5iUI3lNu
	NYMAhBp9sbDBfBo6YqsBDsXDbdNxfZL8sR1K6mJXpmdx2wR9VVGHnL6QHM=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2B12097B9F;
	Sun,  8 Nov 2009 14:08:28 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 8071597B9C; Sun,  8 Nov 2009
 14:08:20 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 18D505AC-CC9A-11DE-9961-D595BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132412>

Petr Baudis <pasky@suse.cz> writes:

> On Thu, Nov 05, 2009 at 07:38:39PM -0500, Jay Soffian wrote:
>> On Thu, Nov 5, 2009 at 7:17 PM, Petr Baudis <pasky@suse.cz> wrote:
>> > On Thu, Nov 05, 2009 at 06:09:03PM -0500, Jay Soffian wrote:
>> >> Actually, mirror mode applies to push only. Unless I'm missing
>> >> something obvious.
>> >
>> > Perhaps you are, mirror mode applies to fetch as well...

Sorry, my thinko.  We do not do mirrors in fetch.
