Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA97A1F453
	for <e@80x24.org>; Fri, 18 Jan 2019 11:49:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727271AbfARLt3 (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Jan 2019 06:49:29 -0500
Received: from mout.gmx.net ([212.227.17.20]:44165 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727177AbfARLt3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jan 2019 06:49:29 -0500
Received: from [10.49.182.9] ([95.208.59.217]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Mh5h7-1gX2N52Efx-00MKvO; Fri, 18
 Jan 2019 12:49:26 +0100
Date:   Fri, 18 Jan 2019 12:49:10 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2 00/13] Offer to run CI/PR builds in Azure Pipelines
In-Reply-To: <xmqqk1j3m25f.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1901181246130.41@tvgsbejvaqbjf.bet>
References: <pull.31.git.gitgitgadget@gmail.com>        <pull.31.v2.git.gitgitgadget@gmail.com>        <xmqqo9biigod.fsf@gitster-ct.c.googlers.com>        <nycvar.QRO.7.76.6.1901161503121.41@tvgsbejvaqbjf.bet> <xmqqk1j3m25f.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:0qJAq9XyZ51KTQqhGKwRxCr4QU97oNZr6NwLLIzHiVB26bEeZQ6
 GZwztxT5XrU1z4Anz3yLaXoK0mB26POxEnWBlvdd+SSpO9KRVGF7e12NsvLwVmZEqiW3soE
 u0jkMz2KU7KsMzGRHhVGSnqOjuEJfDwum7s8SlI2BsZhh9lI+q976eWUL4w1H7Fa3U7DWga
 0hTS00p5vP/EW/F4DJxFw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:RwWsZEyt2lY=:vYDcf+KMpH/ClXtR+9MLDS
 IRmBr8SN2mrEALyV/JSVaTT9J16gz2DO+zDdODz+hqblKaOsD/dxqnjTdhJFLHWqCO9Z51fCw
 bIy8oKQQrubO5gSt/K5rlb91iMZ+k4EdEMd7IvDyj7IPND2Pvfp1YDvIkaMUKailu98b4lThf
 EyeVQ4wK39r6UxQY/OVNBULCWFcPAPMFV4VPEHrDGHN8Dv0yy6b+Pjn/AmPiUeEReqSoW3aeA
 Rg/np5vIV/aTGJY460avkszhgq5YHu50rLCQSWhqw85plfWImqweAHsDtD0hSy7FOa5imZBJg
 bjnTmH+PKHeMw+IlZ+Afe67FETDlmKe1aUITjdZ426kaJAhxx0+4a4baWioyDUmjjyySf0eXh
 3QySvG57poQBfoOazuTBaqXR8TTd1h3Y0q9o4y1fy4PBWNVByEzxcOW2H3f+sk/DXOpQdkWrJ
 fhqmxNQ1qISaljcS2qbrWmRIPDtYdIeFddvcCWde0FWLElmmn5Vnm1IDDu6cIpFFUhi/+f8mn
 qW4FwRatufmqSB9H7Dbakiffv4FBvGCWeL5ko1nrKfvMTopjxWGlRY6oKp83Ya0eyfBA7nIRo
 697d922krd7KQ4HcIj31iqlC53sdjIuJTgHXDGEFp1646jJ7l9HzrXrRTh3h2ZAXBB9PPGHAZ
 id3wNoWbE8F/I56garSI+tJl0rM4hZcvq0CiXq1RR/ZB4DrB0QENawlY5PY7hRdDg+LgVk+V5
 oMBui9AEAWtOBGKgOjctDGnmwoo1bWCi8akCzI7fjuvwT2MUpjJRKGXwJ0B+xureKTRCyaVse
 CPyBn1mEdO6axMoh4WfQyp9ISdKrM286rTDlp0e8v/1aecKf1VqMaGTnQKwTeGxs68qaEy2XE
 s6txHyZtJ2xFl8Znp+R5C+EtjW+QIN8KjuzJtm7pgI21icGTdiQjYSvl8urBUraVeggZE5Z7T
 n5aNqxpoM8w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 17 Jan 2019, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > ...
> > See the updated series:
> > https://public-inbox.org/git/pull.31.v3.git.gitgitgadget@gmail.com/
> 
> Thanks.
> 
> I see that you are already planning for v4, but I'll find time to
> take a look at what is posted sometime this week anyway.

Yes, v4 will ideally have only cosmetic changes apart from the
part that fixes the traces of the published failed tests:

-- snipsnap --
15:  f678b105f81e ! 15:  7b74987d72a6 tests: include detailed trace logs with --write-junit-xml upon failure
    @@ -32,6 +32,38 @@
     
         Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
     
    + diff --git a/t/helper/test-path-utils.c b/t/helper/test-path-utils.c
    + --- a/t/helper/test-path-utils.c
    + +++ b/t/helper/test-path-utils.c
    +@@
    + 		return !!res;
    + 	}
    + 
    ++	if (argc == 4 && !strcmp(argv[1], "skip-n-bytes")) {
    ++		int fd = open(argv[2], O_RDONLY), offset = atoi(argv[3]);
    ++		char buffer[65536];
    ++
    ++		if (fd < 0)
    ++			die_errno("could not open '%s'", argv[2]);
    ++		if (lseek(fd, offset, SEEK_SET) < 0)
    ++			die_errno("could not skip %d bytes", offset);
    ++		for (;;) {
    ++			ssize_t count = read(fd, buffer, sizeof(buffer));
    ++			if (count < 0)
    ++				die_errno("could not read '%s'", argv[2]);
    ++			if (!count)
    ++				break;
    ++			if (write(1, buffer, count) < 0)
    ++				die_errno("could not write to stdout");
    ++		}
    ++		close(fd);
    ++		return 0;
    ++	}
    ++
    + 	fprintf(stderr, "%s: unknown function name: %s\n", argv[0],
    + 		argv[1] ? argv[1] : "(there was none)");
    + 	return 1;
    +
      diff --git a/t/test-lib.sh b/t/test-lib.sh
      --- a/t/test-lib.sh
      +++ b/t/test-lib.sh
    @@ -42,7 +74,8 @@
     -			"$(printf '%s\n' "$@" | sed 1d)")"
     +			"$(if test -n "$GIT_TEST_TEE_OUTPUT_FILE"
     +			   then
    -+				cut -c "$GIT_TEST_TEE_OFFSET-" <"$GIT_TEST_TEE_OUTPUT_FILE"
    ++				test-tool path-utils skip-n-bytes \
    ++					"$GIT_TEST_TEE_OUTPUT_FILE" $GIT_TEST_TEE_OFFSET
     +			   else
     +				printf '%s\n' "$@" | sed 1d
     +			   fi)")"
    @@ -56,17 +89,17 @@
      	fi
      	test_failure=$(($test_failure + 1))
     @@
    - 	write_junit_xml "$(printf '%s\n' \
    - 		"    <testcase $junit_attrs>" "$@" "    </testcase>")"
    - 	junit_have_testcase=t
    -+	if test -n "$GIT_TEST_TEE_OUTPUT_FILE"
    + 	echo >&3 ""
    + 	maybe_teardown_valgrind
    + 	maybe_teardown_verbose
    ++	if test -n "$GIT_TEST_TEE_OFFSET"
     +	then
     +		GIT_TEST_TEE_OFFSET=$(test-tool path-utils file-size \
     +			"$GIT_TEST_TEE_OUTPUT_FILE")
     +	fi
      }
      
    - test_done () {
    + test_skip () {
     @@
      		date +%Y-%m-%dT%H:%M:%S)\""
      	write_junit_xml --truncate "<testsuites>" "  <testsuite $junit_attrs>"
    @@ -74,7 +107,6 @@
     +	if test -n "$GIT_TEST_TEE_OUTPUT_FILE"
     +	then
     +		GIT_TEST_TEE_OFFSET=0
    -+		GIT_TEST_TEE_ERR_OFFSET=0
     +	fi
      fi
      
