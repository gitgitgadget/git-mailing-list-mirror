From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] commit: Add commit_list prefix to reduce_heads function.
Date: Sun, 05 Dec 2010 12:40:55 -0800
Message-ID: <7vtyist0ko.fsf@alter.siamese.dyndns.org>
References: <a3f4bdc2d5f5d13c772a82de9afe2691b8a12863.1291514223.git.tfransosi@gmail.com>
 <7vsjycx05o.fsf@alter.siamese.dyndns.org>
 <AANLkTikxibh4QkxzokhBYQ+dMS3W6PkDaDLuqm5qN+6v@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Thiago Farina <tfransosi@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 05 21:41:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PPLOl-0002Z5-QH
	for gcvg-git-2@lo.gmane.org; Sun, 05 Dec 2010 21:41:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756283Ab0LEUlH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Dec 2010 15:41:07 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:40068 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755238Ab0LEUlE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Dec 2010 15:41:04 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E674C38E3;
	Sun,  5 Dec 2010 15:41:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=U70u7o0EsM/yczV7PqQeX6t9BPI=; b=lQBqBu
	iJmgoINmjxLv98WWDGmzlkZZk14P3cujSlLdEYlxhHsOhQOrjlYKs/fVMGCfj4vL
	KLAd7jK3DyKjI3kd7WwQVCF2tLeK0ODG2M3+Qu4izSBdFzB7HQEB8cSnvd+4j958
	VKYplAqTiotz0ahk5CLJsvmPrcuoAeoBMcEBA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CO8qESSA+fQIcz/cByhNHie3Cef9W4Jv
	HiBdKxKvNC/2QFExDlf6n6n5ydtQGlQTFXcjjs/0bsvUU5AszyPTK+c09uhGb8so
	lafeXjT7FJey1/b2TK2Fj5tjvTgMI8YTHQVg4tkJjIukk3dPyu21cwGIznbDspaw
	63SPqYm8kUs=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C2CF738E1;
	Sun,  5 Dec 2010 15:41:22 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id AAADB38DF; Sun,  5 Dec 2010
 15:41:18 -0500 (EST)
In-Reply-To: <AANLkTikxibh4QkxzokhBYQ+dMS3W6PkDaDLuqm5qN+6v@mail.gmail.com>
 (Thiago Farina's message of "Sun\, 5 Dec 2010 10\:23\:14 -0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 057C1BBC-00B0-11E0-94AD-CDEAE6EC64FC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162962>

Thiago Farina <tfransosi@gmail.com> writes:

>> If a function takes a commit_list, named "reduce_HEADS",
>
> What? reduce_HEADS ? HEADS with CAPSLOCK?

I was just hiliting the relevant parts of the name for you.  Read it as if
it was painted in red or something.
