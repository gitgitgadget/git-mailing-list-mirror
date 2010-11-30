From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv7.1 3/4 (amend v2)] gitweb: File based caching layer
 (from git.kernel.org)
Date: Mon, 29 Nov 2010 16:51:07 -0800
Message-ID: <7v4oazy6pw.fsf@alter.siamese.dyndns.org>
References: <201010311021.55917.jnareb@gmail.com>
 <7vvd3fzskv.fsf@alter.siamese.dyndns.org>
 <7vr5e3zs9u.fsf@alter.siamese.dyndns.org>
 <201011300009.05437.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	John 'Warthog9' Hawley <warthog9@kernel.org>,
	John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	Petr Baudis <pasky@ucw.cz>, admin@repo.or.cz
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 30 01:51:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNERS-0007Rv-3D
	for gcvg-git-2@lo.gmane.org; Tue, 30 Nov 2010 01:51:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755900Ab0K3Av3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Nov 2010 19:51:29 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:35663 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753453Ab0K3Av2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Nov 2010 19:51:28 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 598523B1C;
	Mon, 29 Nov 2010 19:51:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=i6klvqX/knwhDnlWMNZDTbPX0IE=; b=MMz6aW
	ykATV1NvGozNrpQtROtxWLyQNYpFc5hey1vcsumDM65I1jZLueLRMTnYRNn+974x
	IQqzneH/CGA8eLJdtLyV2b6XtxA3ZTOjzAzDS6c0R+ylIbfHn1dYk1iVpwJvsfmY
	9656kjZmPTXzNbPOPooWSLwlrkpZNc52i+BK4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=USfB0rAsTvzqPSBEimVdW94MMNBdw/tE
	L+Yk3Pp4M0LeojwgEURisOnVSIJWOYXcy5rnaALZShmesqViSQar2NzJu2x638sy
	kpzC6bLl/Zz5Sv5xK6YE03whpL+yy7zoGEhWj5k4CSzxZi9RGa4UZwQWB+gduDR2
	/jLZM3e/1dE=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D931D3B18;
	Mon, 29 Nov 2010 19:51:35 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 648053B14; Mon, 29 Nov 2010
 19:51:26 -0500 (EST)
In-Reply-To: <201011300009.05437.jnareb@gmail.com> (Jakub Narebski's message
 of "Tue\, 30 Nov 2010 00\:09\:03 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: FB83ACE4-FC1B-11DF-B01A-CDEAE6EC64FC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162456>

Jakub Narebski <jnareb@gmail.com> writes:

> On Mon, 29 Nov 2010, Junio C Hamano wrote:
>
>> Wait a bit.
>> 
>> This seems to match what I have already queued on 'pu', no?  Am I
>> hallucinating?
>  
> Damn, it looks like my mailer included wrong (older) version of a file.
> I'm sorry.  Below there is interdiff:

Thanks.  What I had was what I pulled from you.  I take it that you want
me to rebase the two tip commits on the branch?
