From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitk: Take only numeric version components when
 computing $git_version
Date: Tue, 18 Jan 2011 13:26:39 -0800
Message-ID: <7voc7dkink.fsf@alter.siamese.dyndns.org>
References: <4D231646.5080005@debugon.org>
 <1294360953.21006.2.camel@fixed-disk> <4D2C5F3E.2020007@debugon.org>
 <20110113192243.GA20625@burratino> <4D355966.7090707@debugon.org>
 <20110118104742.GA3279@brick.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mathias Lafeldt <misfire@debugon.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Anders Kaseorg <andersk@MIT.EDU>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Tue Jan 18 22:27:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PfJ4x-0000y1-KC
	for gcvg-git-2@lo.gmane.org; Tue, 18 Jan 2011 22:27:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752178Ab1ARV04 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jan 2011 16:26:56 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:54464 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751739Ab1ARV0z (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jan 2011 16:26:55 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id CAEA72105;
	Tue, 18 Jan 2011 16:27:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ResR+CJG/whNcE0Bp3CTvnF2tBk=; b=rURu7Q
	xbmXsnjnuZBf1JzkNJDnpY/hgJVkzuV0DXC4oDu3nMnBLHO2NCxku3dESqKEzzFZ
	Sed1MK7yX/K75UkVXseu+IhC76h+yEQEaoYcbdWAsFG4u9a4Iyu24v0g0HnXJlkV
	2FsPK9mX0vb73T11RJODOJVw2Lv9IDdXZ54lk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JdDTsCgdJXdQoiaAW9WjLJNkLA6hK/ll
	hoR01cnllQwK7rl/OELY8nlMx+1Nzf2O0kFh7o/pyO8mQf/4klPoXTGJPuxje5xb
	nA9l/HlIB3Wsr95o086xU6/ptqM+7PJOfoIDnmGxi3SuNwxti4NMG5doGi76XjBb
	dgTpQBv5a9s=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7A84120EF;
	Tue, 18 Jan 2011 16:27:35 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 8524120E5; Tue, 18 Jan 2011
 16:27:27 -0500 (EST)
In-Reply-To: <20110118104742.GA3279@brick.ozlabs.ibm.com> (Paul Mackerras's
 message of "Tue\, 18 Jan 2011 21\:47\:42 +1100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: C455BCB2-2349-11E0-8362-BC4EF3E828EC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165221>

Paul Mackerras <paulus@samba.org> writes:

>> OK then. Junio? :)
>
> I'll pick it up.

Thanks.
