Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 304121FF76
	for <e@80x24.org>; Wed, 14 Dec 2016 11:40:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755270AbcLNLkO convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Wed, 14 Dec 2016 06:40:14 -0500
Received: from elephants.elehost.com ([216.66.27.132]:38511 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754814AbcLNLkN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Dec 2016 06:40:13 -0500
X-Greylist: delayed 2552 seconds by postgrey-1.27 at vger.kernel.org; Wed, 14 Dec 2016 06:40:13 EST
X-Virus-Scanned: amavisd-new at elehost.com
Received: from pangea (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.238.43.115])
        (authenticated bits=0)
        by elephants.elehost.com (8.14.9/8.14.9) with ESMTP id uBEAvD86062626
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 14 Dec 2016 05:57:33 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'essam Ganadily'" <doctoresam@gmail.com>, <git@vger.kernel.org>
References: <CADo08-pBPVShFDSbOuk-12KUQL7t7ajG17-A6=UCrUVk+hcNtA@mail.gmail.com>
In-Reply-To: <CADo08-pBPVShFDSbOuk-12KUQL7t7ajG17-A6=UCrUVk+hcNtA@mail.gmail.com>
Subject: RE: Creating remote git repository?
Date:   Wed, 14 Dec 2016 05:57:04 -0500
Message-ID: <000801d255f8$df3af8c0$9db0ea40$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJGdf63aiaZxMwxejv7ebV4xx5e6aAfBJcg
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On December 14, 2016 1:01 AM, essam Ganadily wrote:
> given that git is an old and mature product i wounder why there is no
> command line (git.exe in windows) way of creating a remote git repository?
> 
> "git remote create repo myreponame"

Why not run the commands mkdir myreponame; cd myreponame; git init .... under an SSH command on the destination host. That should get you what you want.
Cheers,
Randall

-- Brief whoami: NonStop&UNIX developer since approximately UNIX(421664400)/NonStop(211288444200000000)
-- In my real life, I talk too much.



