From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] pull: warn on --verify-signatures with --rebase
Date: Thu, 19 May 2016 08:46:25 -0700
Message-ID: <xmqqeg8ykq3y.fsf@gitster.mtv.corp.google.com>
References: <20160518101827.GA14475@netblarch>
	<xmqq37pftks7.fsf@gitster.mtv.corp.google.com>
	<20160519100221.GB22257@netblarch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Stefan Beller <sbeller@google.com>
To: Alexander 'z33ky' Hirsch <1zeeky@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 19 17:46:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3Q9h-0002Xf-R0
	for gcvg-git-2@plane.gmane.org; Thu, 19 May 2016 17:46:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754594AbcESPq3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 May 2016 11:46:29 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50351 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754280AbcESPq3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2016 11:46:29 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9C7A81CE1C;
	Thu, 19 May 2016 11:46:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ClUylEke4vcRoQMKMeEgdIEKGAE=; b=sbwMcB
	aLYhf9V4dj2rBvr+p5j3o3ts1XUzyRNh3QW8fnl+pxscxHfIiV0h0NZ5sE89qf/p
	/TLwg9AqSQJSLi0IGq+rV+67M37iZEZw7x3A/Yuu/rH8VMsjXCQ61m+d80RWsm6t
	o+XPEc/J72YFCM48SRylvj8i9brW36qG+lsUE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=o92lIBdJDW/eMv5NwyxI+/UXTsIyk4tM
	dRU3tIBLmnofDw4FgwzukLF29PB04liETxTOv05l7N4WVVsVIsTvPz35Kjkkud8+
	Tk/yN1qDeVtOYVlZ0oT8MYhAgrJElXsQJY4WnKYyLcQhWLMYQLdbru52Sa20ba5G
	4hH/dKZrgsY=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 946511CE1B;
	Thu, 19 May 2016 11:46:27 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 075561CE1A;
	Thu, 19 May 2016 11:46:26 -0400 (EDT)
In-Reply-To: <20160519100221.GB22257@netblarch> (Alexander Hirsch's message of
	"Thu, 19 May 2016 12:02:21 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D8E64E28-1DD8-11E6-8017-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295071>

Alexander 'z33ky' Hirsch <1zeeky@gmail.com> writes:

> Would "ignoring --verify-signatures for rebase" be sufficient? It does
> not describe why it is ignored though.

Yeah, I agree that that would be sufficient.
