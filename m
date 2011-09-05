From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: git push output goes into stderr
Date: Mon, 5 Sep 2011 10:09:30 +0530
Message-ID: <CAMK1S_hDCot2TgmoQ-MXivKP6+1=QUi=Pno3-pOZ=FhooN9Duw@mail.gmail.com>
References: <CAPgpnMQuck_aPU0ciaGgj-C8rno7jbzZ7wZ4unU8CqA0eaiYQw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Lynn Lin <lynn.xin.lin@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 05 06:39:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R0QyB-0001R0-Hi
	for gcvg-git-2@lo.gmane.org; Mon, 05 Sep 2011 06:39:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751570Ab1IEEjd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Sep 2011 00:39:33 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:41463 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750995Ab1IEEjb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Sep 2011 00:39:31 -0400
Received: by vws1 with SMTP id 1so3673742vws.19
        for <git@vger.kernel.org>; Sun, 04 Sep 2011 21:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=kXHnLuRMHeR9PEP8sY4DvuqSK8WH94w584UGwiFniU4=;
        b=JZTssrg2ikZYqcy0ur0BJqZHC+wyDJ4jrmATSUUSSsobB2h3L8U8Mba87IbKkvILSQ
         K0GLHNFT4XeYAaBpBxVjuxCewrkFRSyrNcSBo64o0IRq65zyVkru4mg1HLL3XpOL1rCr
         8iXq4QTSzFua9in5/yclqA6RrbMQ8+UI3J85I=
Received: by 10.52.36.211 with SMTP id s19mr3243887vdj.380.1315197570709; Sun,
 04 Sep 2011 21:39:30 -0700 (PDT)
Received: by 10.52.161.197 with HTTP; Sun, 4 Sep 2011 21:39:30 -0700 (PDT)
In-Reply-To: <CAPgpnMQuck_aPU0ciaGgj-C8rno7jbzZ7wZ4unU8CqA0eaiYQw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180716>

On Sun, Sep 4, 2011 at 2:56 PM, Lynn Lin <lynn.xin.lin@gmail.com> wrote:
> Hi all,
> When I create a local branch and then push it to remote. I find that
> the output without error goes into stderr, is this expected?

when the two sides of the conversation have an established protocol to
talk to each other and exchange data, any extraneous stuff (progress
message, tracing/debugging logs...) will confuse the protocol.
Shunting that aside to STDERR helps avoid protocol confusion.
