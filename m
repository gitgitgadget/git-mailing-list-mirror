X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Path: news.gmane.org!not-for-mail
From: Tomas Carnecky <tomas.carnecky@gmail.com>
Newsgroups: gmane.linux.kernel,gmane.linux.scsi,gmane.linux.raid,gmane.comp.version-control.git
Subject: Re: drivers/block/cpqarray.c:938:2: error: too many arguments to
 function lk_rq_map_sg
Date: Thu, 14 Jun 2012 11:52:38 +0000
Message-ID: <1339674758-ner-4999@calvin>
References: <4fd91c3f.KAwMcygw9fFGn9Cx%wfg@linux.intel.com>
	<4FD984F3.3070502@kernel.dk> <20120614090151.GA12013@localhost>
	<4FD9A95D.40903@kernel.dk> <20120614100205.GA13217@localhost>
	<4FD9C0D2.20500@kernel.dk> <20120614113142.GA13954@localhost>
NNTP-Posting-Host: plane.gmane.org
Mime-Version: 1.0
Content-Type: text/plain
X-Trace: dough.gmane.org 1339674825 30210 80.91.229.3 (14 Jun 2012 11:53:45 GMT)
X-Complaints-To: usenet@dough.gmane.org
NNTP-Posting-Date: Thu, 14 Jun 2012 11:53:45 +0000 (UTC)
Cc: linux-scsi@vger.kernel.org, linux-raid@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	LKML <linux-kernel@vger.kernel.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Fengguang Wu <wfg@linux.intel.com>, Jens Axboe <axboe@kernel.dk>
Original-X-From: linux-kernel-owner@vger.kernel.org Thu Jun 14 13:53:43 2012
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1Sf8cG-00033K-Sy
	for glk-linux-kernel-3@plane.gmane.org; Thu, 14 Jun 2012 13:53:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755946Ab2FNLx1 (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Thu, 14 Jun 2012 07:53:27 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:36554 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755893Ab2FNLxY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jun 2012 07:53:24 -0400
Received: by mail-bk0-f46.google.com with SMTP id ji2so1374201bkc.19
        for <multiple recipients>; Thu, 14 Jun 2012 04:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:subject:to:cc:references:in-reply-to:mime-version:date
         :message-id:content-type;
        bh=hjLCcxiXotzVOGCzcExhLpoHTDexLHrI6RSUoyZdjZc=;
        b=GVZYu1vmC9A5VvDNR73B7P2kuOoaqiI0r/pqYwCIaAhlrE8zJ7VcjHcpFp18EUxW4I
         YE1lX0EKHkGZhhcUUGQzO025vdHRbzXN/z+R3wPxqN1nc7DDRGAY6tVRHVCqtG7Se87O
         un6qgYuCCVIbe1BUjFXnbF49pHKwbLa0wFpOMsTNLwF2135+jlO6rlS2K69CfsBYYZup
         QPBV5pGtMsE5iD+bs7Lds3ZQt7yZJ4l0yGHJYMNN0H0WIzKNvguSbssocIja77Ru4pQM
         aZpyAW7DgJ/tCMIoCgwVuphLWLLHzhJz376TrrituWj1RXPwXV/Lc4v0mp08HTZ/qqW1
         AINg==
Received: by 10.205.137.11 with SMTP id im11mr840002bkc.80.1339674803329;
        Thu, 14 Jun 2012 04:53:23 -0700 (PDT)
Received: from calvin.caurea.org (62-2-168-230.static.cablecom.ch. [62.2.168.230])
        by mx.google.com with ESMTPS id fu14sm6332189bkc.13.2012.06.14.04.53.21
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 14 Jun 2012 04:53:22 -0700 (PDT)
Received: by calvin.caurea.org (Postfix, from userid 3301)
	id 9657942EB11; Thu, 14 Jun 2012 11:52:38 +0000 (UTC)
In-Reply-To: <20120614113142.GA13954@localhost>
Original-Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
Old-X-Mailing-List: linux-kernel@vger.kernel.org
Xref: news.gmane.org gmane.linux.kernel:1313060 gmane.linux.scsi:75751 gmane.linux.raid:38878 gmane.comp.version-control.git:200000
Archived-At: <http://permalink.gmane.org/gmane.linux.kernel/1313060>
X-Mailing-List: git@vger.kernel.org

On Thu, 14 Jun 2012 19:31:42 +0800, Fengguang Wu <wfg@linux.intel.com> wrote:
> On Thu, Jun 14, 2012 at 12:45:38PM +0200, Jens Axboe wrote:
> > On 06/14/2012 12:02 PM, Fengguang Wu wrote:
> > > OK, I'll add a grep for "Dont-Auto-Build". If it's found in *any*
> > > commit of the branch, the build script will skip the whole branch.
> > > Does this make sense to you?
> > 
> > Yeah that'll work for me. A description or tag might be more elegant,
> > but this is easier...
> 
> Great, let's settle with the in-commit tag "Dont-Auto-Build" for now :)
> 
> "git branch --edit-description" could potentially be the most elegant
> solution, unfortunately for now there seems no way for me to retrieve
> the branch description edited by you..
> 
> Another alternative, git tag, has the problem that it goes out of sync
> every time you do rebase, which will sure happen a lot for early RFC
> patches.

Commit notes or a special namespace for branches (refs/heads/wip/...) would
also be an option.

tom

