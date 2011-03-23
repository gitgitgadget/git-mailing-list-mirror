From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Relative ls-files
Date: Wed, 23 Mar 2011 07:09:55 -0700
Message-ID: <7v7hbqgc7g.fsf@alter.siamese.dyndns.org>
References: <AANLkTi=fP+jBpLuxst2rv02pYRmj4HOkv8Yenc-dR-N_@mail.gmail.com>
 <4D89D052.5030801@drmicha.warpmail.net>
 <AANLkTimc7gNKbh3C2hyMtFK6D1OWNALD+GvzmhG5cZrn@mail.gmail.com>
 <AANLkTimdLGgGXGRNVH5+X-cnhK2NWfWx9k0apt-6rr1Z@mail.gmail.com>
 <4D89DCBE.3060400@drmicha.warpmail.net>
 <AANLkTi=BrgZe47Bt5evr_qFzKBL=MY-6NmH22gsRurVV@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	demerphq <demerphq@gmail.com>, John Tapsell <johnflux@gmail.com>,
	Git List <git@vger.kernel.org>
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 23 15:10:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q2OlS-0006Nq-Qe
	for gcvg-git-2@lo.gmane.org; Wed, 23 Mar 2011 15:10:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752395Ab1CWOKP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Mar 2011 10:10:15 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:60532 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750721Ab1CWOKO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Mar 2011 10:10:14 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 46CE44D08;
	Wed, 23 Mar 2011 10:11:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CSglU8OfUE5vDIyHz9fvoFHAQ4U=; b=C2UB8H
	PvKJeJyIXjY+l8z+CeNW30w+a9G7xAJ4SGL2Y2Ux6Yau4hkLP8vhurlzWOY17AwC
	WLF6aoRk08jzpvwmiV+i/uhRsdZJ+xvToI8O/Q9hl8XH5/p5AAyNhkDPmyjp/xwT
	cc+DQ+S2azILbUYbQRtOp9LSnkocEGQrhv50U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Mh0+lbBPjmy5iuM7GmJruN9es9TdvPWt
	bORSoUY8Hr+1AZmRlpvZf+yfCFG2q1wKryWpfGlw+BdKVkCABgxZ/MBtEHntjy54
	PkBikC/4QObu3sxgfufVTUGUScr81S/ppyy5vyGpoQVN74ws/afcW3wo7TCqD/XB
	wh6yzCUUpIg=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E68654D04;
	Wed, 23 Mar 2011 10:11:44 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 6D0554D01; Wed, 23 Mar 2011
 10:11:38 -0400 (EDT)
In-Reply-To: <AANLkTi=BrgZe47Bt5evr_qFzKBL=MY-6NmH22gsRurVV@mail.gmail.com>
 (Martin Langhoff's message of "Wed, 23 Mar 2011 09:54:45 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7BCC67D0-5557-11E0-B8A8-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169834>

Martin Langhoff <martin.langhoff@gmail.com> writes:

> and the answer is git ls-files --with-tree=<treeish> | grep <regex> .
> But the --with-tree param is so counterintuitive to me that I read the
> manpage, everytime.

Because --with-tree nor ls-files is the tool that was designed for.

If you want to find out about a branch, why aren't you using "ls-tree -r"?
