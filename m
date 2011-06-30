From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Undo last commit?
Date: Thu, 30 Jun 2011 13:38:30 -0500
Message-ID: <20110630183830.GA4294@elie>
References: <BANLkTinWujKYvx_fh2iBDOdMbywqzfgwUA@mail.gmail.com>
 <m31uyrutx7.fsf@localhost.localdomain>
 <20110619003718.GA5628@elie>
 <201106191237.55825.jnareb@gmail.com>
 <4DFF382A.5030206@micronengineering.it>
 <4E09DDAE.30801@ira.uka.de>
 <BANLkTimZN4swfY13zMjkCbAc9UsGSix02Q@mail.gmail.com>
 <BANLkTim459-Jx2R9GpBdkck7PMAEbamJeA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mike <xandrani@gmail.com>, Holger Hellmuth <hellmuth@ira.uka.de>,
	Massimo Manca <massimo.manca@micronengineering.it>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	Ben Walton <bwalton@artsci.utoronto.ca>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 30 20:38:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QcM8S-0005dw-Mc
	for gcvg-git-2@lo.gmane.org; Thu, 30 Jun 2011 20:38:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753451Ab1F3Sil (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Jun 2011 14:38:41 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:37247 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753431Ab1F3Sij (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jun 2011 14:38:39 -0400
Received: by vxb39 with SMTP id 39so1824390vxb.19
        for <git@vger.kernel.org>; Thu, 30 Jun 2011 11:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=JXhVfYyiGsVRSJ17IEFHV/6XsAAI+Ho2nkptNO5QLCM=;
        b=E9PzpofSR5e6PTcobz/N5NGfRMWQUfHH3OcPO79A/Rqby+t5gPK97TiZDgMWXboPxo
         5+hC6DfilrC7zHHj4CRSuWEL1rue023GvuFWoeDvjmgwkJRgjoR67YwlzwkT5qdhezXE
         ScDELLb8Bmhab0+YO82RaKvUUCOQppqP+TQKI=
Received: by 10.52.73.163 with SMTP id m3mr3431814vdv.244.1309459118043;
        Thu, 30 Jun 2011 11:38:38 -0700 (PDT)
Received: from elie (adsl-68-255-110-41.dsl.chcgil.sbcglobal.net [68.255.110.41])
        by mx.google.com with ESMTPS id z7sm949297vdg.31.2011.06.30.11.38.35
        (version=SSLv3 cipher=OTHER);
        Thu, 30 Jun 2011 11:38:36 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <BANLkTim459-Jx2R9GpBdkck7PMAEbamJeA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176499>

Ramkumar Ramachandra wrote:
> Mike writes:

>> I do think that git needs polishing in this way. It was designed by a
>> very intelligent programmer... however they can sometimes be the worst
>> at user interface design.
[...]
> Git is
> very complex, and changing one little thing requires us to think about
> how it'll affect everything else.

Oh, dear.  No, I don't think these things are true at all (or at least I
hope we act so as to make them not true).  In its history, just like Jakub
likes to remind us now and then, git _evolved_.  To make it better, it
should be sufficient to do three things:

 1. When there is a small, obvious change that can make something
    better, do it.

 2. When there is a small, obvious change that can make git simpler
    and more flexible (so other changes can become small and obvious),
    do it.

 3. When there is a big, possibly advantageous change, try it out
    locally (e.g., on a branch).  If it turns out to work well, use it.

While it is always nice to see people thinking carefully, none of the
above necessarily requires thinking about all of git at once.  In
particular, (2) suggests that any feature leading a well informed
person to say "Git is very complex" is a bug.
