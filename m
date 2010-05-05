From: David Michael Barr <david.barr@cordelta.com>
Subject: Re: [GSoC update] git-remote-svn: Week 1
Date: Thu, 6 May 2010 06:56:09 +1000
Message-ID: <90AEA593-35CC-403E-8918-94DB45BC0E06@cordelta.com>
References: <g2zf3271551005050559v2ea99346gcc59f941d634ce1a@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Git Mailing List <git@vger.kernel.org>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 05 22:57:05 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O9leM-0002tn-5G
	for gcvg-git-2@lo.gmane.org; Wed, 05 May 2010 22:56:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758032Ab0EEU4Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 May 2010 16:56:24 -0400
Received: from mail-ww0-f46.google.com ([74.125.82.46]:37100 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754650Ab0EEU4W convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 May 2010 16:56:22 -0400
Received: by wwb34 with SMTP id 34so200472wwb.19
        for <git@vger.kernel.org>; Wed, 05 May 2010 13:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:subject:mime-version
         :content-type:from:in-reply-to:date:cc:content-transfer-encoding
         :message-id:references:to:x-mailer;
        bh=WmyzualLsWKrqWtoLszT3MM10uYaCPRnEsOe8gcUQjM=;
        b=dzGEeah5GQnmGBl5X0WpWLUUDikUsk5nK7tyWh95pvrYif31vHgmDbI+Ylpf/wXKhC
         0L52sh5TZGfxkqfn7AX1pRHeCNZr+UXz/bcbacjfNCvVb2GrjFO+rS/YmU8aTWfpD3nl
         NsgLk3FEDt/SJxHg9lSx3v/5sfIF/lJat3fl4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:subject:mime-version:content-type:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to:x-mailer;
        b=I48zaQ3WOyQVbTJGBFskpPwX1gwuAcNHB2IL3yGnhYtrq8XB8OuKUmhNAma4Kb4/t+
         vOOGUWLN6R8WFcFyPXvXh5MbC02TdFvnODuHQNpYdSwVs3K14kBTUfeiGRSFaH/CHYPZ
         IBg5miONiSu9w0UULQlnJjiA0M8NU0WQnF670=
Received: by 10.227.153.19 with SMTP id i19mr3192667wbw.97.1273092980149;
        Wed, 05 May 2010 13:56:20 -0700 (PDT)
Received: from [192.168.1.2] (d122-109-106-179.mit3.act.optusnet.com.au [122.109.106.179])
        by mx.google.com with ESMTPS id r29sm1477734wbv.21.2010.05.05.13.56.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 05 May 2010 13:56:18 -0700 (PDT)
In-Reply-To: <g2zf3271551005050559v2ea99346gcc59f941d634ce1a@mail.gmail.com>
X-Mailer: Apple Mail (2.1078)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146417>

Hi Ram,

A quick update. I've begun work on a reference exporter written in perl.
I believe I introduced some regressions during code cleanup.
From memory, the svn-dump-fast-export_0.8 tag has been verified for
10,000 revisions of my repository.
My perl implementation works just fine until it reaches around 11,000
revisions at which point there's a memory explosion.

-- David

On 05/05/2010, at 10:59 PM, Ramkumar Ramachandra wrote:

> Hi,
> 
> I'm sorry that this comes a couple of days late owing to the fact that
> I flew down the Copenhagen just a couple of days ago, and am coping
> with the jetlag. I've just started working, and I'm currently
> investigating David's SVN exporter. Hopefully, after I've moved into
> an apartment, I'll have something concrete to show next week.
> 
> -- Ram
