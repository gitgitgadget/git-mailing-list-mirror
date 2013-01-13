From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 00/31] nd/parse-pathspec
Date: Sun, 13 Jan 2013 15:21:10 -0800
Message-ID: <7vbocshdp5.fsf@alter.siamese.dyndns.org>
References: <1358080539-17436-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 14 00:21:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TuWrt-0005qL-Je
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jan 2013 00:21:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756189Ab3AMXVN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 13 Jan 2013 18:21:13 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35411 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755823Ab3AMXVN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 13 Jan 2013 18:21:13 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A53ECAC83;
	Sun, 13 Jan 2013 18:21:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=HRVDxSwa1Ia2
	6kGTOJ5IFRB+oWk=; b=i8QEesneIPeCi8E/S7mAK/gepYHTPar5YiuzN7mOnp/B
	aE8LIrQmqbRA0V50OP2gW83ir5tlX2ZdLMFvcJZ/kizLtjPbfHCMxxzAZNcl1Pxf
	CSBdD7lfJYE+TBbDpkxxEMOPrRobBLGFDwtqn/dZ62mQYrMK8tRuiCj9onSbEYM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=cQvlNM
	4tZhLpWY1eWv4QNnRJ0fjvIp0AtsphjcxfesBTG9KSCPzb+EHUBj1Dm9/xdOsDqg
	QjwUd3nhcSKWFp9VZas9vqSZ6ViWY37WRldf0ulcWUg2fvIALSSPKtKpUb2pWs8P
	zOv9b/peVW0o1h655ZtmwKuvqPU6/uGb7MDRo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9A998AC82;
	Sun, 13 Jan 2013 18:21:12 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 050DDAC7F; Sun, 13 Jan 2013
 18:21:11 -0500 (EST)
In-Reply-To: <1358080539-17436-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Sun, 13 Jan
 2013 19:35:08 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EB39457C-5DD7-11E2-8294-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213408>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Changes from v2 (it's hard to keep track of after the rebase, so I ma=
y
> be missing something here):
>
>  - rebased on top of recent master, incorporate changes in
>    init_pathspec from jk/pathspec-literal and nd/pathspec-wildcard to
>    parse_pathspec
>
>  - kill strip_trailing_slash_from_submodules and treat_gitlinks
>    (pretty sure it'll cause conflicts with as/check-ignore)
>
>  - kill init_pathspec, match_pathspec, diff_tree_setup_paths and
>    diff_tree_release_paths
> =20
>  - check points for future pathspec development
>
> As far as I understand the "pathspec unification", I'd say we are
> there, with a few exceptions like "mv", external commands.. But those
> are pretty much isolated.
>
> I'll send another WIP series implementing :(icase) and :(glob), mainl=
y
> to show (me) how future pathspec feature development looks like after
> this.

;-)

Thanks; looking forward to reading it.
