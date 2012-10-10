From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] svn test: escape peg revision separator using empty
 peg rev
Date: Wed, 10 Oct 2012 15:33:14 -0700
Message-ID: <7vpq4q9cut.fsf@alter.siamese.dyndns.org>
References: <1343468872-72133-1-git-send-email-schwern@pobox.com>
 <1343468872-72133-2-git-send-email-schwern@pobox.com>
 <20120728141652.GA1603@burratino> <50143E34.8090802@pobox.com>
 <20121009084145.GA19784@elie.Belkin> <5073F2C0.6000504@drmicha.warpmail.net>
 <20121009101953.GB28120@elie.Belkin> <20121010203730.GA19115@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Torsten Schmutzler <git-ts@theblacksun.eu>,
	A Large Angry SCM <gitzilla@gmail.com>,
	Michael G Schwern <schwern@pobox.com>, git@vger.kernel.org,
	robbat2@gentoo.org, bwalton@artsci.utoronto.ca
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Thu Oct 11 00:33:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TM4qG-0007Le-4n
	for gcvg-git-2@plane.gmane.org; Thu, 11 Oct 2012 00:33:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757333Ab2JJWdS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Oct 2012 18:33:18 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39162 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756906Ab2JJWdR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Oct 2012 18:33:17 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7CAE799FA;
	Wed, 10 Oct 2012 18:33:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=WQsOLBN+N7WieABqdAFoTw1PxXg=; b=EHk6NTZ63C8haY9k5QzG
	FIyjM1fuJBAkWnt0Odh06TIdIfl8Ml64vZvHUzr5s3keKsSd+BEvMNzouzvr+k5y
	FF+Z6/ZIZByKIQ7uFSENfbnPy1D184vlZl8nPrxru66UKZRlnep4P9DpEMzmGonx
	Ml4RrrPeg0TjqZy+A4LQvzs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=Uqz2xo5ag7JsP6yhx+2wO5bwRzmRdZiKlh44mO/rX5L9gd
	ehHQUk9sElaex6zuflJkfclMoBrMgTSUYipvAF5Ek5NynqmFRp/T+A7k97zslouO
	ATJWIhUYdn6Qstxyp4onFQBUtui92I+xjgoyuUZm68WS2foj0zmZ/qozzGre0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 692F899F9;
	Wed, 10 Oct 2012 18:33:16 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CE43B99F6; Wed, 10 Oct 2012
 18:33:15 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7BAA01E4-132A-11E2-8919-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207450>

Eric Wong <normalperson@yhbt.net> writes:

> Jonathan Nieder <jrnieder@gmail.com> wrote:
>> Michael J Gruber wrote:
>> > Jonathan Nieder venit, vidit, dixit 09.10.2012 10:41:
>> 
>> >> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
>> >
>> > Tested with Subversion 1.6.18.
>
> Thanks both.  Also pushed to "master" on git://bogomips.org/git-svn.git
> (commit 44bc5ac71fd99f195bf1a3bea63c11139d2d535f)
>
> Jonathan Nieder (2):
>       git svn: work around SVN 1.7 mishandling of svn:special changes
>       svn test: escape peg revision separator using empty peg rev

Thanks; pulled.
