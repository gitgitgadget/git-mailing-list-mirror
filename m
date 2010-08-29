From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: git peer-to-peer project: info needed
Date: Sun, 29 Aug 2010 17:06:54 -0500
Message-ID: <20100829220654.GH1890@burratino>
References: <AANLkTi=xLJ4w1D4=p40f8nUQfLu5hpEfNORnjroffM1v@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Sverre Rabbelier <srabbelier@gmail.com>,
	Tay Ray Chuan <rctay89@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Luke Kenneth Casson Leighton <luke.leighton@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 30 00:08:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Opq3Q-0003Ig-G2
	for gcvg-git-2@lo.gmane.org; Mon, 30 Aug 2010 00:08:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753148Ab0H2WIj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Aug 2010 18:08:39 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:65156 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750986Ab0H2WIj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Aug 2010 18:08:39 -0400
Received: by ywh1 with SMTP id 1so1446687ywh.19
        for <git@vger.kernel.org>; Sun, 29 Aug 2010 15:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=vzxWaUdKVDLGcRWqVJSPnjRWwxWcvQu9m6NFprnDSg8=;
        b=AwAKdX8TvxZeun/an/1CZnWrVObt5FAo+mIRpXiqlnysKDyr+mAElyvushCqXVV+np
         8hyLxLxM8fIC70AypU6lkMC2cAjcnDcShcoMWIkfO9oElgjRimudEn098w8+S1SLPeon
         4NZTIQT71Uo0wSMCrPe9p2GVwB8m2/2grYGWM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=ma/Whr82Yvt/CUdvm3Rncnd+mr9tXtwpVEFQ2lKi0x2Wm0wSgpA/r4Au+KcSxPOGVy
         m/mgLRi1idGAHC3b3/K04ef430YEmkFZf8b6wWLqmsJ3YL8pNltkUyBe7lxTif2OCp1V
         EkwAfunlT1FET1nJXSpgo6ThpY0mff/BBiQCQ=
Received: by 10.101.127.5 with SMTP id e5mr3656494ann.138.1283119718611;
        Sun, 29 Aug 2010 15:08:38 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id x33sm11312388ana.33.2010.08.29.15.08.37
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 29 Aug 2010 15:08:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTi=xLJ4w1D4=p40f8nUQfLu5hpEfNORnjroffM1v@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154726>

Hi Luke,

Luke Kenneth Casson Leighton wrote:

> i need some guidance on what i should be doing, to add peer-to-peer
> networking to "git fetch".  i can take care of the peer-to-peer
> networking side: the bit i'm unsure about is what sequence of events
> are required to happen.

Not sure if this is the best answer or not, but you might enjoy
looking at the git-remote-helpers(7) feature and git-remote-testgit.py
example.

Also, in case it is useful: the old scripted "git fetch" is available
as contrib/examples/git-fetch.sh.

Hope that helps,
Jonathan
