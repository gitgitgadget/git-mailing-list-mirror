From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 00/14] Officially start moving to the term 'staging
 area'
Date: Thu, 24 Oct 2013 18:19:48 -0500
Message-ID: <5269ab14157b8_6704135de7c73@nysa.notmuch>
References: <1381789769-9893-1-git-send-email-felipe.contreras@gmail.com>
 <1381789769-9893-4-git-send-email-felipe.contreras@gmail.com>
 <5261C42E.4050208@gmail.com>
 <8FC260D94D1A4711AAA8A0DE7477791B@PhilipOakley>
 <5268706B.4040303@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	William Swanson <swansontec@gmail.com>,
	Ping Yin <pkufranky@gmail.com>,
	Hilco Wijbenga <hilco.wijbenga@gmail.com>,
	Miles Bader <miles@gnu.org>
To: Karsten Blees <karsten.blees@gmail.com>,
	Philip Oakley <philipoakley@iee.org>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Oct 25 06:38:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VZZ9y-0005Cq-2M
	for gcvg-git-2@plane.gmane.org; Fri, 25 Oct 2013 06:38:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751414Ab3JYEiB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Oct 2013 00:38:01 -0400
Received: from mail-ob0-f177.google.com ([209.85.214.177]:40004 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751237Ab3JYEiA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Oct 2013 00:38:00 -0400
Received: by mail-ob0-f177.google.com with SMTP id vb8so450774obc.22
        for <git@vger.kernel.org>; Thu, 24 Oct 2013 21:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=I8nMmL3HI3R1pwuKPrtJPxiNx/1YKn/HYQXdjP0Hn3U=;
        b=azNr1RMwLdyGszxukzCg2YkBmMuvuVJbB6EDEmv7KADdqHg1ig+52na9/GnLtrzIFj
         lVPexWuZ9hApcMjenDkmDN5ZQ3G9OVOYQ09K7UGf2bIlUDQGrVxFdC6HAcj5bLP6qtbU
         Sp2z3igx6N65jLqXUKsoKxFENhueOI/nR4Wpc2vLAose+CjIk1ZhOZGe5zh/gBc6TVZc
         d0X8OGhFjpCOrtnCMBT1qS1No2RnfHDW1glQKs1vywmz6o9EawTbVjPtnBbE8eddDWj0
         zxAaYnEbLHSC8dbC3HbsEEgo4mGb+eIPzF9UbR0FjurHNuDHTxzElFXsRLHYKyIaNIld
         KMoA==
X-Received: by 10.60.63.36 with SMTP id d4mr1438819oes.29.1382675879547;
        Thu, 24 Oct 2013 21:37:59 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id rl1sm3775036oeb.7.2013.10.24.21.37.57
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Oct 2013 21:37:58 -0700 (PDT)
In-Reply-To: <5268706B.4040303@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236658>

Karsten Blees wrote:
> (2) Index
> 
> An index, as in a library, maps almost perfectly to what the git index is
> _and_ what we do with it.

Not really. An index in the context of a library, and in any other context, is
a tool that indicates where something is, in order to find it quickly.

That is not how the Git index is used, nor what it is.

> (3b) Staging area (other meanings)
> 
> I don't see how a stage (as in a theater) is in any way related to the git
> index.
> 
> Data staging (as in loading a datawarehouse or web-server) fits to some
> extent, as its also about copying information, not moving physical things.

A stage in theater, and in any other context, is a special place, a standing
place, I don't see what is so different from the git staging area.

> > Even 'native' speakers don't have a single consistent term for the
> > concept. Terms are stolen from many varied industries and activities
> > that have to prepare and package items (Ships, Trains, Theaters)
> > (see http://en.wikipedia.org/wiki/Shipping_list, for a shortish list, which doesn't mention an Index)
> 
> All true, but we don't need to steal terms from unrelated fields if
> information science provides us with the terms we need.

But it doesn't.

-- 
Felipe Contreras
