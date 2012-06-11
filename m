From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/3] git-svn: use YAML format for mergeinfo cache when
 possible
Date: Mon, 11 Jun 2012 08:06:03 -0700
Message-ID: <7vy5nt99d0.fsf@alter.siamese.dyndns.org>
References: <1313979422-21286-1-git-send-email-jgross@mit.edu>
 <20110823081546.GA28091@dcvr.yhbt.net>
 <7vobzgrrbg.fsf@alter.siamese.dyndns.org> <20120527192541.GA29490@burratino>
 <20120527201450.GA3630@dcvr.yhbt.net> <20120609222039.GD28412@burratino>
 <20120610090039.GA12868@dcvr.yhbt.net> <20120610100447.GE30151@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Wong <normalperson@yhbt.net>, Jason Gross <jgross@MIT.EDU>,
	git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 11 17:06:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Se6CK-0007Hj-B6
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jun 2012 17:06:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755167Ab2FKPGI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jun 2012 11:06:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37093 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755644Ab2FKPGF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2012 11:06:05 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6D64D8980;
	Mon, 11 Jun 2012 11:06:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BQScN3rOq1SGxsD2IVndVakoQ/0=; b=sRW6v6
	ohqgog4uxG7NwsZvZ4c1hXMJC9Tj2csp2ahLqt7BcY9urK+sfyNlAeZl1mAeYluk
	4QQc/PCAykcD/Bf4p05S44GQ8pmnKlwm68ndm2A5A2It7qXBd1W7uwBksykl3N05
	YGUncmzUZBibHhn+LMcecXRSnckqpk8oHshvo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GSeqISLqxwpjDSe9nrcskgp9dgSWyCaT
	SjefJCIsCXYN1YzKt4w3QSRSfcCj14o7pzls2sfTsVDbepC4k/Cn29oxuBS/RlQS
	dLi76B3Od1TDCVSej8PREdnjS1++QdmOe7OnmfFeOnyMcDRo8X2k7tphv264kae3
	kTcn+hKWC7Q=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 64F8A897F;
	Mon, 11 Jun 2012 11:06:05 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E5C01897D; Mon, 11 Jun 2012
 11:06:04 -0400 (EDT)
In-Reply-To: <20120610100447.GE30151@burratino> (Jonathan Nieder's message of
 "Sun, 10 Jun 2012 05:04:47 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F7343964-B3D6-11E1-9AD6-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199657>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Eric Wong wrote:
>
>> 2/3 had a conflict with commit c26ddce86d7215b4d9687bd4c6b5dd43a3fabf31
>> which I resolved by hand
>
> That was fast. :)  Checked by glancing through the output of
>
> 	git diff 9f7ad147^:git-svn.perl 9f7ad147:perl/Git/SVN/Ra.pm
>
> Looks good.
>
> Good night,
> Jonathan

Thanks, both.  Pulled.
