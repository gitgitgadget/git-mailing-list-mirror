From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3] submodule deinit: require '--all' instead of '.' for all submodules
Date: Wed, 04 May 2016 14:51:32 -0700
Message-ID: <xmqqoa8lebkr.fsf@gitster.mtv.corp.google.com>
References: <1462321992-15153-1-git-send-email-sbeller@google.com>
	<1462324785-26389-1-git-send-email-sbeller@google.com>
	<xmqqlh3pft91.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kbdnKMxrp_rQp7k-G6mveNYxES4XB-+2jh2e4+_RwPeyQ@mail.gmail.com>
	<xmqqzis5ebxk.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kbLRDoAm5BaQ-OQ_OA19HBmhK3r6TWLiK1WMGGcTBVgtQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed May 04 23:51:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ay4hp-0008FY-4s
	for gcvg-git-2@plane.gmane.org; Wed, 04 May 2016 23:51:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754386AbcEDVvh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2016 17:51:37 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62179 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754371AbcEDVvg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2016 17:51:36 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id F2E9619375;
	Wed,  4 May 2016 17:51:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WEYQsRGz1JIb/w7Cj+jOrz0qqe0=; b=lJgiN2
	ItkVZjUXw3Jpv2Y9DfS0OznptjkjofH295pq9ey9KTpc3mpZrVyScA1DyaFeLkls
	QrVWuXZGtQ8m2V0K00HcANQ1CgvPjFlY94t0E0DND8ww86P0I797JdzVthXTL6dl
	yrJLgSfocPgW/VrnhVHl/aFGFRJoO0TVIk+cI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MIEZObm379cb9tgd+oNRStkeE4Dw1Fmm
	pmQCaN03+y1iqLaJ1lKTJIBHy6PtC4f3sMp5SLHCQKNRBm8Ru+Of0LfuRIBryfdl
	SGM2IeLyK1we2yqWd00RDQNneR1e7OH58grRXnrjWn3QZkqgkFDCCGTz+iYI1hEu
	6dI/h3mw7xE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id E38A119374;
	Wed,  4 May 2016 17:51:34 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6FF8019372;
	Wed,  4 May 2016 17:51:34 -0400 (EDT)
In-Reply-To: <CAGZ79kbLRDoAm5BaQ-OQ_OA19HBmhK3r6TWLiK1WMGGcTBVgtQ@mail.gmail.com>
	(Stefan Beller's message of "Wed, 4 May 2016 14:47:22 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 5E8B566A-1242-11E6-8721-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293602>

Stefan Beller <sbeller@google.com> writes:

>> I think some attempts like 06cdac5a (git-reset.txt: use "working
>> tree" consistently, 2010-09-15) were made to clean things up even
>> before "worktree" started to mean an entirely different thing, and
>> we shouldn't make things worse by adding mentions of "work tree"
>> when we mean "working tree".
>
> Ok. I'll see if I can send a similar patch like that.

Please don't churn the documentation especially when there are more
important changes in flight that deserve larger share of reviewer
bandwidth.

My review comment on the documentation part of the patch was
primarily not to make things worse when you do not have to.
