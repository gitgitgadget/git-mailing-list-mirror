Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E35B61F97F
	for <e@80x24.org>; Sun, 25 Nov 2018 08:21:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725976AbeKYTMY (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Nov 2018 14:12:24 -0500
Received: from mout.web.de ([212.227.15.14]:40913 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725880AbeKYTMY (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Nov 2018 14:12:24 -0500
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MarZy-1g6P8j0BwI-00KOZv; Sun, 25
 Nov 2018 09:21:47 +0100
Date:   Sun, 25 Nov 2018 09:21:45 +0100
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>,
        Brandon Casey <drafnel@gmail.com>
Subject: Re: What's cooking in git.git (Sep 2018, #01; Tue, 4)
Message-ID: <20181125082145.GA15747@tor.lan>
References: <20180824152016.20286-5-avarab@gmail.com>
 <xmqqmusw6gbo.fsf@gitster-ct.c.googlers.com>
 <87bm9cs5y6.fsf@evledraar.gmail.com>
 <CAPig+cRrwW662Hzp8V1sH51x8qYxPyqG=VHpOkfd-=RwUSSZbw@mail.gmail.com>
 <877ek0rymz.fsf@evledraar.gmail.com>
 <878t1i1d9q.fsf@evledraar.gmail.com>
 <20181125042835.GA24530@tor.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181125042835.GA24530@tor.lan>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Provags-ID: V03:K1:NC95Y7ErgPqUu7e2Z1TbMYOpoDOBzPCUdPkX8jMZTpNibiSpDax
 h/wcebVgvu9EXGES250uWez4jZHLIJVoYnWLfRg+wFr3UbB8AioiBrbAk2B3Ygrls8Meo4X
 N9aO62Iv4JWVaoQpL/dkEA0fC4jyMHKSoXTM0BL8wdQF6LmV513XHMFaWHuQMef+V45rJPY
 n34X5NPP+aG6eABEp2cNg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:OYyqJGUpxx0=:wXcEDRuvGET54Adxo7cxmn
 30M/27JpTS8sg0XNVHtnwgcVFHLTzf8pg0QcywdyU+TehPPKc248sPHQbI6HGYV+CfOEun2kA
 JaFiKj5+Jm08cBw/K6lCrk3Kt/QNkXDZc96pb3aN07TDzU4X5WSbs8CT0JQ6HpTp5xI4jIjTl
 BrjifWC4/TOHoO0KJy8LIhXaGMZXVGUlulRv/TPANjRu3s/1tykHu2DXjg81igwcbAayZiUu+
 /k7UW44vgmi56boWu72SACX6FdH2+Bh6JWhBfQAj3yZbe/kqL5+shro+akLDbA0qjVH5gRxR0
 w1z6wZxOlYrHcZ/grnxc6kWP52QhdK65MMijcdLheVLv5GlbqWlr0DQ8/+P7pZoLHYl9O599e
 R7OHy5Hzp30j/bG5WItQcv531WxdtKZ+tv4tjLqd0KYCrrx+88GTbwYbt9PQjnQ7eNizGUarL
 XwSPZCBK8ZcM6j0c9wABfa17RHOSwtkM/eMii4HBwcvfbxbhbvMNH+g9UWW0tdV1TtFc1nnP6
 4ZdWFOy6CWEvf8TN1UZIorCJxnuLWJHpdenfQfZvxn1wPx88NO+lDaKbrdn/hM7blqRDiGIi1
 ZiiviceQTAUU6h5o4FwZMeU+99NZEdH4wz4ln14Jrrvdqy5HP2gzhB+w+5Inrqg7SAF6EB2EX
 CAxXz2ovDky/wYdOiTrt6sywaQY9s+pT6tnrQ/M2w8LUriiqkc8M4GfBsa2aSBF4hTDY9qoGS
 UPquB8U/M7y3MQ+9zmBRLIJA6xF4h5r8PpkQCigB/a+kh62ANoR7bWjNlqk7s8J4RjVH8xC6Y
 9JGZ+qJr7IvQ0QGwQHcOl6joBUicAsbVMlxzdf5PpGc0RUpCJwHk/vY6p9AUC3v0ziEBFmsPy
 UNijqvumsYUBNWm0tKsbs+61tXyx+g9VlqqWMTo9M=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 25, 2018 at 05:28:35AM +0100, Torsten Bögershausen wrote:
> On Sat, Nov 24, 2018 at 08:33:37PM +0100, Ævar Arnfjörð Bjarmason wrote:
> > 
> > On Wed, Sep 05 2018, Ævar Arnfjörð Bjarmason wrote:
> > 
> > > On Wed, Sep 05 2018, Eric Sunshine wrote:
> 
> []
> 
> > > SunCC used to be ahead of GCC & Clang when it came to certain classes of
> > > warnings, but e.g. now everything it complains about is because it
> > > doesn't understand C as well, e.g. we have quite a few compile warnings
> > > due to code like this, which it claims is unreachable (but isn't):
> > > https://github.com/git/git/blob/v2.19.0-rc2/read-cache.c#L950-L955
> > 
> 
> Wait a second - even if the compiler claims something (wrong)...
> there a still 1+1/2 questions from my side:
> 
> 
> int verify_path(const char *path, unsigned mode)
> {
> 	char c;
> 	     ^
> 	/* Q1: should  "c" be initialized like this: */
> 	char c = *path;
>         
> 	if (has_dos_drive_prefix(path))
> 		return 0;
> 
> 	goto inside;
> 	^^^^^^^^^^^^ /* Q2: and why do we need the "goto" here ? */
> 	for (;;) {
> 		if (!c)
> 			return 1;
> 		if (is_dir_sep(c)) {
> inside:

After some re-reading,
I think that the "goto inside" was just hard to read....

Out of interest:
would the following make the compiler happy ?


diff --git a/read-cache.c b/read-cache.c
index 49add63fe1..d574d58b9d 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -951,17 +951,15 @@ static int verify_dotfile(const char *rest, unsigned mode)
 
 int verify_path(const char *path, unsigned mode)
 {
-	char c;
+	char c = *path ? '/' : '\0';
 
 	if (has_dos_drive_prefix(path))
 		return 0;
 
-	goto inside;
 	for (;;) {
 		if (!c)
 			return 1;
 		if (is_dir_sep(c)) {
-inside:
 			if (protect_hfs) {
 				if (is_hfs_dotgit(path))
 					return 0;
