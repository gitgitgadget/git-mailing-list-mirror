From: Junio C Hamano <gitster@pobox.com>
Subject: [notice] the tip of 'next' rewound
Date: Sun, 03 Jan 2010 15:56:33 -0800
Message-ID: <7viqbiwxn2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 04 00:56:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NRaJS-0005W9-2v
	for gcvg-git-2@lo.gmane.org; Mon, 04 Jan 2010 00:56:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752834Ab0ACX4m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Jan 2010 18:56:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752227Ab0ACX4l
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Jan 2010 18:56:41 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:58665 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751934Ab0ACX4l (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Jan 2010 18:56:41 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 19BD28DF5F;
	Sun,  3 Jan 2010 18:56:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:subject
	:from:date:message-id:mime-version:content-type; s=sasl; bh=Z0yw
	NQT4SXQgyBKzyjTzMS21QfE=; b=vTHTU9nBBU7gP+xyRmTCjZdlIZRx4wurffer
	9C9vo53s2yT84VQkdZHwK9Y8YLhbOuhcbkf5pBr0t85hVdI9OQzf3joy1iWgADhM
	b1b+l69mQvkZt1E2TSnCNcX9nk7J3j9jUK+kh51MhgYGnbWmDWKCrF+i8ebhCvJ0
	z9aV6mQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:subject:from
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=q7v
	KMoX1x5l92LJQVrLdmbyQ50FKwriTpJZ12fuMTp93EaUqCP9h1ywYI2MWfAY1OP4
	8iUXn3G+WbNx+miRtBc+pPitjtyJHaMUKxv5XgcHzckqLEEr05n5Y5YpBS5g3MHR
	EEhjrtsuJtn3cOTOS7zQrpkUpnae5IGN8lOZLMVs=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 051AA8DF5E;
	Sun,  3 Jan 2010 18:56:36 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2874E8DF5D; Sun,  3 Jan
 2010 18:56:35 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A0ECF7E2-F8C3-11DE-857D-9D59EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136085>

As announced earlier, 'next' was rebuild directly on top of 'master',
dropping a few topics that has been reverted during 1.6.6 period and
currently has only the following topics:

    nd/sparse: sparse checkout;
    tr/http-updates: support for non-Basic auth methods to http transport;
    jc/checkout-merge-base: "git checkout foo...bar" (notice three-dot);
    jh/notes: an early part of "git notes" update;
    jk/maint-1.6.5-reset-hard: fix "GIT_WORK_TREE=somewhere git reset --hard";
