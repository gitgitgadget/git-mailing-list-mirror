From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Oct 2011, #06; Tue, 18)
Date: Tue, 18 Oct 2011 09:53:25 -0700
Message-ID: <7vmxcygs1m.fsf@alter.siamese.dyndns.org>
References: <7vzkgyhh6n.fsf@alter.siamese.dyndns.org>
 <CABURp0po3C9-a4_cGm8gq71=gq2ELzHWBK0y7H=OEcY1=DUdsw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 18 18:53:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RGCv3-00009n-VY
	for gcvg-git-2@lo.gmane.org; Tue, 18 Oct 2011 18:53:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932790Ab1JRQxb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 18 Oct 2011 12:53:31 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50579 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753538Ab1JRQx2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Oct 2011 12:53:28 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DC0FD67F0;
	Tue, 18 Oct 2011 12:53:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=g7anDjKxxJA9
	A0khj+ihexwJ9a0=; b=VavLke/5xhPyb/WjLzmROwCmWTMjWAFL+3xmNf/JJB77
	GSVQ1wx4ZS3d2ynVCZhcYu49+ql3ZcaTro08YeX7xngmyQA94+NRfuO5N6EeqXjN
	lu5/BEgTdPIs0QfpYwzo+AzpUmf5rIpTa/dKv8XTG8dk/ru+Ih+DaoNcL9ASWa4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=mnP8r+
	1dR/F3WHxE9Odm5T+JFGIKrmk6rcprffvxJPNQ3vWAKTUg5+iGmQ4vTrplp2bYCQ
	HOugSdWxmV/yJQzeZSDZSTTWFIjQjSWukWt7qO6sopVpvMyc2C5Z0ke3BwlZNgML
	zZeEycWSBbq1vB4GJb81lJNFwW+hAVl3VDG+A=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D26F467EF;
	Tue, 18 Oct 2011 12:53:27 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5E7FE67EE; Tue, 18 Oct 2011
 12:53:27 -0400 (EDT)
In-Reply-To: <CABURp0po3C9-a4_cGm8gq71=gq2ELzHWBK0y7H=OEcY1=DUdsw@mail.gmail.com> (Phil
 Hord's message of "Tue, 18 Oct 2011 10:09:17 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B34B7934-F9A9-11E0-B595-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183887>

Phil Hord <phil.hord@gmail.com> writes:

> On Tue, Oct 18, 2011 at 3:50 AM, Junio C Hamano <gitster@pobox.com> w=
rote:
>> What's cooking in git.git (Oct 2011, #06; Tue, 18)
>> --------------------------------------------------
> [...]
>> * ph/transport-with-gitfile (2011-10-11) 5 commits
>> =C2=A0(merged to 'next' on 2011-10-12 at 6d58417)
>> =C2=A0+ Fix is_gitfile() for files too small or larger than PATH_MAX=
 to be a gitfile
>> =C2=A0(merged to 'next' on 2011-10-06 at 891b8b6)
>> =C2=A0+ Add test showing git-fetch groks gitfiles
>> =C2=A0+ Teach transport about the gitfile mechanism
>> =C2=A0+ Learn to handle gitfiles in enter_repo
>> =C2=A0+ enter_repo: do not modify input
>>
>> Will merge to 'master' in the fifth wave.
>
> Do you want a re-roll of this with your is_bundle() changes added in?
> I do like them better.

Hmm, you may be right. I'll try to queue an update on top of the series
and see what happens.

Thanks.
