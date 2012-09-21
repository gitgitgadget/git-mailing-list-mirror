From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Quickly searching for a note
Date: Fri, 21 Sep 2012 13:04:41 -0700
Message-ID: <7vtxur3zxi.fsf@alter.siamese.dyndns.org>
References: <505C7C80.3000700@workspacewhiz.com>
 <7vy5k370n7.fsf@alter.siamese.dyndns.org>
 <505CB21E.4040607@workspacewhiz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Joshua Jensen <jjensen@workspacewhiz.com>
X-From: git-owner@vger.kernel.org Fri Sep 21 22:05:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TF9T6-00051W-98
	for gcvg-git-2@plane.gmane.org; Fri, 21 Sep 2012 22:04:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757981Ab2IUUEp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Sep 2012 16:04:45 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63219 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757737Ab2IUUEo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Sep 2012 16:04:44 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5D22A837C;
	Fri, 21 Sep 2012 16:04:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WQXQLxgXNhWvZ2rVJD7Ka/FWlfY=; b=Fl+Ssu
	focAOqXoj6SKLsWKrcY4A2Q5eegjCyoNNcSHHepKhodiTx3pJQPN5+36cg3N6BrM
	nW3iq5WIuyOREetfRFWMJRZQ5gHjVGkoSg6nUF2vati+ISVcb95Stjm+QJBINEzU
	aRTa7VxFHF3ETovtEXM7NtU4+m82bbzdAgWZg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fuDG5RmKV4tz2M5XRS7fpXi/fph33jTZ
	5h5pP+JqF6RM3Gxr33vVbOkGYYiPlM4JawJEvFyxU6CVr6w5u4cM944R72GfaCOR
	OfpkEXSW82QEx5klMcrBk3g0STlzDozx1/H8X7TyKhV+r8jF4U5PKCgJ4/2TBBoo
	WwlBdKvq5Lg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4B657837B;
	Fri, 21 Sep 2012 16:04:43 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BBDC38379; Fri, 21 Sep 2012
 16:04:42 -0400 (EDT)
In-Reply-To: <505CB21E.4040607@workspacewhiz.com> (Joshua Jensen's message of
 "Fri, 21 Sep 2012 12:29:50 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9530C038-0427-11E2-BE8B-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206156>

Joshua Jensen <jjensen@workspacewhiz.com> writes:

>> Is there any particular reason you do that as two separate steps?
>> It would feel more natural, at least to me, to do something along
>> the lines of
>>
>> 	git log --show-notes=p4notes -1000
>>
>>
> Thanks for the reply.
>
> I did not make clear above that I want to stop looking when I find the
> first commit that has the note.
>
> In the case of 'git log --show-notes=p4notes -1000', Git will process
> and hand me the log output for 1,000 commits.  It is rare I need to
> walk that deep.

I simply matched it with your initial "rev-list --max-count=1000".
The "log" command pages and you can hit 'q' once you saw enough (in
other words, you do not have to say -1000).
