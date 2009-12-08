From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [REROLL PATCH 7/8] Support remote archive from external protocol
 helpers
Date: Tue, 08 Dec 2009 15:39:42 -0800
Message-ID: <7v7hsx5935.fsf@alter.siamese.dyndns.org>
References: <1260278177-9029-1-git-send-email-ilari.liusvaara@elisanet.fi>
 <1260278177-9029-8-git-send-email-ilari.liusvaara@elisanet.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Wed Dec 09 00:41:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NI9es-0007hu-38
	for gcvg-git-2@lo.gmane.org; Wed, 09 Dec 2009 00:39:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966714AbZLHXjn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Dec 2009 18:39:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966705AbZLHXjm
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Dec 2009 18:39:42 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:60288 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966694AbZLHXjm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Dec 2009 18:39:42 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E9700A5310;
	Tue,  8 Dec 2009 18:39:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=2TbaVtVdeKF/KFxzaubhBmJQb6o=; b=XMKSKf2V6aZlPoq6oq7OeIH
	UlXXDxB+tTQNW13c1zvxaIiUyNwKaEqTTtqxjZjeFm6RPNUU73qf0VO3+CsesnqY
	vuiktlIAbPQmyaBS50Ae0i0pz+2bbmL9qUNYtRh1HZJJ3xMGUvy4F1x/vOrpprzN
	F4iSAUP+E8N4c09HhkUM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=pqazmyJn0KjGv7KExYTpkTsLCv6t8Y29H+1CfI4xkqQ6V9AD6
	1FxGWlAA4he68QR0bpMZIhSSSUvSm+lzBZAKsQvAnQB0bApkgMZBD8Pos+WbCApH
	9dfryHCQh17B3oj/7GYqT4Nj1vePwE6+8CHU7whA6NXgp1MbvmJhAaaQZk=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C6E67A530F;
	Tue,  8 Dec 2009 18:39:46 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id CD729A5309; Tue,  8 Dec 2009
 18:39:43 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: F80C651A-E452-11DE-9AC5-EF34BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134926>

Ilari Liusvaara <ilari.liusvaara@elisanet.fi> writes:

> Helpers which support connect also should support remote archive
> snapshot (or at least there's only one way to attempt it). So support
> remote snapshotting for protocol helpers.

Sorry, but I cannot parse this "should", and cannot understand how the
first sentence leads to the conclusion ("So") that we must have this
patch.

"They should support it when able, because doing so gives them _this nice
property_ (that is unspecified)"???

Or "They must support it because we are changing the code not to work
without"???

Or "Because the transport layer has been restructured cleanly enough to
allow passing general payload, there is no reason not to do this change to
pass 'archive' output in addition to the 'git smart fetch/push protocol'
payload, and this allows the archive command to take advantage of the
helper based transports"???
