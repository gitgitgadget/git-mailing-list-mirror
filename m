Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1FCFC1FF32
	for <e@80x24.org>; Fri, 13 Oct 2017 10:06:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753348AbdJMKGI (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Oct 2017 06:06:08 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:32914 "EHLO
        glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751480AbdJMKGH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Oct 2017 06:06:07 -0400
Received: from glandium by mitsuha.glandium.org with local (Exim 4.89)
        (envelope-from <mh@glandium.org>)
        id 1e2wqx-0002iE-Sv; Fri, 13 Oct 2017 19:06:03 +0900
Date:   Fri, 13 Oct 2017 19:06:03 +0900
From:   Mike Hommey <mh@glandium.org>
To:     Constantine <hi-angel@yandex.ru>
Cc:     git@vger.kernel.org
Subject: Re: git-clone causes out of memory
Message-ID: <20171013100603.5eed26sjjigph2il@glandium.org>
References: <515b1400-4053-70b0-18e2-1f61ebc3b2d7@yandex.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <515b1400-4053-70b0-18e2-1f61ebc3b2d7@yandex.ru>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 13, 2017 at 12:51:58PM +0300, Constantine wrote:
> There's a gitbomb on github. It is undoubtedly creative and funny, but since
> this is a bug in git, I thought it'd be nice to report. The command:
> 
> 	$ git clone https://github.com/x0rz/ShadowBrokersFiles

What fills memory is actually the checkout part of the command. git
clone -n doesn't fail.

Credit should go where it's due: https://kate.io/blog/git-bomb/
(with the bonus that it comes with explanations)

Mike
