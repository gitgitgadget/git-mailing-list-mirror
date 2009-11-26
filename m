From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] gitweb: Make linking to actions requiring JavaScript
 a feature
Date: Thu, 26 Nov 2009 12:34:55 -0800
Message-ID: <7vws1d3tzk.fsf@alter.siamese.dyndns.org>
References: <1258659887-5244-1-git-send-email-bebarino@gmail.com>
 <7vpr76m8dx.fsf@alter.siamese.dyndns.org>
 <200911260159.48311.jnareb@gmail.com> <200911262112.16280.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Stephen Boyd <bebarino@gmail.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 26 21:35:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDl3Y-0005gv-7p
	for gcvg-git-2@lo.gmane.org; Thu, 26 Nov 2009 21:35:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752765AbZKZUe7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Nov 2009 15:34:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752761AbZKZUe7
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Nov 2009 15:34:59 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:44625 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752729AbZKZUe7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Nov 2009 15:34:59 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D91FE83F22;
	Thu, 26 Nov 2009 15:35:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=At8HVzOaHXE+a3fd1OFgJMnHHLE=; b=Bac/UN
	Xhi/WUwURXaWtvr1pxQiC+RDfThCrXezGb8tNjBZq55SMuy6Id/P0W7ww1MrBcmf
	uRIH3h1TxXPYPjEOubX0VhTunRyoYfQEoZ+aDYaNCduCy0rWai6S2tFB8adEMsg0
	DjMsIYB3yMmy7EsD5u2p/mdpDZ9/cAdN/1Rqg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=st4qDbfpgQyg7pa6D+DIY92bCQ54HXH8
	MgmypmLKtiOud1HV9faBaJPZ6dUzOiREi9HXoodm7sBTfCMKmXWh3eMzZCPIfOBH
	y+o0tvl4Zf3e+7sJmgOFFh8XEvmxAudC532y0r3Lmbi0svy+WQPDMPS/Jig5qYQG
	XnVCCRn19n4=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id AC1F583F21;
	Thu, 26 Nov 2009 15:35:01 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CFB4183F20; Thu, 26 Nov
 2009 15:34:56 -0500 (EST)
In-Reply-To: <200911262112.16280.jnareb@gmail.com> (Jakub Narebski's message
 of "Thu\, 26 Nov 2009 21\:12\:15 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 2BD6F7E8-DACB-11DE-B35A-9F3FEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133833>

Jakub Narebski <jnareb@gmail.com> writes:

> Let gitweb turn some links (like 'blame' links) into linking to
> actions which require JavaScript (like 'blame_incremental' action)
> only if 'javascript-actions' feature is enabled.

Hmm, instead of "fixLinks" that actually munges existing links to working
action with some other action, can that be "addLinks" that _adds_ new
links to features available only when JS can be used?
