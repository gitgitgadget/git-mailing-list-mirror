From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/8] revert: decouple sequencer actions from builtin
 commands
Date: Wed, 11 Jan 2012 10:47:58 -0600
Message-ID: <20120111164758.GD1891@burratino>
References: <1326025653-11922-1-git-send-email-artagnon@gmail.com>
 <1326212039-13806-1-git-send-email-artagnon@gmail.com>
 <1326212039-13806-3-git-send-email-artagnon@gmail.com>
 <20120110183857.GC22184@burratino>
 <CALkWK0k=44znLr2oYSx61Mk=qdAurona0f0H4i4=YXNSAeQhHQ@mail.gmail.com>
 <CALkWK0=bEPPv4rtPrMrQnk3MK=JY4-wwAByWPmzg86NBm_56iQ@mail.gmail.com>
 <20120111050404.GA13507@burratino>
 <CALkWK0kJpEXvBMV=D7h91sz7U2sLvXdW1UzomW0kG2bbM+byYA@mail.gmail.com>
 <20120111131854.GG32173@burratino>
 <CALkWK0=gvsvqk7Th7YY_eRzb+Ri52AZbOVokC98i9BXVAJOZEw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 11 17:43:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rl1GY-0003SP-Fa
	for gcvg-git-2@lo.gmane.org; Wed, 11 Jan 2012 17:43:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757362Ab2AKQnG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jan 2012 11:43:06 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:59145 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751745Ab2AKQnE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jan 2012 11:43:04 -0500
Received: by iabz25 with SMTP id z25so1332309iab.19
        for <git@vger.kernel.org>; Wed, 11 Jan 2012 08:43:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=Wd5lcSQuea9ClViyyVRtvF2ZG4gmrau1bBloPW5GkWY=;
        b=ZRvR7rNk/KbIwVH+r6JfhuPo8gbmZUKxySPpWYg1FmcT1q/3iXSnNdIhHYfRSfAqCr
         F0B0mX3s6wWZgAThrXd7t5Fx/JaPaKJUUnb5iJ55gt80U5zD1DsFYUJiO60lVCKmaTUg
         xb4PYMZCu4CHfav4JaZaL1kU70aSoN3xwn9aU=
Received: by 10.50.87.164 with SMTP id az4mr5615231igb.27.1326300184113;
        Wed, 11 Jan 2012 08:43:04 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id l35sm7106325ibj.0.2012.01.11.08.43.03
        (version=SSLv3 cipher=OTHER);
        Wed, 11 Jan 2012 08:43:03 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CALkWK0=gvsvqk7Th7YY_eRzb+Ri52AZbOVokC98i9BXVAJOZEw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188372>

Ramkumar Ramachandra wrote:

> More than the pain of rebasing the patch everytime, I guess what I'm
> asking is: is it worth stretching my foresight like this?  Once the
> code is in sequencer.c, it just becomes so much easier for me to write
> scratch code to help me wrap my head around the generalization.

In that case, why not just a patch to move the code to sequencer.c,
with whatever is the minimum of related fixes (just namespace stuff,
I'd imagine) before it?
