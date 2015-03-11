From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Promoting Git developers
Date: Tue, 10 Mar 2015 21:16:02 -0700
Message-ID: <xmqqd24g6uf1.fsf@gitster.dls.corp.google.com>
References: <CAP8UFD1+rC0FjisSddDcyn1E_75wtBU9pEpUcQX5zNtd4zKYFQ@mail.gmail.com>
	<54FDA6B5.8050505@drmicha.warpmail.net>
	<CAP8UFD0KNbPBB_dOzw_dAj+ws190_cO8g7_jb_V33x1jxgvnqQ@mail.gmail.com>
	<xmqqk2yo22ce.fsf@gitster.dls.corp.google.com>
	<CAEjxke-6DuTW0-ZyDtUUdCWhEtuw6x3X6LuM_Fj22QztUvFfjQ@mail.gmail.com>
	<CACsJy8CHmdSRTfspKfSqtg7VXT7D6uxqr49KQQe8dhE5popakg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Jason St. John" <jstjohn@purdue.edu>,
	Christian Couder <christian.couder@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	David Kastrup <dak@gnu.org>, git <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 11 05:16:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YVY44-0002Pk-Cg
	for gcvg-git-2@plane.gmane.org; Wed, 11 Mar 2015 05:16:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750919AbbCKEQI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Mar 2015 00:16:08 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:60296 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750774AbbCKEQH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Mar 2015 00:16:07 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9AE8740F7C;
	Wed, 11 Mar 2015 00:16:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=d8nucPbkuDW2
	8o3+N4d4YgCF6dY=; b=pyRMcpMrIhzQVHVPOBGP7nkrBXDp+CI5naIHIlExbiAf
	dZp4ROscgmkGuePR7gy4Ua1kdw0MwQojle/adfjRalFaaXyg0ShncMnguCRa9uOo
	u65xYc1waYnAd2EUECkZUmsmNvpk0zx/sxlrOFMbU4Grr4R0RQZ2rfhlfqjzdzg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=kZHZHV
	NAOQKrqG46HqkpzYQSbxxT/7wJD5Kskszlh0qPluXPvlgCMnHT49UKU5fCLfIhlh
	87vDDtpZpmzZozzsOqJVcpael5RaGrFFlmHDlx0+VXFCoY9NvwsrAqi/jXdjafCf
	5mX7OVQchaqmH62GzIWv7MzdMsNbQyE60vX9o=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8F11440F7B;
	Wed, 11 Mar 2015 00:16:05 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id ABC7640F79;
	Wed, 11 Mar 2015 00:16:04 -0400 (EDT)
In-Reply-To: <CACsJy8CHmdSRTfspKfSqtg7VXT7D6uxqr49KQQe8dhE5popakg@mail.gmail.com>
	(Duy Nguyen's message of "Wed, 11 Mar 2015 09:13:40 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 55A57028-C7A5-11E4-A587-A2259F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265297>

Duy Nguyen <pclouds@gmail.com> writes:

> ... We may want to acknowledge review efforts as well, by
> grepping Helped-by:, Reviewed-by:...

Agreed. Something along the lines of=20

    $ git shortlog --no-merges -s -n -t Helped-by -t Reviewed-by v2.3.0=
=2E.
       6  4  0  Michael Haggerty
       3  0  1  Jeff King
       3  2  1  Junio C Hamano
       1  0  0  Anders Kaseorg
       1  0  0  Ben Walton
       1  0  0  Jean-Noel Avila
       1  0  0  Michael J Gruber
       1  0  0  Michal Sojka
       1  0  0  Mikko Rapeli
       1  0  0  M=C3=A5rten Kongstad
       1  0  0  Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy
       1  0  7  Stefan Beller

that gives the number of trailer entries specified with -t in the
order specified when doing the short/abbreviated form may be a good
thing to have. The output can be piped to "sort -k" and "cut" to be
cooked in any way.

=46or completeness, in the long form, the extra numbers probably would
come next to names of the individual:

    $ git shortlog --no-merges -n -t Helped-by -t Reviewed-by v2.3.0..
    Michael Haggerty (6, 4, 0):
          write_ref_sha1(): remove check for lock =3D=3D NULL
          write_ref_sha1(): move write elision test to callers
          lock_ref_sha1_basic(): do not set force_write for missing ref=
erences
          reflog: improve and update documentation
          reflog_expire(): ignore --updateref for symbolic references
          reflog_expire(): never update a reference to null_sha1

    Jeff King (3, 0, 1):
          gettext.c: move get_preferred_languages() from http.c
          diffcore-rename: split locate_rename_dst into two functions
          diffcore-rename: avoid processing duplicate destinations
    ...

The long format needs to be careful not to drop those who helped
others without any commit under their own names.
