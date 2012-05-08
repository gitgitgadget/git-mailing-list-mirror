From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/65] Mark parseopt strings for translation
Date: Tue, 08 May 2012 11:40:58 -0700
Message-ID: <7vlil2v7lx.fsf@alter.siamese.dyndns.org>
References: <1336314232-21002-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jonathan Niedier <jrnieder@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 08 20:41:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRpLQ-0001Le-2h
	for gcvg-git-2@plane.gmane.org; Tue, 08 May 2012 20:41:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756798Ab2EHSlE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 May 2012 14:41:04 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61740 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755717Ab2EHSlC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2012 14:41:02 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2C8EB681A;
	Tue,  8 May 2012 14:41:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=aerc/6SwqiqQ+TFkNAX0YGTtqiU=; b=Do3s1T
	RqxpsfH41QdI1H5W6Xir1UfFjIJpq2jD47tHs9c7fzZKipeMNAIWYwK1ZFJ7glUC
	tOPmexovEzQLVi3dgkgo4KKVWp5bg4z/ur7J+zsns5ulhn+lC6l5onJFDUWCxv86
	sVbVMO/fyeSGf0ILWh6ZE7NGcY3JOMqev8BTE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HtMebMuvNejyUQN0gV66HUtoomwfB2hQ
	mcU0Y1xZk/VAmvkl4fSCN76nWhZZgbMFytYY5fcWVJFh7sgzZxzCI4wX5LpWJG2k
	H6rjBuUOVqrfYpPsb4jnM9gex3wXmrDozRKPB8b3Ai8eEg4S0V5hXGQHnBOUhQ0u
	k5/TvL8efpU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 232206819;
	Tue,  8 May 2012 14:41:01 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E5FC26818; Tue,  8 May 2012
 14:40:59 -0400 (EDT)
In-Reply-To: <1336314232-21002-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Sun, 6 May
 2012 21:23:50 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5B2CB23E-993D-11E1-A7C7-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197415>

Both 01/65 (the parse-options implementation) and 02/65 (sample conversion
of apply.c) made sense, so I'll queue them first.

Thanks.
