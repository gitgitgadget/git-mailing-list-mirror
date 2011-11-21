From: Junio C Hamano <gitster@pobox.com>
Subject: Re: clean bug on ignored subdirectories with no tracked files?
Date: Mon, 21 Nov 2011 11:02:10 -0800
Message-ID: <7vy5v9fgel.fsf@alter.siamese.dyndns.org>
References: <CAG+J_Dxw00e_cr7i3R9DAbTrqZvJHYk2yeUa=xGKh+Zqqmp-SA@mail.gmail.com>
 <7vy5vbj4rb.fsf@alter.siamese.dyndns.org>
 <CAG+J_DwKeWntmi22vHS6CRud6Lo0P_+D5u5ih2Bbc50ekYji5w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 21 20:02:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RSZ8I-0006uL-Ek
	for gcvg-git-2@lo.gmane.org; Mon, 21 Nov 2011 20:02:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755524Ab1KUTCP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Nov 2011 14:02:15 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45115 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755491Ab1KUTCN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Nov 2011 14:02:13 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9B3915CF4;
	Mon, 21 Nov 2011 14:02:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=K+8ymT4xjbFsn54coU04nFdFBbs=; b=slE+AD
	4XC2fG6llj/PuXUlOjpiwvcniUecxzab1/O/kqyQUrFvgBCOIOrIfvfou2d+D+bF
	R1game4tY6J4cJ05yPctM6zB/c9tdqXVs+CtPxi2k1nWDjM3JdC4T/CI06GO5d4I
	ZkQ30rLiKmLZQ81ypNfrhJLbl1zt+Revx5bnY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=q7QlaGNNiJALOwcIcIoUZ58MNVQvYYgW
	V15bFMiZZUelRpLVSMZHCyPRQA1QODB4smZL1DSVCmwPtMaL/xk/H0vZQOdXOG17
	ng+cO6AB155YoS1b4+wD9NK+zurHOinBae5o6twhZxReryM0qUCJGvMYxKZZinZK
	RDwWJJAbQIA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 92D4B5CF3;
	Mon, 21 Nov 2011 14:02:12 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2B37A5CF1; Mon, 21 Nov 2011
 14:02:12 -0500 (EST)
In-Reply-To: <CAG+J_DwKeWntmi22vHS6CRud6Lo0P_+D5u5ih2Bbc50ekYji5w@mail.gmail.com> (Jay
 Soffian's message of "Mon, 21 Nov 2011 13:51:50 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 51AC70C2-1473-11E1-B407-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185757>

Jay Soffian <jaysoffian@gmail.com> writes:

> Just because it is uninteresting to git does not mean that it isn't
> precious.

That statement is false with the versions of Git so far. See the other
thread for the current status and possible future directions.
