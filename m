From: Timo Hirvonen <tihirvon@gmail.com>
Subject: Re: [PATCH 0/5] Rework diff options
Date: Sat, 24 Jun 2006 01:44:20 +0300
Message-ID: <20060624014420.2c3df276.tihirvon@gmail.com>
References: <20060624011538.9bb179e7.tihirvon@gmail.com>
	<Pine.LNX.4.63.0606240024460.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: junkio@cox.net, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 24 00:44:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FtuO1-000812-Bp
	for gcvg-git@gmane.org; Sat, 24 Jun 2006 00:44:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752133AbWFWWoX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Jun 2006 18:44:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752149AbWFWWoX
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jun 2006 18:44:23 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:21040 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1752133AbWFWWoW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jun 2006 18:44:22 -0400
Received: by nf-out-0910.google.com with SMTP id m19so280603nfc
        for <git@vger.kernel.org>; Fri, 23 Jun 2006 15:44:21 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=GWSo4yszFIhD8pSlU9lYNoPwbssfND0Hrh+MKtrbYjlX64tZ+etnllWsgXA51An1LSMGvLJOLMtN0aU1fDYRmfSyZx60OhEwBQKSAxNQSCgBemiuYyD/mmrqv2FGxJczB09aC41stoDethXPBGxUW3wSX5WwMrLN0kqMn6M99XY=
Received: by 10.49.81.12 with SMTP id i12mr2895476nfl;
        Fri, 23 Jun 2006 15:44:20 -0700 (PDT)
Received: from garlic.home.net ( [82.128.229.197])
        by mx.gmail.com with ESMTP id v20sm85771nfc.2006.06.23.15.44.20;
        Fri, 23 Jun 2006 15:44:20 -0700 (PDT)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0606240024460.29667@wbgn013.biozentrum.uni-wuerzburg.de>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.18; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22450>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:

> Hi,
> 
> On Sat, 24 Jun 2006, Timo Hirvonen wrote:
> 
> > This patch series cleans up diff output format options.
> 
> Very good.
> 
> Although I understand that to convert all users to the new convention, it 
> is sensible to rename the constants, I think it is not good to change 
> something as DIFF_FORMAT_RAW to OUTPUT_FMT_RAW in the resulting patch.
> 
> IMHO it is an unnecessary change, and accounts for a lot of the diffstat.

I did it because you can't have many DIFF_FORMAT_* options at the same
time but OUTPUT_FMT_* can be combined.

-- 
http://onion.dynserv.net/~timo/
