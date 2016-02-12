From: Junio C Hamano <gitster@pobox.com>
Subject: Re: `.git` symlink makes `git submodule add` fail
Date: Fri, 12 Feb 2016 10:09:41 -0800
Message-ID: <xmqqio1tvlzu.fsf@gitster.mtv.corp.google.com>
References: <20160212164853.GA6888@witiko>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?VsOtdCBOb3ZvdG7DvQ==?= <witiko@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 12 19:09:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aUIAE-00040C-8A
	for gcvg-git-2@plane.gmane.org; Fri, 12 Feb 2016 19:09:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752193AbcBLSJu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 12 Feb 2016 13:09:50 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:52094 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751061AbcBLSJt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Feb 2016 13:09:49 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1D13C4189A;
	Fri, 12 Feb 2016 13:09:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=xRxt0DAwB35r
	Og1UZTugvqZPVyI=; b=W14YZO5PcWioE553lOj61nEszz9DudQAv0s0rhOETzgf
	OTn+1jobx2UHWWbVwIxNF5aZ27r7RZ1BLNgpDyWJ80lx+FHBbmnfMLublSHBtQbz
	XzuVIxRI6syCHT4QkkMlh786XcLlt03i/kcKSZnayx87bqj/lfKgCG+SCQcZEuY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=ENnUx3
	oq1hsCQVaeSA2E0nE3xiiaFlCOuy5Wg4KbxO0tNe+d5IreddFYzvvdhQ5qr00Q5c
	WlSJZL+9GEJyvJWvrVpOUawl4T2g8br8f9itLVvBAnIL6iwD6DKTobJgvOokXQGZ
	rRmOLvVc6rCQV4nJSDManseemZpxt7LEV+FsQ=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 010C641898;
	Fri, 12 Feb 2016 13:09:44 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 2B5A541897;
	Fri, 12 Feb 2016 13:09:43 -0500 (EST)
In-Reply-To: <20160212164853.GA6888@witiko> (=?utf-8?Q?=22V=C3=ADt_Novotn?=
 =?utf-8?Q?=C3=BD=22's?= message of "Fri,
	12 Feb 2016 17:48:54 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: CA87EF74-D1B3-11E5-AEFB-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286060>

V=C3=ADt Novotn=C3=BD <witiko@gmail.com> writes:

> Is this a bug, or is the ability to symlink `.git` just a happy coinc=
idence?

It has never been supported.
