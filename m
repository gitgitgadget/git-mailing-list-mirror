From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Suggestions for "What's cooking"
Date: Thu, 13 Sep 2012 08:09:10 -0700
Message-ID: <7vlige9cyx.fsf@alter.siamese.dyndns.org>
References: <7vpq5tjuw3.fsf@alter.siamese.dyndns.org>
 <504F8427.1020507@web.de> <7vhar4gxdq.fsf@alter.siamese.dyndns.org>
 <5050E0CA.7080907@web.de> <A7A1DB46082142E683753CFBC0A22A6B@PhilipOakley>
 <90925598F9104F7FAC680544FABE0A79@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Jens Lehmann" <Jens.Lehmann@web.de>, <git@vger.kernel.org>
To: "Philip Oakley" <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Thu Sep 13 17:09:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TCB2o-0005dt-Cm
	for gcvg-git-2@plane.gmane.org; Thu, 13 Sep 2012 17:09:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758149Ab2IMPJU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Sep 2012 11:09:20 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40433 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753473Ab2IMPJQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Sep 2012 11:09:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EE2BF8DC5;
	Thu, 13 Sep 2012 11:09:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=07KAOVCvgmBZt6egWj8cEJDKu9w=; b=HUG/5S
	1QDVHjBl2y7ql0jeoYYw8n69qB9PmoAiPH0g4LkVeoz8Uuq6zYvkIrxJF90nAy6U
	WT7dtM3pW6WODT5NsOtkCSeguX9KN8mUsYpWrA3oIK68p8Fy1/ok4KPxvVVET+AZ
	Sdm3Mw+6ZxdFJ0ZIpjYtRWFEzvCRSNjfYyPwk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BRvA9pkQS9nLxqgaZDFrGZQKPivdDbVs
	/fvVNMXICCyEVTQMZgBfgn0purYp7+TpcW7gaGtpCj1SUk9enQvz+29fW/FIJc1l
	4zkzXt5A/7mjW8bhaxJndO6gzlg/vO7Xw0OUYyjcT1WzkIsHLMZvVa6UoQ+b3+7D
	m7EkviGTAxA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D2E748DC1;
	Thu, 13 Sep 2012 11:09:12 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4BE0E8DBE; Thu, 13 Sep 2012
 11:09:12 -0400 (EDT)
In-Reply-To: <90925598F9104F7FAC680544FABE0A79@PhilipOakley> (Philip Oakley's
 message of "Thu, 13 Sep 2012 08:21:45 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F9B575EA-FDB4-11E1-A82B-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205383>

"Philip Oakley" <philipoakley@iee.org> writes:

>> Thinking about it, if the description paragraph was indented by one
>> space then the * title  would create that obvious content indent
>> that (I am) would be expected.
>>
>> Obviously only a useful suggestion if it's easy to implement...
>>
>> Philip
> Thinking overnight. One very simple option is to just add a double
> line spacing between items to give a clearer break.

I've played with both and have prepared patches to Reintegrate and
cook (both in the 'todo' branch).  Will play with the changes a bit
more and then decide.

Thanks.
