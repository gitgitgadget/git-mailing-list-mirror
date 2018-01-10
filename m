Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A7D2C1F404
	for <e@80x24.org>; Wed, 10 Jan 2018 16:14:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756385AbeAJQO0 convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Wed, 10 Jan 2018 11:14:26 -0500
Received: from elephants.elehost.com ([216.66.27.132]:30295 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756345AbeAJQOZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jan 2018 11:14:25 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id w0AGEIK0002679
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 10 Jan 2018 11:14:18 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Sam Millman'" <sam.millman@gmail.com>
Cc:     <git@vger.kernel.org>
References: <CALKyTE7+qJSYHQRB44HjHXK_EjOxNnCfQOROSDVVwAFR-gMnXQ@mail.gmail.com> <CALKyTE7VpeCoofzzutdEmsjtGe7NaC3EywQWJvM0EOH3U6XvoA@mail.gmail.com> <000c01d38a2b$d14c4620$73e4d260$@nexbridge.com> <CALKyTE4eqbw_kMEH9fpwFa-s-WagFn5j9OxK68YXoARm7f4zHQ@mail.gmail.com>
In-Reply-To: <CALKyTE4eqbw_kMEH9fpwFa-s-WagFn5j9OxK68YXoARm7f4zHQ@mail.gmail.com>
Subject: RE: How to use multiple SSH keys on Git exe (not bash)
Date:   Wed, 10 Jan 2018 11:14:11 -0500
Message-ID: <000d01d38a2e$10559810$3100c830$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQFzCLrCGGicWqGvpjV838qgPZ2fEwIRwFhoAeWzpPkCTktOfKP8G1wg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On January 10, 2018 11:01 AM Sam Millman wrote:
> That would mean I would need to change the case for a letter everytime I
> have a repo with a new key, that would mean I would be restricted to
> 12 client repos at a time :\, seems very hacky to me
> 
> On 10 January 2018 at 15:58, Randall S. Becker <rsbecker@nexbridge.com>
> wrote:
> > The ~/.ssh/config file is case sensitive by definition when it comes to Host
> and HostName. Try bitbucket.org for one and Bitbucket.org for another. You
> will have to change the remote URL accordingly to pick up the correct
> identity.

The combinatorics of it is Sum i=1 to n.(i) = 78.

You can also use BUtbucket.org, bUTbucket.org, etc., BUTbucket.org, etc., etc.

Hacky, maybe, but it has worked that way for a long time. Why do you need more than 78 identities? Bitbucket allows you to be on multiple projects with the same identity.

