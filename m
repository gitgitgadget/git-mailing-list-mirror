From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/3] Easier access to index-v4
Date: Mon, 24 Feb 2014 13:39:39 -0800
Message-ID: <xmqqtxbo6vhg.fsf@gitster.dls.corp.google.com>
References: <1393188599-5391-1-git-send-email-t.gummerer@gmail.com>
	<xmqqios49yyq.fsf@gitster.dls.corp.google.com>
	<xmqqwqgk8fsq.fsf@gitster.dls.corp.google.com>
	<87y510s2xh.fsf@hank.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, pclouds@gmail.com, sunshine@sunshineco.com
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 24 22:39:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WI3Ff-0007Mg-3V
	for gcvg-git-2@plane.gmane.org; Mon, 24 Feb 2014 22:39:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752468AbaBXVjq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Feb 2014 16:39:46 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57480 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751787AbaBXVjq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Feb 2014 16:39:46 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1A6EE6E430;
	Mon, 24 Feb 2014 16:39:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KfLhmiMh6OkaZ5I33+LGel3RMFI=; b=WWS0lH
	cLmgQek7HgGwL68sXtJQexIJjcl0PtVXquo5qbPuS0x3k5jUWAl4GedKKSh3n7Hg
	Iii3+yviOzulpJW03OGUOAtGc2IsqK/9DE2MHX61aIuw7SqXx0+sLE2GAjp0pFlt
	53n2Kb4GcfnZnmHIfYrvzx2UyjzjiztRl1mtM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=X5PTdwFEr0yJJCS2/c1CSW5NjG+0ZztP
	uy7fU3UO1dSX6ZflDDtLwYKcTEBwYKoGXJ+DoPSHBLuO0XCuWfslgel8+6jl0ogA
	7WTn6gVdQhH1ChWNXzYFHbOc8HeL3pgX4W79bw//71xfel0J7r8ymrNfSB6nlscE
	11VQZVAbL0E=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 01C2F6E42F;
	Mon, 24 Feb 2014 16:39:43 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 279576E42E;
	Mon, 24 Feb 2014 16:39:42 -0500 (EST)
In-Reply-To: <87y510s2xh.fsf@hank.lan> (Thomas Gummerer's message of "Mon, 24
	Feb 2014 20:53:14 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 2B8311C6-9D9C-11E3-A7EF-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242649>

Thomas Gummerer <t.gummerer@gmail.com> writes:

>> Something along this line, perhaps?
>
> Sorry about this, I didn't run the test suite without
> TEST_GIT_INDEX_VERSION in config.mak which I obviously should have.
>
> Yes, this looks good to me, thanks!

OK, will squash it (but using "VAR:+isset" instead of "VAR+isset" to
allow people to set it to empty to disable) into the relevant patch.

Thanks.
