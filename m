From: =?UTF-8?B?SmFrdWIgTmFyxJlic2tp?= <jnareb@gmail.com>
Subject: Re: [PATCH/RFC] Gitweb: Convert UTF-8 encoded file names
Date: Tue, 27 May 2014 16:18:49 +0200
Message-ID: <53849EC9.1010304@gmail.com>
References: <20140514184145.GA25699@localhost.localdomain>	<xmqqd2fghvlf.fsf@gitster.dls.corp.google.com>	<CANQwDwdh1qQkYi9sB=22wbNnb+g5qv5prCzj2aWhHBbTZhVhdg@mail.gmail.com>	<20140515050820.GA30785@localhost.localdomain>	<alpine.DEB.2.00.1405150957520.10221@ds9.cixit.se>	<20140515184808.GA7964@localhost.localdomain>	<CANQwDwe+GJ+yAYWdVfMaHq97zGXBoepCfUdLiaQD9LFoz3SiOA@mail.gmail.com>	<xmqqmweiessl.fsf@gitster.dls.corp.google.com>	<CANQwDwffdbqD96OadyECFs=6WY_t+_0b63L5yAZVQ8aXrMvHHA@mail.gmail.com>	<xmqqmweibjjo.fsf@gitster.dls.corp.google.com>	<CANQwDwe8Eb+ORiRyuq3+kKw72Jath_DGySmws1Rvt8bmuHoXVw@mail.gmail.com> <xmqq4n0pbqnc.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael Wagner <accounts@mwagner.org>,
	Peter Krefting <peter@softwolves.pp.se>,
	git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 27 16:19:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WpIDW-0007vc-Pi
	for gcvg-git-2@plane.gmane.org; Tue, 27 May 2014 16:19:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752275AbaE0OS7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 May 2014 10:18:59 -0400
Received: from mail-we0-f181.google.com ([74.125.82.181]:56488 "EHLO
	mail-we0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752154AbaE0OS6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 May 2014 10:18:58 -0400
Received: by mail-we0-f181.google.com with SMTP id w61so9456704wes.26
        for <git@vger.kernel.org>; Tue, 27 May 2014 07:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:newsgroups:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=9zY93pPd7JKYAKLLyCfAq01ut6s5nh6lSb2LIMKdg4o=;
        b=wF1CYo12mZrUtbAsEAd1oIVLww7HKJhEDBoU0qO3bukY1aiTUJ2ywHMwIo0BC0PkXN
         j3Itc9ZFmI0uW6Chq5rnR/dtM0pH3fS3lvY+6tHCTip4vSvb3Z7LfcYBfsC7j4UnmjJs
         V6Lb5lzV/wGGpLwKtSbJx8X/jHxEn5UsulafNLW6g7j2o31bWkWpcV2N2z6pY4gHVXmF
         Ls0MLvJNonUWpmzgsf/t5+a3SWdqKAzoPJcHh1S+BXj0FZPBhiLbpIyv1iuLsVAsojlP
         ap6vmoSKgy6mRpTwoDyKvwHxQLy/O5G3d3NCD0ce5rJu3b1SGnNDbi+SmKNkfBdYyzF5
         dJMg==
X-Received: by 10.194.236.169 with SMTP id uv9mr40406249wjc.46.1401200336355;
        Tue, 27 May 2014 07:18:56 -0700 (PDT)
Received: from [192.168.130.241] ([158.75.2.130])
        by mx.google.com with ESMTPSA id wo9sm35360022wjb.48.2014.05.27.07.18.54
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 27 May 2014 07:18:55 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <xmqq4n0pbqnc.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250170>

W dniu 2014-05-16 19:05, Junio C Hamano pisze:
> Jakub Nar=C4=99bski <jnareb@gmail.com> writes:
>=20
>>> Correct, but is "where does it appear" the question we are
>>> primarily interested in, wrt this breakage and its fix?
>>
>> That of course depends on how we want to test gitweb output.
>> The simplest solution, comparing with known output with perhaps
>> fragile / variable elements masked out could be done quickly...
>> but changes in output (even if they don't change functionality,
>> or don't change visible output) require regenerating test cases
>> (expected output) to test against - which might be source of
>> errors in test suite.
>=20
> I agree with your "to test it fully, we need extra dependencies",
> but my point is that it does not have to be a full "HTML-validating,
> picking the expected attribute via XPATH matching" kind of test if
> what we want is only to add a new test to protect this particular
> fix from future breakages.
>=20
> For example, I think it is sufficient to grep for 'href=3D"...%xx%xx"=
'
> in the output after preparing a sample tree with one entry to show.
> The expected substring either exists (in which case we got it
> right), or it doesn't (in which case we are showing garbage).  Of
> course that depends on the assumption that its output is not too
> heavily contaminated with volatile parts outside our control, as I
> already mentioned in the message you are responding to.
>=20
> But it all depends on "if" we wanted to add a new test ;-)

I tried to add such simple test to t9502, but instead of tests
failing with current version, the test setup fails but succeeds
(i.e. test library says that it failed, but manual examination
shows that everything is O.K.).

-- >8 --
=46rom: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH/RFC] gitweb test: Test proper encoding of non US-ASCII =
filenames in output (WIP)

This t9502 test is intended to test for proper encoding of non
US-ASCII filenames (i.e. UTF-8 filenames) in generated links (which
need some form of URI encoding) and in generated HTML (which needs
HTML encoding / escaping).

=46or now it tests only 'tree' view (though incidentally it also tests
UTF-8 in commit subject), as this was the action where reportedly
there was bug in link encoding: $t{'name'} coming from the
"git ls-tree -z ..." command via @ntries array was not marked as
UTF-8, making Perl assume that it is in internal Perl format
i.e. iso-8859-1 encoding and URI-escaping it as if it was in
iso-8859-1 encoding (e.g. "G=C3=BCtekriterien.txt" in UTF-8 is
"G=C3=83=C2=BCtekriterien.txt" if treated as iso-8859-1, and it then
encodes to "G%C3%83%C2%BCtekriterien.txt" instead of correct
"G%C3%BCtekriterien.txt").

UNFORTUNATELY test does not fail as it should, even though the issue
was not fixed... OTOH it fails in setup though it is successful.

Reported-by: Michael Wagner <accounts@mwagner.org>
Signed-off-by: Jakub Nar=C4=99bski <jnareb@gmail.com>
---
 t/t9502-gitweb-standalone-parse-output.sh |   34 +++++++++++++++++++++=
++++++++
 1 files changed, 34 insertions(+), 0 deletions(-)

diff --git a/t/t9502-gitweb-standalone-parse-output.sh b/t/t9502-gitweb=
-standalone-parse-output.sh
index 86dfee2..37246a3 100755
--- a/t/t9502-gitweb-standalone-parse-output.sh
+++ b/t/t9502-gitweb-standalone-parse-output.sh
@@ -201,4 +201,38 @@ test_expect_success 'xss checks' '
 	xss "a=3Drss&p=3Dfoo.git&f=3D$TAG"
 '
=20
+link_check () {
+	grep -F   "%3C__%C2%A3%C3%A5%C3%AB%C3%AE%C3%B1%C3%B2%C3%BB%C3%BD%C2%B=
6" \
+		gitweb.body &&
+	! grep -F "%3C__%A3%E5%EB%EE%F1%F2%FB%FD%B6" \
+		gitweb.body
+}
+
+test_expect_success 'prepare UTF-8 output tests' '
+	FILENAME=3D"<__=C2=A3=C3=A5=C3=AB=C3=AE=C3=B1=C3=B2=C3=BB=C3=BD=C2=B6=
  +;?&__>" &&
+	test_commit "Adding $FILENAME" "$FILENAME" "$FILENAME contents"
+'
+
+test_expect_success 'check URI-escaped UTF-8 filename in query-params =
link' '
+	cat >>gitweb_config.perl <<-\EOF &&
+	$feature{"pathinfo"}{"default"} =3D [0];
+	EOF
+	gitweb_run "p=3D.git;a=3Dtree" &&
+	link_check
+'
+
+test_expect_success 'check URI-escaped UTF-8 filename in path_info lin=
k' '
+	cat >>gitweb_config.perl <<-\EOF &&
+	$feature{"pathinfo"}{"default"} =3D [1];
+	EOF
+	gitweb_run "" "/.git/tree" &&
+	link_check
+'
+
+test_expect_success 'check HTML-escaped UTF-8 filename in body' '
+	gitweb_run "p=3D.git;a=3Dtree" &&
+	grep -F "&lt;__=C2=A3=C3=A5=C3=AB=C3=AE=C3=B1=C3=B2=C3=BB=C3=BD=C2=B6=
  +;?&amp;__&gt;" gitweb.body &&
+	! grep -F  "<__=C2=A3=C3=A5=C3=AB=C3=AE=C3=B1=C3=B2=C3=BB=C3=BD=C2=B6=
  +;?&__>" gitweb.body
+'
+
 test_done
--=20
1.7.1


=20
