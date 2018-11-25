Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F9831F97E
	for <e@80x24.org>; Sun, 25 Nov 2018 04:28:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727175AbeKYPSw (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Nov 2018 10:18:52 -0500
Received: from mout.web.de ([212.227.15.14]:45367 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726828AbeKYPSw (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Nov 2018 10:18:52 -0500
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LudLU-1fRLfx1D2u-00zkzF; Sun, 25
 Nov 2018 05:28:37 +0100
Date:   Sun, 25 Nov 2018 05:28:35 +0100
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>,
        Brandon Casey <drafnel@gmail.com>
Subject: Re: What's cooking in git.git (Sep 2018, #01; Tue, 4)
Message-ID: <20181125042835.GA24530@tor.lan>
References: <20180824152016.20286-5-avarab@gmail.com>
 <xmqqmusw6gbo.fsf@gitster-ct.c.googlers.com>
 <87bm9cs5y6.fsf@evledraar.gmail.com>
 <CAPig+cRrwW662Hzp8V1sH51x8qYxPyqG=VHpOkfd-=RwUSSZbw@mail.gmail.com>
 <877ek0rymz.fsf@evledraar.gmail.com>
 <878t1i1d9q.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <878t1i1d9q.fsf@evledraar.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Provags-ID: V03:K1:FHLpiBwHDBfshzmgz3Uoq7+e9qlbS683gplzNEUqfeYW1ih1z0O
 9sYoCJ/E/ZYu0gPwtMBv7UjPD6aeawdB/7yxAY2fwf5liVV73FMXjWJ5AN+COz4SCauMY4T
 gBvyL0V/bgMX6Zn3lD2Wk0g4wyml8vjd/4Zl6mOQGhoJqwFfmz7ScTci65cZ8fJ56/b4liy
 MXhlM3eswWsrgjwbwZ4nw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:oemm7QheOsc=:afGyzYSeeXxHBqhg5HjS8d
 VlQJ5McvPoPCTlJQKCs/BK99ZHmqVGPLXPml2ZW4sVx4+L+2EDATvAtBHqqg5nErGmlH4IHNj
 A5cQwplbI6c7Qu0Z+hBVHzI1KJNREZ9fDL6xSd+mS6Yl9ZMOqFIdhFgowRee5c4sTCYJuDT84
 TsEW9QabcsDgkRgoyUgGLzXYGGydUvQmo1xmiOD/DmQd6fqHpoHdkpfWgR1RvjRjySZ0UdP+T
 qtaZf0xpnGlfqFGHwOTGd1XfSULgQ/v5ujk04QDzlmWotIt4l3m7krUWRwvZtO7rrc23LbJr5
 x6sm821U/OvEUfXeTWoadIKnyt2ykqB0MN6vb51pOZ3xYX5qZ1oZfzp3+rVDPi7IjtLWiJQNb
 /0HO8Mk+CHPN66aaTGxK2v118wxnNvNRPNXACqzU44zdZauQ8n642+0Y+7GS5gwDzOP3BXrRt
 qRsdUI1DiqVHyPVMgfyeF3HE65W29mwWCaVeL4O8BHx4DPrtQ6NqsGZ/eAwScCKGLhVwNdROv
 2Jfev6viliLMwPjknq+u+f9iPSNo986QMw7ThCnFDpTKRj8Tceral1/usuEOvzYrYkrx+rLgE
 VEyStd++A87ueuKPQdxAxAnSACrS3u/9JCa4Bc+ATBZr7UYLU6LdxYdIBrmmShDyjShsB7GzA
 UvrZQ4kKIwalLSI9vFlBjwAgfDIpbye8eF1YvvAJka1NVArOycwTqpdwQWeK0xjNTkatk7ZWc
 dC9b7ITbpUHgd65UomQan3J9s1AOlJcjUwYGkvFHuvoJBNONnvkJXP2YCrlEKahEJLv+86tOL
 gX288PX/0o6Vnr0a7pMyVbLocOMXDIV/SlW66f9GbXt3tjXsRCADzt1zOA1hW4/9vKV0PJqT/
 Zznf+rHuy1fc5EDtD++Q+up2CMmjkSnzPYYW3ptq4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 24, 2018 at 08:33:37PM +0100, Ævar Arnfjörð Bjarmason wrote:
> 
> On Wed, Sep 05 2018, Ævar Arnfjörð Bjarmason wrote:
> 
> > On Wed, Sep 05 2018, Eric Sunshine wrote:

[]

> > SunCC used to be ahead of GCC & Clang when it came to certain classes of
> > warnings, but e.g. now everything it complains about is because it
> > doesn't understand C as well, e.g. we have quite a few compile warnings
> > due to code like this, which it claims is unreachable (but isn't):
> > https://github.com/git/git/blob/v2.19.0-rc2/read-cache.c#L950-L955
> 

Wait a second - even if the compiler claims something (wrong)...
there a still 1+1/2 questions from my side:


int verify_path(const char *path, unsigned mode)
{
	char c;
	     ^
	/* Q1: should  "c" be initialized like this: */
	char c = *path;
        
	if (has_dos_drive_prefix(path))
		return 0;

	goto inside;
	^^^^^^^^^^^^ /* Q2: and why do we need the "goto" here ? */
	for (;;) {
		if (!c)
			return 1;
		if (is_dir_sep(c)) {
inside:
