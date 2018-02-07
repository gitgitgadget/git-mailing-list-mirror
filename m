Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C67191F404
	for <e@80x24.org>; Wed,  7 Feb 2018 17:15:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754377AbeBGRPS (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Feb 2018 12:15:18 -0500
Received: from elephants.elehost.com ([216.66.27.132]:59080 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753390AbeBGRPR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Feb 2018 12:15:17 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id w17HF5lK067196
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 7 Feb 2018 12:15:05 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Andreas Schwab'" <schwab@linux-m68k.org>
Cc:     "'Jonathan Nieder'" <jrnieder@gmail.com>,
        "'Salvatore Bonaccorso'" <carnil@debian.org>,
        <889680@bugs.debian.org>, <git@vger.kernel.org>
References: <151785928011.30076.5964248840190566119.reportbug@eldamar.local>    <20180205204312.GB104086@aiede.svl.corp.google.com>     <00b601d39f9d$7a40b820$6ec22860$@nexbridge.com> <871shwpwrm.fsf@linux-m68k.org>
In-Reply-To: <871shwpwrm.fsf@linux-m68k.org>
Subject: RE: git: CVE-2018-1000021: client prints server sent ANSI escape codes to the terminal, allowing for unverified messages to potentially execute arbitrary commands
Date:   Wed, 7 Feb 2018 12:15:00 -0500
Message-ID: <001f01d3a037$3296deb0$97c49c10$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQKV3ZfFIFJAb10h2veIue2qrUCm7wI76Kt+AcIxEegBMg5L/6HrMO1w
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On February 7, 2018 11:53 AM, Andreas Schwab wrote:
> On Feb 06 2018, "Randall S. Becker" <rsbecker@nexbridge.com> wrote:
> 
> > What I don't know - and it's not explicitly in the CVE - is just how
> > many other terminal types with similar vulnerabilities are out there,
> > but I'm suspecting it's larger than one would guess - mostly, it seems
> > like this particular sequence is intended to be used for writing
> > status line output (line 25?) instead of sticking it in a prompt. This
> > can be used prettifies a lengthy bash prompt to display the current
> > branch and repository at the bottom of the screen instead of in the
> > inline prompt, but that's the user's choice and not something git has
> > to deal with. There were some green-screen terminals with other weird
> > ESC sequences back in the day that could really get into trouble with
> > this, including loading/executing programs in terminal memory via
> > output - really. I'm sure it seemed like a good idea at the time, but I
can see
> how it could have been used for evil.
> 
> Do you also want to block "+++AT"?  :-)

Oh dear. Oh dear. You *do* know that actually could be bad. I wonder how
many git users are still using dial-up to clone/push. Of course, they would
probably not even see this message after trying to download it.

Chuckles,
Randall

-- Brief whoami:
 NonStop developer since approximately 211288444200000000
 UNIX developer since approximately 421664400
-- In my real life, I talk too much.



