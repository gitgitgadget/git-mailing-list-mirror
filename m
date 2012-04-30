From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Apr 2012, #11; Sun, 29)
Date: Mon, 30 Apr 2012 08:22:41 -0700
Message-ID: <7vmx5tgs72.fsf@alter.siamese.dyndns.org>
References: <7vbomahu1h.fsf@alter.siamese.dyndns.org>
 <20120430122440.GA25045@padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Luke Diamand <luke@diamand.org>
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Mon Apr 30 17:22:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SOsR8-0001WR-5Y
	for gcvg-git-2@plane.gmane.org; Mon, 30 Apr 2012 17:22:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756100Ab2D3PWp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Apr 2012 11:22:45 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37563 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753403Ab2D3PWo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Apr 2012 11:22:44 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B62AA6F09;
	Mon, 30 Apr 2012 11:22:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nwScOm5RlAmQXESqnCSpFF6JTvY=; b=lgFmIF
	UtK/ldJWtqRe0v5eedQwVRDHQoRAvithxnuP3diHNYb6aGRq2wYtOAK4VygLoRFL
	Jb5pBDDtrlSARlMfdr51MnURlriXLeMjIO7iho3elEbzKE8PkmbJk+0CswhpTDOq
	BW2TQgSiM4Vxiyt0J4d7EAkgzdKa4ptoku2Mg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PhhhSyvMk8qVTnWClpd/qVQOY/a9HQWF
	PIVSfgjlwJt+4OA9BArQzxr4jCjYVyLtmjhsctlPg+N8GsjFIZDiznGnLPwEsZ+D
	Ch/zoQXh8CjQkVrWGP7vu+gemss6eFVhtMcCqqHikBL1Ll5tIj58y3WcDX+3hnvW
	e9H2UMWa450=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ADB166F08;
	Mon, 30 Apr 2012 11:22:43 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 44F546F07; Mon, 30 Apr 2012
 11:22:43 -0400 (EDT)
In-Reply-To: <20120430122440.GA25045@padd.com> (Pete Wyckoff's message of
 "Mon, 30 Apr 2012 08:24:40 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 54E85E16-92D8-11E1-993E-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196564>

Pete Wyckoff <pw@padd.com> writes:

> gitster@pobox.com wrote on Sun, 29 Apr 2012 18:45 -0700:
>> * ld/git-p4-tags-and-labels (2012-04-25) 7 commits
>>   (merged to 'next' on 2012-04-25 at 8b959e5)
>>  + git p4: fix unit tests
>>   (merged to 'next' on 2012-04-24 at bf55d92)
>>  + git p4: move verbose to base class
>>  + git p4: Ignore P4EDITOR if it is empty
>>  + git p4: Squash P4EDITOR in test harness
>>  + git p4: fix-up "import/export of labels to/from p4"
>>   (merged to 'next' on 2012-04-15 at 1b1e9a1)
>>  + git p4: import/export of labels to/from p4
>>  + git p4: Fixing script editor checks
>> 
>> What's the current status of this topic?  Pete?
>
> I read through these again.  It all looks good and works.

Thanks; will merge to 'master' shortly, then.
