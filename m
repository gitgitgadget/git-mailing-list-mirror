Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 34D341F858
	for <e@80x24.org>; Mon, 14 Nov 2016 16:22:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754170AbcKNQW0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Nov 2016 11:22:26 -0500
Received: from mailhub.007spb.ru ([84.204.203.130]:39592 "EHLO
        mailhub.007spb.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752316AbcKNQWZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Nov 2016 11:22:25 -0500
Received: from tigra.domain007.com (tigra.domain007.com [192.168.2.102])
        by mailhub.007spb.ru (8.14.4/8.14.4/Debian-4+deb7u1) with SMTP id uAEGMKcx018141;
        Mon, 14 Nov 2016 19:22:21 +0300
Date:   Mon, 14 Nov 2016 19:22:20 +0300
From:   Konstantin Khomoutov <kostix+git@007spb.ru>
To:     Robert Fellendorf <robert.fellendorf@googlemail.com>
Cc:     git@vger.kernel.org
Subject: Re: GIT Problem/ISSUE
Message-Id: <20161114192220.e6f794d90314066591d3a962@domain007.com>
In-Reply-To: <a3751faa-91b5-2ce8-767a-a25e25f23433@googlemail.com>
References: <a3751faa-91b5-2ce8-767a-a25e25f23433@googlemail.com>
X-Mailer: Sylpheed 3.5.0beta1 (GTK+ 2.24.25; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.51 (www.roaringpenguin.com/mimedefang) on 192.168.2.20
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 14 Nov 2016 16:59:41 +0100
Robert Fellendorf <robert.fellendorf@googlemail.com> wrote:

[...]
> Couldn't resolve host 'gitlab.lrz.de'
[...]

So, what happens when you open a console prompt (Click the Start menu
icon, type "cmd" without the double quotes and activate the application
found), type

  ping gitlab.lrz.de

there and hit the Enter key?

Does it successfully sends three network packets or you do get the
same/similar error message about the hostname "gitlab.lrz.de" being not
resolvable?

As it stands, this issue looks completely unrelated to Git -- please
read the Wikipedia page on the Domain Name System (DNS) for a start.
