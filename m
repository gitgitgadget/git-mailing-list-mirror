From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] Make the largest pack the first one in the pack
 search queue
Date: Tue, 06 Mar 2012 19:21:17 -0800
Message-ID: <7vhay1p042.fsf@alter.siamese.dyndns.org>
References: <1331089308-16706-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 07 04:21:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S57RN-0008Fz-Ql
	for gcvg-git-2@plane.gmane.org; Wed, 07 Mar 2012 04:21:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757299Ab2CGDVU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Mar 2012 22:21:20 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44246 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756680Ab2CGDVT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2012 22:21:19 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2F4F96FD9;
	Tue,  6 Mar 2012 22:21:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EZ7GHfY4+FUz2FIa//aXU1e2nYU=; b=tk/aTA
	lhnA9i6AsZJ1zBULWWtgHnRhNcGCKcscuJj3Cu2dSCRAb2ixQsEn/FWahcuaxXE6
	YjRDbk0ySVlXQqP9KbY18TbQO4E9TpvNlVNDVzjgg/2hhuCKuu3lJ0vPs42mMi8g
	AkTzD+3kIUfwngTtgcYfwa74bJ/KIgyTBwQkk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wgWUQ1nTmiOZI4GyQNOMUHC7vmdipqw9
	mk2TWPe3kLYg1tRCg8TiOrIVa/+V1cDm1cW7TP2luf/UTVyQKXt3UxJRV/fFYLfO
	QQ5+zULUAfoLNJBMxEpswsbUFx2ou3F9pVWztn1q/MvNPyQdJ7m8ca1nvoMcDTgq
	SXV0U9Y6ZdU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 26D716FCF;
	Tue,  6 Mar 2012 22:21:19 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AEC2F6FCE; Tue,  6 Mar 2012
 22:21:18 -0500 (EST)
In-Reply-To: <1331089308-16706-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Wed, 7 Mar
 2012 10:01:48 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9AFD1EA4-6804-11E1-AB9B-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192426>

As the expected pay off from this change seems to be only based on a
hunch, it is hard for anybody to give useful comments on a patch
like this without benchmarks. As the implementation is more or less
trivial, the only thing anybody could say is "if changing the search
order is proved to be useful, the patch seems sane," but the "if"
part poses a lot bigger question than the patch itself.

At this late in the cycle, I would rather see a contributor with
many in-flight topics to start sifting his own existing topics into
the ones to be polished for the next release and the others to be
postponed for the next cycle, instead of adding yet more topics with
untied loose ends at this point.

Thanks.
