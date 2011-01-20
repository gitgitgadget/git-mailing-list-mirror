From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Wish: make commiter email address configurable per-repo
Date: Thu, 20 Jan 2011 10:44:09 -0800
Message-ID: <7vfwsns9dy.fsf@alter.siamese.dyndns.org>
References: <ig73o1$lbg$1@dough.gmane.org>
 <201101071420.40570.trast@student.ethz.ch> <ig7449$lbg$2@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Stephen Kelly <steveire@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 20 19:44:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PfzUp-00010H-V9
	for gcvg-git-2@lo.gmane.org; Thu, 20 Jan 2011 19:44:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753582Ab1ATSoV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Jan 2011 13:44:21 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:45028 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752186Ab1ATSoU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Jan 2011 13:44:20 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 66D88497D;
	Thu, 20 Jan 2011 13:45:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=M+ibsZohCXofQfwlNOOEe9dcrEI=; b=Wi6/iY
	2+juB2hBYlas1ZkKaVqkFgWJAaGjXhAm085FK0C8RicqR9nn5/YPCuPb3Nicwy/v
	XlnEOmyS6F/ZFs6FRd/D0lG6saJDbU3EqfYg32NFlEGZpClrDYOpZTOiIfZ6Lna2
	g6GpTxBlwgT8rUWbixieDnjGXf5lBvJYuMzBI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RH8Ie0R1087XSfNMEVHdrlYCJA6C6REc
	WaTvnVDswp/C5LQeDUPdR8Ag1yTgaj9dW+Utq+pZOPRRWyTct5i81dKy1lUSbGl2
	IEzNiooEoZRK7iYstpRHAw04sWas0qKShfaidipOSkC294BjtkfW05ELtxHIJEfh
	3NcNroyFa40=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3366C497C;
	Thu, 20 Jan 2011 13:45:00 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 37F34497A; Thu, 20 Jan 2011
 13:44:56 -0500 (EST)
In-Reply-To: <ig7449$lbg$2@dough.gmane.org> (Stephen Kelly's message of
 "Fri\, 07 Jan 2011 14\:23\:21 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 628BCF76-24C5-11E0-A4B9-BC4EF3E828EC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165321>

Stephen Kelly <steveire@gmail.com> writes:

> Thomas Rast wrote:
>
>> Stephen Kelly wrote:
>>> So for some git repos in KDE which I work on on work time, I'd like to
>>> set a different committer address. I can't just set GIT_COMMITTER_EMAIL
>>> or whatever in my bashrc, because in other repos I want to use a
>>> different committer email, and don't want it set globally for all git
>>> repos I work on.
>>> 
>>> This doesn't seem to be configurable in git config. Can that be changed?
>> 
>> See user.email in git-config(1).  Most people set it globally, as in
>> 
>>   git config --global user.email "author@example.com"
>> 
>> but there's nothing stopping you from doing
>> 
>>   git config user.email "alias@example.com"
>> 
>> to set it on a per-repo level.  (Or just edit .git/config, of course.)
>
> Doesn't this set both the author and the committer?

And the reason why that is a bad thing is...?
