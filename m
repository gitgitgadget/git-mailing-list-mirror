From: Kevin Ballard <kevin@sb.org>
Subject: Re: [RFC PATCH 1/3] add test for git grep --recursive
Date: Wed, 29 Sep 2010 14:34:21 -0700
Message-ID: <E2FEFF76-77DF-4DA3-AFC1-914417581A81@sb.org>
References: <1285792134-26339-1-git-send-email-judge.packham@gmail.com> <1285792134-26339-2-git-send-email-judge.packham@gmail.com> <AANLkTikAUe=YWHcgF33aNFHesuxHtgCTXNZmbRoV99c-@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Chris Packham <judge.packham@gmail.com>, Jens.Lehmann@web.de,
	git@vger.kernel.org
To: =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 29 23:34:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P14II-0007L0-BF
	for gcvg-git-2@lo.gmane.org; Wed, 29 Sep 2010 23:34:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754976Ab0I2VeZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 Sep 2010 17:34:25 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:39256 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752042Ab0I2VeY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Sep 2010 17:34:24 -0400
Received: by pwj5 with SMTP id 5so88607pwj.19
        for <git@vger.kernel.org>; Wed, 29 Sep 2010 14:34:24 -0700 (PDT)
Received: by 10.114.92.17 with SMTP id p17mr2719528wab.91.1285796064239;
        Wed, 29 Sep 2010 14:34:24 -0700 (PDT)
Received: from [10.8.0.89] ([69.170.160.74])
        by mx.google.com with ESMTPS id x9sm15266001waj.3.2010.09.29.14.34.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 29 Sep 2010 14:34:22 -0700 (PDT)
In-Reply-To: <AANLkTikAUe=YWHcgF33aNFHesuxHtgCTXNZmbRoV99c-@mail.gmail.com>
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157607>

On Sep 29, 2010, at 1:35 PM, =C6var Arnfj=F6r=F0 Bjarmason wrote:

>> +test_expect_success 'update data in each submodule' '
>> +       for n in $(seq 1 5); do
>=20
> seq isn't portable to windows, so we usually write out "1 2 3 4 5"
> directly.

=46WIW, seq isn't even provided by default on OS X.

-Kevin Ballard