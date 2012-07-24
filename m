From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Extract Git classes from git-svn (1/10)
Date: Tue, 24 Jul 2012 18:25:15 -0500
Message-ID: <20120724232515.GC16333@burratino>
References: <5004B772.3090806@pobox.com>
 <20120717174446.GA14244@burratino>
 <5005F139.8050205@pobox.com>
 <20120717233125.GF25325@burratino>
 <7vy5mhwrdl.fsf@alter.siamese.dyndns.org>
 <500F23E4.9090306@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	robbat2@gentoo.org, Eric Wong <normalperson@yhbt.net>,
	Ben Walton <bwalton@artsci.utoronto.ca>
To: Michael G Schwern <schwern@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 25 01:25:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StoTn-0007FO-MH
	for gcvg-git-2@plane.gmane.org; Wed, 25 Jul 2012 01:25:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755304Ab2GXXZV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jul 2012 19:25:21 -0400
Received: from mail-gg0-f174.google.com ([209.85.161.174]:41824 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754997Ab2GXXZV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2012 19:25:21 -0400
Received: by gglu4 with SMTP id u4so116807ggl.19
        for <git@vger.kernel.org>; Tue, 24 Jul 2012 16:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=a05MqpEClQTepoBC0ioaTjGefLNspRxp/Jna855Zhd0=;
        b=0pMhofwNzk76CfMCPbv9Z7aFBkocJEFEol1bTa5cQpoT2Zus7JOKAI0hrOG3X+/ABt
         zliyqu1PcY3kz02qd5v2LJOIyB/A43rWawmD9tUaDPV3iRflhl+wZNs5+W1HN7j4Aioh
         BNXeLb75mR7H8dPNAV5HiV+zbxiSgQWdr/3SgIhUTJcn4iEW0H6Vh1UFqTUDOHN/xIic
         9EjY5npyhEyeKCgQaebXzdFRi/BUj9ztajVOaM3pSwuBK0DNWolQt2JUx0kIJl7sq8nw
         ksqjF6PV3H6eQT3QWDT4bqisMMH/RvURXzk7uJo/LzGSOXxBR3QnwuKox7co1Riw8bEJ
         nPSg==
Received: by 10.43.59.71 with SMTP id wn7mr19282194icb.0.1343172320227;
        Tue, 24 Jul 2012 16:25:20 -0700 (PDT)
Received: from burratino (cl-1372.chi-02.us.sixxs.net. [2001:4978:f:55b::2])
        by mx.google.com with ESMTPS id uy3sm3179648igc.14.2012.07.24.16.25.18
        (version=SSLv3 cipher=OTHER);
        Tue, 24 Jul 2012 16:25:19 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <500F23E4.9090306@pobox.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202086>

Hi,

Michael G Schwern wrote:

> But since you brought Github up... (I get the impression its kind of a dirty
> word around here)

On the contrary, one of the main contributors is employed by github,
github hosts the git website, and all in all, github has done great
work.

Many people on the git list have also interacted with projects that
went all-in on github and other online code review tools.  I imagine
experiences varied from person to person.

When I said that if you don't like emails I'd be open to other ideas
for how to review your code, I didn't mean Github's web interface. :)
It doesn't work for me.  Maybe it works better for other people.

For reference, Github pull requests wouldn't be the right
apples-to-apples comparison to make, anyway.  There are also pull
requests from time to time on this list --- see for example

 http://thread.gmane.org/gmane.comp.version-control.git/201728
 http://thread.gmane.org/gmane.comp.version-control.git/201186
 http://thread.gmane.org/gmane.comp.version-control.git/200844
 http://thread.gmane.org/gmane.comp.version-control.git/199577
 http://thread.gmane.org/gmane.comp.version-control.git/193817
 http://thread.gmane.org/gmane.comp.version-control.git/189178
 http://thread.gmane.org/gmane.comp.version-control.git/187082

Those are for code that has already been reviewed.

Hoping that clarifies,
Jonathan
