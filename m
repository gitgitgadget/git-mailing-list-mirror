From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2] test-lib: TAP compliance for skipping tests on request
Date: Mon, 12 Jul 2010 09:44:32 -0700
Message-ID: <7vd3usd4zz.fsf@alter.siamese.dyndns.org>
References: <AANLkTiml1lQlSBDGgUg9scsvsaffDT2n405USmsSIm1n@mail.gmail.com>
 <82aab66bffd86b562c76a13a4666d3cf22a64cca.1278930335.git.git@drmicha.warpmail.net> <AANLkTimAu6H4hK-WEhjrGDr5CICWzB_wxrD-GgrBtdKe@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 12 18:44:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OYM7c-0004wm-Ec
	for gcvg-git-2@lo.gmane.org; Mon, 12 Jul 2010 18:44:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755962Ab0GLQon (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jul 2010 12:44:43 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:38113 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751622Ab0GLQom (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jul 2010 12:44:42 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 75C5AC4356;
	Mon, 12 Jul 2010 12:44:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=N7WuDyLeDcKHEHRrtjsCNHTD4jw=; b=mmvwo/+mbqPbEMh3am55uJg
	5G/SbI9bm4vQgTdoArGqvnzJxo1vn+JMjqRs6rhjzDDquIm9wZUhK3phf5WbYl7I
	xkvKuZw2QWadrR6DajRpnX+xeQEW/9XtJPmTHHsOqAHu2SJionixKCdafm19MMVb
	NBd7A+Hrzi05Kjqme+eg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=jNWQ2h0n+phn6qPVxpFOIliJJ9Q0ygeTVUxk23DumHUuBIZpe
	QH7mGFtltkNAav7k/Ebmu8V3CbCmlB1sVXkVWPtztdGhilYn05SeaTSqVpSKQGVw
	7QGYTiJRIVtflMUqxwnP5MPfa/pHzvHPsIwdUrMlk6t7CT1x8nffk5fRts=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 32B70C4353;
	Mon, 12 Jul 2010 12:44:38 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6AE73C4351; Mon, 12 Jul
 2010 12:44:34 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: C297F51C-8DD4-11DF-B5B6-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150826>

Thanks, both.
