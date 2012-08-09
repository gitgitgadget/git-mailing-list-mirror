From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Please pull git-l10n updates for git v1.7.12-rc2
Date: Thu, 09 Aug 2012 10:52:47 -0700
Message-ID: <7vsjbwnea8.fsf@alter.siamese.dyndns.org>
References: <CANYiYbGgpCsuynqTh5UoQ=AWKxGiFG726thzMFqg19Vc9kpi+w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ralf Thielow <ralf.thielow@googlemail.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Jan =?utf-8?Q?Kr=C3=BCger?= <jk@jk.gs>,
	Christian Stimming <stimming@tuhh.de>,
	Peter Krefting <peter@softwolves.pp.se>,
	=?utf-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
	Riku <lu.riku@gmail.com>, Zhuang Ya <zhuangya@me.com>,
	Lian Cheng <rhythm.mail@gmail.com>,
	Yichao Yu <yyc1992@gmail.com>,
	ws3389 <willsmith3389@gmail.com>, Thynson <lanxingcan@gmail.com>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 09 19:52:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SzWun-0008Oe-Dg
	for gcvg-git-2@plane.gmane.org; Thu, 09 Aug 2012 19:52:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751447Ab2HIRww (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Aug 2012 13:52:52 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62904 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750876Ab2HIRwv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Aug 2012 13:52:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 53035820C;
	Thu,  9 Aug 2012 13:52:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vhS3J+erj340JQ098HsFKhsETc0=; b=ZyTv7D
	o/j/FUTy9TFqZ5x8dDyNW6t+LwVplOgkt00t+CwBQaH5RaU06qYmwgsssaRLUwLh
	W8Z4QTrqfiLqghDlcHK7pcciabH3cMRBB49v/v4Seh69nknRAGuz1IYq13Hi2XHq
	AFH+Wi8SR12+frknMTdeeyJXq6u3Ddgp4rdWQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nAOzpK2KjaSIc6NbN2D78LbArrtfLSKD
	CB0jK2pwQvRzMntGFDF+RaxP653cBGVclralncZTnTR6Zj9QdqOtuwGxNF7IHYPK
	MsP7Sd8NJjYnNMtk1Hu9J2uoxItDuyaxrw7DId2I/PaBKpreEyCXd1sOSY9Ua6vy
	yfyjWxAnqJw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3EBB9820B;
	Thu,  9 Aug 2012 13:52:50 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A9D798209; Thu,  9 Aug 2012
 13:52:49 -0400 (EDT)
In-Reply-To: <CANYiYbGgpCsuynqTh5UoQ=AWKxGiFG726thzMFqg19Vc9kpi+w@mail.gmail.com> (Jiang
 Xin's message of "Thu, 9 Aug 2012 15:43:18 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 08E27CE6-E24B-11E1-8626-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203173>

Jiang Xin <worldhello.net@gmail.com> writes:

> Hi Junio,
>
> The following changes since commit bfbf4d477a33be413800f531c3ac0d227f46ab44:
>
>   Merge git://github.com/git-l10n/git-po (2012-08-05 20:51:05 -0700)
>
> are available in the git repository at:
>
>
>   git://github.com/git-l10n/git-po master
>
> for you to fetch changes up to cc2f50dafe28fda6652e1ab78034aae49b495b08:
>
>   l10n: Update Swedish translation (1168t0f0u) (2012-08-09 06:39:17 +0100)

Thanks, done.
