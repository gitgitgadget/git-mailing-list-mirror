From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Multiple remote.<...>.fetch and .push patterns
Date: Tue, 01 Jul 2008 06:04:29 -0700 (PDT)
Message-ID: <m3zlp1g3b3.fsf@localhost.localdomain>
References: <308083c30806301158i1100c84dqe7f50daad417934c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Adr3nal D0S" <adr3nald0s@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 01 15:06:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDfYR-0003yz-Uz
	for gcvg-git-2@gmane.org; Tue, 01 Jul 2008 15:05:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754158AbYGANEd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jul 2008 09:04:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753926AbYGANEd
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Jul 2008 09:04:33 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:36781 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753249AbYGANEc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jul 2008 09:04:32 -0400
Received: by ug-out-1314.google.com with SMTP id h2so393838ugf.16
        for <git@vger.kernel.org>; Tue, 01 Jul 2008 06:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=pxSV4fqQAy42sbuljCj5SLOqFKVACNQK7YqpkmyKu+U=;
        b=rWMSa8bODb6m2wLH1XCStRFGgzcu4+N5J4VJ2Ujdku1l5wEf4V+pOqrHuXyndqrLVI
         HqK8bUt8tf9tmVVvqT5tVaqzoxpr73Ee90vKhedgHh37r68807/rhDUJfgaQjamoUe+k
         Nkcq3LlM0yYKiBPcFE7JmPrzO0Imvr8ISy9Lw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=Du85TeVBho7geDAKjfS8xR7X8Z9RQe+hYJfXWC1bL3BBnln+MF1s/yQ16FdEvVOd/t
         1OOVRE9iLsdfGAqZH2p3F7JqFX2kFmQTNZibKkAGMLussNSppC5DrpVaDWoVRwnfjjEC
         HVf4HtZszHWHnHtATaPt0AA5M9N/WH35MPO/I=
Received: by 10.210.24.7 with SMTP id 7mr5289283ebx.178.1214917470360;
        Tue, 01 Jul 2008 06:04:30 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.248.226])
        by mx.google.com with ESMTPS id z40sm8305821ikz.7.2008.07.01.06.04.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 01 Jul 2008 06:04:29 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m61D8Gkm029952;
	Tue, 1 Jul 2008 15:08:16 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m61D8GJm029949;
	Tue, 1 Jul 2008 15:08:16 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <308083c30806301158i1100c84dqe7f50daad417934c@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87036>

"Adr3nal D0S" <adr3nald0s@gmail.com> writes:

> How can I do something like what is shown in Everyday git using git-config?
> 
> $ cat .git/remotes/ko
> URL: kernel.org:/pub/scm/git/git.git
> Pull: master:refs/tags/ko-master
> Pull: next:refs/tags/ko-next
> Pull: maint:refs/tags/ko-maint
> Push: master
> Push: next
> Push: +pu
> Push: maint
> 
> I know I can do:
> 
> git config remote.ko.fetch refs/heads/*:refs/tags/ko-*
> 
> but that will get all KO heads.  And I have no clue about the push version.

remote.<name>.fetch in config is equivalent of "Pull:" line in 
$GIT_DIR/remotes/<name>, while remote.<name>.push in config is
eqiovalent of "Push:" line in $GIT_DIR/remotes/<name>.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
