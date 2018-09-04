Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 87AD41F404
	for <e@80x24.org>; Tue,  4 Sep 2018 10:59:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727447AbeIDPYF (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Sep 2018 11:24:05 -0400
Received: from mout.gmx.net ([212.227.17.22]:50945 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726376AbeIDPYE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Sep 2018 11:24:04 -0400
Received: from [192.168.0.129] ([37.201.193.173]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LviG8-1fpV8i1QVQ-017R1M; Tue, 04
 Sep 2018 12:59:24 +0200
Date:   Tue, 4 Sep 2018 12:59:22 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Eric Sunshine <sunshine@sunshineco.com>
cc:     gitgitgadget@gmail.com, Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/9] tests: optionally write results as JUnit-style
 .xml
In-Reply-To: <CAPig+cTJzguROwyGgyeUt5CrpKt2kyps04QD37wa_Bt3JPwWsg@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1809041256270.71@tvgsbejvaqbjf.bet>
References: <pull.31.git.gitgitgadget@gmail.com> <2b5d6785944ed1a66f0272896a45fece8521d10f.1536009027.git.gitgitgadget@gmail.com> <CAPig+cTJzguROwyGgyeUt5CrpKt2kyps04QD37wa_Bt3JPwWsg@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:RPZ89dFdApQdryIrNTypwp1Fnm+qCl1hADORUvig8eqrAywIlY3
 Fq8T1tzOJGc8YQ7VvtE5sJZR+wuTKOohuLP1DVDsIfos4eh/lmPCXkabxVR3bfVxER0Lppi
 2+fmFIS60mginzLHvJi8h0yvpm3b1mp+Jd/XYq+O9NZ4B+MWJWHgwKWLKoFc6SH6TLn6QR4
 WVA45btvSKE4CLE1zGs4g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:kftYB6C1f98=:OK/HKVIgRMiZyXcF9nmfTN
 DzXQgBhbkk0q5bH+yMQQgeSBJShk39ouOieaFn2sLaByFHs5CHYZE6ORhU8+A+HXmo2qBZA30
 6SVct9ZvkiEUsknKIj9yODXp8fZ0IA/UhU2eFBaUyQt39ouEECq3oVKR8e80ubGVWtnvz4uuR
 HuvWsrdpLb6skFcj9BEA7NGcXd85VXDTP6NU2ojlKBEs5SvJGdCc0PW2eaziRspSxWah0ulFd
 JvNS38vneTLMk15AvUhGZw66itKmN/QaGz+d40L7CEFIZWX7q7omQXm93U/LQITfCr7tx8pde
 kFBRTO9HFiJCfKCPlxiqjW6NZuqifTJ9T0r681r5yCVQjYxk+W/hFetbqtoos8fCFckWVl/67
 DFqHJmttFuEoRGPsq5vJJykcD7FaTKKs5zAcH6DdtnKMYAiPpSMRTBWpifYZu2QkucX8nafRc
 1qPyP6ray2k1KwMAPyGNYwwfXhK06Nui3jZOpYdAsGu9Algle2m4Yxzipcpctn2G5afWZgJ+/
 nb8J1PjLk/Xj2r32UszSaIv0iH/Tjt3YNqo1ErgWlLazM71iScHlJn3J72FKqCueLUL/ewlSC
 dKpj+amyjhgpJaFmmnNBlYJktzZnvR6Et+5AngEOrX3/HGr0JvCx1vba3+ScJ4rvaUCa/k82l
 NgotE5iRZkJYZKNx7F5ImuUZWfckYyKVyIBJivytQZ8Tin+eQikv6olvoufip6xuFX7ZEd4g2
 A1zBduhtxyUKL7kNw9w7vun2ayWFh0EVz6mvWj/2nOnQqjKmyCS4BvJ4sUwJwctKlv/Mpq16O
 lQ0dLfe
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

On Mon, 3 Sep 2018, Eric Sunshine wrote:

> On Mon, Sep 3, 2018 at 5:10 PM Johannes Schindelin via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> > This will come in handy when publishing the results of Git's test suite
> > during an automated VSTS CI run.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> > diff --git a/t/test-lib.sh b/t/test-lib.sh
> > @@ -431,11 +434,24 @@ trap 'exit $?' INT
> >  test_failure_ () {
> > +       if test -n "$write_junit_xml"
> > +       then
> > +               junit_insert="<failure message=\"not ok $test_count -"
> > +               junit_insert="$junit_insert $(xml_attr_encode "$1")\">"
> > +               junit_insert="$junit_insert $(xml_attr_encode \
> > +                       "$(printf '%s\n' "$@" | sed 1d)")"
> > +               junit_insert="$junit_insert</failure>"
> 
> This is a genuine failure, so you're creating a <failure> node. Okay.
> 
> > +               write_junit_xml_testcase "$1" "      $junit_insert"
> > +       fi
> > @@ -444,11 +460,19 @@ test_failure_ () {
> >  test_known_broken_ok_ () {
> > +       if test -n "$write_junit_xml"
> > +       then
> > +               write_junit_xml_testcase "$* (breakage fixed)"
> > +       fi
> >         test_fixed=$(($test_fixed+1))
> >         say_color error "ok $test_count - $@ # TODO known breakage vanished"
> >  }
> 
> This was expected to fail but didn't, which means it probably needs
> some sort of attention. test_known_broken_ok_() prints this result in
> the 'error' color, and test_done() re-inforces that by printing a
> message, also in 'error' color:
> 
>     42 known breakage(s) vanished; please update test(s)
> 
> So, should this emit a <failure> node also, perhaps with 'type'
> attribute set to "warning" or something? (<failure type="WARNING"
> message="...">)

My primary aim is to display the test results in the web interface, see
e.g.
https://git.visualstudio.com/git/_build/results?buildId=128&view=ms.vss-test-web.test-result-details

The parser for JUnit XML (and in fact, the JUnit XML schema itself) do not
allow for such a warning. If you add a `<failure>`, then the build fails.

And we do not want the build to fail. Historically, I saw quite a couple
of "vanished" breakages depending on the platform where I ran the tests.

> > @@ -758,9 +793,58 @@ test_at_end_hook_ () {
> > +xml_attr_encode () {
> > +       # We do not translate CR to &#x0d; because BSD sed does not handle
> > +       # \r in the regex. In practice, the output should not even have any
> > +       # carriage returns.
> > +       printf '%s\n' "$@" |
> > +       sed -e 's/&/\&amp;/g' -e "s/'/\&apos;/g" -e 's/"/\&quot;/g' \
> > +               -e 's/</\&lt;/g' -e 's/>/\&gt;/g' \
> > +               -e 's/  /\&#x09;/g' -e 's/$/\&#x0a;/' -e '$s/&#x0a;$//' |
> > +       tr -d '\012\015'
> > +}
> 
> It's possible to insert a literal CR in the 'sed' expression, which
> does match correctly on BSD (and MacOS). For instance:
> 
>     CR=$(printf "\r")
>     sed -e "s/$CR/\&#x0d;/g"

Okay. But since we are talking about displaying some chunk of text, I
would rather just delete the CR here anyway.

Ciao,
Dscho
