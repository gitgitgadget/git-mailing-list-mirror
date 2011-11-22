From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/3] revert: remove --reset compatibility option
Date: Tue, 22 Nov 2011 15:38:11 -0800
Message-ID: <7vvcqbd8yk.fsf@alter.siamese.dyndns.org>
References: <20111120073059.GA2278@elie.hsd1.il.comcast.net>
 <CALkWK0=45OwcBoH2TorsgwTbaXjnffVuh0mGxh2+ShN9cuF-=A@mail.gmail.com>
 <20111120094650.GB2278@elie.hsd1.il.comcast.net>
 <20111122111207.GA7399@elie.hsd1.il.comcast.net>
 <20111122112046.GG7399@elie.hsd1.il.comcast.net>
 <7vzkfnde05.fsf@alter.siamese.dyndns.org>
 <20111122231145.GE6274@elie.hsd1.il.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>, git@vger.kernel.org,
	Christian Couder <chriscool@tuxfamily.org>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Phil Hord <phil.hord@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 23 00:38:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RSzuu-0003aO-Vy
	for gcvg-git-2@lo.gmane.org; Wed, 23 Nov 2011 00:38:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756906Ab1KVXiP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Nov 2011 18:38:15 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59061 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754642Ab1KVXiO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Nov 2011 18:38:14 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5C32964A8;
	Tue, 22 Nov 2011 18:38:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RP8SP9og07UH8ZKiwmv+BPf2Oks=; b=a8pG7V
	fcC3/sdTTN45s2918N7CtkNKy7+DzP3olux4IOXfhqsh/znj1rpPL9LPeR6wdLEl
	TrBrbHAc/yEuFz1AgKuCzYVGENBxkBHH+ByjbTkhRiq+9mdjWuJ6xY1in17P1qdQ
	mnJbzmP0C/F5XW3FkLKoYOck81an7CR2tBbYc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=a6tj6Uf14P14eUpE++ch7ZOBGF0A6OfS
	ArNZhU3Cpbx0qgITrKoEo6WHnXCHIHjpZsYkXB8MSiCHtBjK4a+N1uj2UpeN+wT9
	lcqKJ+xMa3+wU849nZ0acqheEtPaz4be+IgVJO4WYsZxgfram2wQnTM+N8NpWX+Q
	v0DYcynKW04=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5231664A7;
	Tue, 22 Nov 2011 18:38:13 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B053764A4; Tue, 22 Nov 2011
 18:38:12 -0500 (EST)
In-Reply-To: <20111122231145.GE6274@elie.hsd1.il.comcast.net> (Jonathan
 Nieder's message of "Tue, 22 Nov 2011 17:11:45 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0AF5D7CC-1563-11E1-9B75-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185814>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Junio C Hamano wrote:
>
>> If we want to reach this point eventually, given that --reset was not in
>> any released version, and also given that we are deep in pre-release
>> phase, we probably should either just apply the first one (and perhaps
>> this one) from the series immediately before 1.7.8 final, or delay the
>> final and swallow the entire series.
>
> Makes sense.

Ok, then let's do the latter, and make tomorrow's pushout a 1.7.8-rc4; I
read the series over and they seem to make sense.
