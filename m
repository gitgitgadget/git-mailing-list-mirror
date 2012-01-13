From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] gitweb: Fix file links in "grep" search
Date: Fri, 13 Jan 2012 11:18:42 -0800
Message-ID: <7v62gfza0d.fsf@alter.siamese.dyndns.org>
References: <CA+uOhx6i-07kW8K0y3Co++2ABD=Lmaq3r4h1hN4YLskAE+hR1Q@mail.gmail.com>
 <7vhb0cqpix.fsf@alter.siamese.dyndns.org>
 <CANQwDwfnp167Uth5TLbCD6OR-Xe6JD-2vENiJVnipi1YdjnMPQ@mail.gmail.com>
 <201201052126.49087.jnareb@gmail.com>
 <CA+uOhx7QwRQJzyYBCkmVDBRCMt0i_ZqS=sfTG0VmNiVv2dVoww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Thomas Perl <th.perl@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 13 20:18:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RlmeI-0003XZ-CO
	for gcvg-git-2@lo.gmane.org; Fri, 13 Jan 2012 20:18:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758799Ab2AMTSp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jan 2012 14:18:45 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63320 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753745Ab2AMTSp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jan 2012 14:18:45 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A087455A9;
	Fri, 13 Jan 2012 14:18:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ylcEpnnw3rhw5TtcL3OLG64BBPo=; b=NOc3z1
	zoqAm23qx19nA9tk9nZ+4EwwyS0TgwugtteB8kA+oBwUctrTbnHl9sQ488Z0NT+v
	ICxiE0Cg84KxV7dP7VisnHbCtzW2sJuamKnSLU+X+zrAlXoZMrcP9sVPGlZ7dm3W
	1rucCUqbaphkuTGJDjgR9sUjL0xkGAgPO7w8U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bslHDj2VkNbm5Ho9GX1NTGu4fcQ3DhvA
	hFFCNnrQACgn7mTv9MRREGuF+Wk97M1XbFJQ7rUIVXU7rrUw1uZ9+uEijyAZ+QWR
	jr/q6POwVe9Eijcsc3kYktVOQIgNBi93vdAmb7TTPmzmc1A80XeYRywwhd4Zc2g2
	YwoO43mcd1Q=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 977AD55A8;
	Fri, 13 Jan 2012 14:18:44 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2390D55A7; Fri, 13 Jan 2012
 14:18:44 -0500 (EST)
In-Reply-To: <CA+uOhx7QwRQJzyYBCkmVDBRCMt0i_ZqS=sfTG0VmNiVv2dVoww@mail.gmail.com> (Thomas
 Perl's message of "Fri, 13 Jan 2012 15:09:27 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 68D3A62C-3E1B-11E1-9CB1-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188530>

Thomas Perl <th.perl@gmail.com> writes:

> As far as I'm concerned, the patch can be applied and fixes the bug.

Thanks.
