From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-p4: missing she-bang line in t9804 confuses prove
Date: Mon, 27 Feb 2012 10:47:48 -0800
Message-ID: <7v399w9kq3.fsf@alter.siamese.dyndns.org>
References: <1330364414-29332-1-git-send-email-zbyszek@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, luke@diamand.org
To: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
X-From: git-owner@vger.kernel.org Mon Feb 27 19:47:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S25c4-0003Wy-CE
	for gcvg-git-2@plane.gmane.org; Mon, 27 Feb 2012 19:47:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754543Ab2B0Srv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Feb 2012 13:47:51 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62315 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752533Ab2B0Sru (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Feb 2012 13:47:50 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 59A6C6306;
	Mon, 27 Feb 2012 13:47:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=58TUtX7PRKuYWjlTJ473tDInOi0=; b=Bg1B7T
	P9mRRvUIhGByRFDJbIzcSPOChd7ewa56MvWKH9viu9Fz+Cn6E3HNp6l0V/2PPmdZ
	pFqqY+7/8zp5SQHc42HCuZYcLwrbJC/3/zzhvcg3SULgqoF2du1b4VLf2zqHpkAR
	cZTqEaT3Ftxsptltn9LdZS9rio9aMIbfW04nM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=G4l7XxLQG+VccpYWv6SBV0v1Y9P62TcW
	wULIFeTzk7Ofz1uPXZ7mMV5f2OlJRUoSOGoeYy4F6nLXERtbc4srOaX7mHBNiU5E
	5POX7IEOvkxHr/xhdiDAd2X/UEV6N5meV6dr6PhCb0vwqeyxVXzPOJUKvCI35h19
	hWHlJksGca8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 516BE6305;
	Mon, 27 Feb 2012 13:47:50 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D67136304; Mon, 27 Feb 2012
 13:47:49 -0500 (EST)
In-Reply-To: <1330364414-29332-1-git-send-email-zbyszek@in.waw.pl> ("Zbigniew
 =?utf-8?Q?J=C4=99drzejewski-Szmek=22's?= message of "Mon, 27 Feb 2012
 18:40:14 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8C2F8EB2-6173-11E1-97BD-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191649>

Thanks.
