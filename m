Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B125E1F404
	for <e@80x24.org>; Fri, 19 Jan 2018 17:59:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932540AbeASR7y (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Jan 2018 12:59:54 -0500
Received: from elephants.elehost.com ([216.66.27.132]:34327 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932166AbeASR7w (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jan 2018 12:59:52 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id w0JHx9Jl086996
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 19 Jan 2018 12:59:09 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Robert P. J. Day'" <rpjday@crashcourse.ca>,
        "'Git Mailing list'" <git@vger.kernel.org>
References: <alpine.LFD.2.21.1801191247250.10222@localhost.localdomain>
In-Reply-To: <alpine.LFD.2.21.1801191247250.10222@localhost.localdomain>
Subject: RE: should any build system legitimately change any tracked files?
Date:   Fri, 19 Jan 2018 12:59:03 -0500
Message-ID: <005b01d3914f$3441fca0$9cc5f5e0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQF5VHfSbJRjMQMrNnv/r7NOd2GRh6Qv9N1Q
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On January 19, 2018 12:52 PM, Robert P. J. Day wrote:
>   just finished teaching a couple git courses and, after class, a student
came
> up and described a rather weird problem -- in short:
> 
>   1) before build, "git diff" shows nothing
>   2) do the standard build
>   3) suddenly, "git diff" shows some changes
> 
> that's all the info i was given, but it *seems* clear that the build
process itself
> was making changes to one or more tracked files.
> 
>   technically, i guess one can design a build system to do pretty much
> anything, but is it fair to say that this is a really poor design
decision?
> admittedly, this isn't specifically a git question, but i'm open to
opinions on
> something that strikes me as a bad idea.

Depends what you're up to.  Changing the source repository content is
probably bad. Adding tags may not be. Also, updating a separate repository
to include build information (a.k.a dependency tracking between source and
object commits) can be very useful for managing production builds and
environments.

Cheers,
Randall

-- Brief whoami:
 NonStop developer since approximately 211288444200000000
 UNIX developer since approximately 421664400
-- In my real life, I talk too much.



