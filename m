From: "Carlos R. Mafra" <crmafra2@gmail.com>
Subject: Re: Request for benchmarking: x86 SHA1 code
Date: Fri, 31 Jul 2009 14:31:21 +0200
Message-ID: <20090731123121.GA4306@Pilar.aei.mpg.de>
References: <20090726232154.29594.qmail@science.horizon.com> <20090731104602.15375.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: George Spelvin <linux@horizon.com>
X-From: git-owner@vger.kernel.org Fri Jul 31 14:32:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWrHw-0001zb-KF
	for gcvg-git-2@gmane.org; Fri, 31 Jul 2009 14:32:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752627AbZGaMc3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Jul 2009 08:32:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752615AbZGaMc3
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Jul 2009 08:32:29 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:40885 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752590AbZGaMc2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Jul 2009 08:32:28 -0400
Received: by bwz19 with SMTP id 19so1161595bwz.37
        for <git@vger.kernel.org>; Fri, 31 Jul 2009 05:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=PW4xqX43w3pCNi5hGMuOg+FGYwF06GDTvCU3khhXIAc=;
        b=csB8P9U+MTcf45d3Jc+YRN0CvJokfnqRCvHNBN4cRn5wsYV2PNEfQtiAZJRb2ggMt6
         7LCU13VjnZz7tlRuVEE33TXwGTusK6emwDXSGa1gkPisLuv/Rd7SDpchVGUgjs5ZkijN
         l5N3CmdKarHcL/f93NHO+wIAXpcEr8VshCeTM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=cPi2J0tvA/r6wtK2xD/4CFdZ0p/9H7cgQr8BFIp+J4L/m2KFeUdye2XQCj1MsRBcg4
         qwrapKipPZxGC0OlM5QL5Wn+Cjhx1zG7kUClA2oDpVbn1+AEpAv+SWDBUe7SqoRa+CSD
         Q9OCK37ew/pvJbaMLY1Pw83+onlShSCUKxsiE=
Received: by 10.103.224.8 with SMTP id b8mr1469559mur.118.1249043547406;
        Fri, 31 Jul 2009 05:32:27 -0700 (PDT)
Received: from Pilar.aei.mpg.de (dynamic.aei.mpg.de [194.94.224.254])
        by mx.google.com with ESMTPS id s11sm21092394mue.11.2009.07.31.05.32.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 31 Jul 2009 05:32:26 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20090731104602.15375.qmail@science.horizon.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124554>

On Fri 31.Jul'09 at  6:46:02 -0400, George Spelvin wrote:
> - Run ./586test (before) and ./x86test (after) and note the timings.

For 8 runs in a Intel(R) Core(TM)2 Duo CPU T7250 @ 2.00GHz,

before: 1.75 +- 0.02
after: 1.62 +- 0.02
