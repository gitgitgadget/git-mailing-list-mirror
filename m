From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] sha1_name(): accept ':directory/' to get at the cache_tree
Date: Fri, 22 Dec 2006 19:05:01 +0100
Message-ID: <200612221905.02915.jnareb@gmail.com>
References: <Pine.LNX.4.63.0612220318320.19693@wbgn013.biozentrum.uni-wuerzburg.de> <emg4qp$f8v$2@sea.gmane.org> <Pine.LNX.4.63.0612221315370.19693@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 22 19:02:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1Gxoiw-0002VG-F2
	for gcvg-git@gmane.org; Fri, 22 Dec 2006 19:02:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752573AbWLVSCX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Dec 2006 13:02:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752517AbWLVSCX
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Dec 2006 13:02:23 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:39079 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752573AbWLVSCW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Dec 2006 13:02:22 -0500
Received: by ug-out-1314.google.com with SMTP id 44so3041201uga
        for <git@vger.kernel.org>; Fri, 22 Dec 2006 10:02:21 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=TP62aT9NXPQSnSuZ5cF3qTy7zgpGHFL2bc2Bolen27j79LzjQz6LC25HQbmzI5kU+KN74ZKUffzvwZlIfwQFK/r7MBffYWE7Imsr4CxxsG1pX/A+H2odxsbp4iUYezuFyb/dbvF115h4Nm2PkVvoHzLbo2ER63mou5VpaM+nobs=
Received: by 10.67.21.11 with SMTP id y11mr1082712ugi.1166810540691;
        Fri, 22 Dec 2006 10:02:20 -0800 (PST)
Received: from host-81-190-25-107.torun.mm.pl ( [81.190.25.107])
        by mx.google.com with ESMTP id s7sm16010695uge.2006.12.22.10.02.20;
        Fri, 22 Dec 2006 10:02:20 -0800 (PST)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
User-Agent: KMail/1.9.3
In-Reply-To: <Pine.LNX.4.63.0612221315370.19693@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35191>

Johannes Schindelin wrote:

> On Fri, 22 Dec 2006, Jakub Narebski wrote:
> 
>> Junio C Hamano wrote:
>> 
>>> (2) What does this do when the index is unmerged?
>> 
>> I think it should show "git ls-files --unmerged --abbrev", perhaps...
> 
> Nah. I'd rather fail out, saying that because there are unmerged entries, 
> there is no valid tree in the index.

Well, 'git diff' on unmerged IIRC does 'git diff -cc', so why not 'git show :'
do 'git ls-files --unmerged --abbrev'...
-- 
Jakub Narebski
Poland
