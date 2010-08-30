From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 01/13] fast-import: add the 'done' command
Date: Sun, 29 Aug 2010 19:30:49 -0500
Message-ID: <AANLkTik3H6hVgViAX5ur9Tq4tFQ9mJEPuTmAwcrLStvU@mail.gmail.com>
References: <1283053540-27042-1-git-send-email-srabbelier@gmail.com>
 <1283053540-27042-2-git-send-email-srabbelier@gmail.com> <20100829212419.GC1890@burratino>
 <AANLkTik_kPy8p-OTy8E7fcLFMfKFHex2ppw4Oy7BesUX@mail.gmail.com> <20100829223218.GL1890@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	David Barr <david.barr@cordelta.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 30 02:31:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OpsHM-0004m6-4c
	for gcvg-git-2@lo.gmane.org; Mon, 30 Aug 2010 02:31:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754172Ab0H3AbL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Aug 2010 20:31:11 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:43201 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753830Ab0H3AbK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Aug 2010 20:31:10 -0400
Received: by ywh1 with SMTP id 1so1472428ywh.19
        for <git@vger.kernel.org>; Sun, 29 Aug 2010 17:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=P0J1GZCC+usaWEtpABRt+N6bLPUEtnS6eZQHE6VW9Rs=;
        b=Ccg4okTD/pq2XgEGVvzCZHQBTG209cn1pTuu7fKw7xbBe+YCUeZKB/OJTwI08FlLkc
         aiypULkHO5vpvFU8cixZJmaMKiwHfFyMHtrtlonL9k4ma4ORWKARSejAg1ok/82yAgNa
         cs10gnmYMV9rddARIIZKqjrmyy/ZYLxopDPOo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=QeSpQiGJlOfoErgWVRcXb/ckDXIjLhT7Sk6drMkMN9DtOqEzxYPdAZ/EXslvWDYbi/
         oAHedPO9atyl3MbjFS1V2GakSs8pmJD2E+VWyAxNmi4okDgibT+I1GZfCvDkUYSsitKg
         UF1dfKwXNSrkJ0do1gWIZt0Th4vyvh1b6OCA4=
Received: by 10.150.52.21 with SMTP id z21mr4723707ybz.85.1283128269193; Sun,
 29 Aug 2010 17:31:09 -0700 (PDT)
Received: by 10.151.49.17 with HTTP; Sun, 29 Aug 2010 17:30:49 -0700 (PDT)
In-Reply-To: <20100829223218.GL1890@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154736>

Heya,

On Sun, Aug 29, 2010 at 17:32, Jonathan Nieder <jrnieder@gmail.com> wrote:
> where an error might go undiagnosed (and any error message drowned out
> by the summary fast-import writes at the end).
>
> Will think more.

As far as I'm concerned that should be the responsibility of the
importer. If there is an error it should make sure not to drown the
error message with it's summary. I think it does a pretty good job at
that already though, doesn't it? It even saves a log file to try and
help you diagnose what went wrong.

-- 
Cheers,

Sverre Rabbelier
