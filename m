Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A4B52092F
	for <e@80x24.org>; Wed, 28 Dec 2016 17:51:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751900AbcL1Ruv (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Dec 2016 12:50:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50778 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751059AbcL1Rut (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Dec 2016 12:50:49 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 07B9180F75;
        Wed, 28 Dec 2016 17:50:49 +0000 (UTC)
Received: from localhost (ovpn-116-29.gru2.redhat.com [10.97.116.29])
        by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id uBSHomRC019572;
        Wed, 28 Dec 2016 12:50:48 -0500
Date:   Wed, 28 Dec 2016 15:50:47 -0200
From:   Eduardo Habkost <ehabkost@redhat.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Paul Tan <pyokagan@gmail.com>
Subject: Re: [PATCH] am: add am.signoff add config variable
Message-ID: <20161228175047.GE3441@thinpad.lan.raisama.net>
References: <1482946838-28779-1-git-send-email-ehabkost@redhat.com>
 <CAGZ79kbRMYyaOmuqymx9dsLGdvX+iM9OMMQtQGS=uA+dO6_MVQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kbRMYyaOmuqymx9dsLGdvX+iM9OMMQtQGS=uA+dO6_MVQ@mail.gmail.com>
X-Fnord: you can see the fnord
User-Agent: Mutt/1.7.1 (2016-10-04)
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.24
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Wed, 28 Dec 2016 17:50:49 +0000 (UTC)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 28, 2016 at 09:45:24AM -0800, Stefan Beller wrote:
> On Wed, Dec 28, 2016 at 9:40 AM, Eduardo Habkost <ehabkost@redhat.com> wrote:
> > git-am has options to enable --message-id and --3way by default,
> > but no option to enable --signoff by default. Add a "am.signoff"
> > config option.
> 
> I think this is a good idea (from a design standpoint and what the user needs).
> 
> Just like e97a5e765d (git-am: add am.threeWay config variable), we'd
> prefer if you'd
> also update Documentation/config.txt as well as a new test. :)

Sorry, I was using commit e97a5e765d as reference when adding the
new option, but I was looking at "git log -p builtin/am.c" and
didn't see the rest of commit. :)

I will send a new version with the appropriate documentation and
test code.

-- 
Eduardo
