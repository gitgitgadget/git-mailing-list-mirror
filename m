From: Junio C Hamano <gitster@pobox.com>
Subject: Re: triggering pack-refs
Date: Tue, 29 May 2012 12:47:35 -0700
Message-ID: <7vvcje3h2g.fsf@alter.siamese.dyndns.org>
References: <4FC4A84B.3020404@yahoo.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Vangelis Katsikaros <ibob17@yahoo.gr>
X-From: git-owner@vger.kernel.org Tue May 29 21:47:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SZSOM-0000Z6-Cv
	for gcvg-git-2@plane.gmane.org; Tue, 29 May 2012 21:47:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755300Ab2E2Tri (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 May 2012 15:47:38 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42374 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754581Ab2E2Tri (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 May 2012 15:47:38 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 99E4F926B;
	Tue, 29 May 2012 15:47:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FDcO4Vu69ICY54Dm/XZXqVf+IbQ=; b=XKCcI8
	YQ6odIqTQVwZywmycHbZD/5RnwG0ZRfQ0clJJb9gnrPDb8cV6Fcl6VofFRkJIJtB
	EV54WLWPygIthnUTYTgNh0BW1Odjhrr9JXnXKkIb4GxJ84doPxawNexGHe7ogkuh
	ny59fjaW3CeYVO6lE2YmLezeTSVELG/kf5+mc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gJ/l6PVCcGTuczzu6HcFCaeP2OJbgbif
	CULZYsiu1VUBixRSZQj511YDfG3IKmPeqmdOQ3XtNhDslqx8xt7eOWrs130mLHe4
	axl8ELfIST7RjKgxPMEK549O++s9GYaEYdHpjUW5j4Ow/qWEKyjwwyETS6AN0OnM
	Tz0uEymOy+E=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 90FC6926A;
	Tue, 29 May 2012 15:47:37 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 22E939269; Tue, 29 May 2012
 15:47:37 -0400 (EDT)
In-Reply-To: <4FC4A84B.3020404@yahoo.gr> (Vangelis Katsikaros's message of
 "Tue, 29 May 2012 13:43:23 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 245DB3E4-A9C7-11E1-B902-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198756>

Vangelis Katsikaros <ibob17@yahoo.gr> writes:

> My question: is it normal for git pack-refs to be triggered during a
> push for the first time at some point in time (because a threshold of
> something was exceeded),

Yes, it is part of "gc" iirc.
