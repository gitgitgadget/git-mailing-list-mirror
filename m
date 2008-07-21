From: Marek Zawirski <marek.zawirski@gmail.com>
Subject: Re: problem using jgit
Date: Mon, 21 Jul 2008 12:41:39 +0200
Message-ID: <488467E3.7000107@gmail.com>
References: <p06240809c4a9d887fda4@[192.168.1.106]>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Stephen Bannasch <stephen.bannasch@deanbrook.org>
X-From: git-owner@vger.kernel.org Mon Jul 21 12:42:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKsqr-0004JR-4E
	for gcvg-git-2@gmane.org; Mon, 21 Jul 2008 12:42:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757622AbYGUKlq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jul 2008 06:41:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756950AbYGUKlq
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jul 2008 06:41:46 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:35834 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756925AbYGUKlp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jul 2008 06:41:45 -0400
Received: by fg-out-1718.google.com with SMTP id 19so618427fgg.17
        for <git@vger.kernel.org>; Mon, 21 Jul 2008 03:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=n+39zuO/EbVOBTIYfM00woFCgbvAWmTDCIGT1rQqmrY=;
        b=oZ43LQi5PDqJuZorEc0M5n5ZzE78cX0MRZPiJEtmmEPe/r+3MuyvV8URzJnO1L3STk
         H9EkdzANZDISxFbT4fzgimgr+KRDwe3BwhP78oHw3XSQ5sCsudzXeMMUCYVLuEyLsso1
         nLDxwN80+kd4gzg8cdbotBVVXjKuBdtTV4PFo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=atBV7A4dtYnDplJLVHQ/xdkA8mQuSjhMiRrh7oPh4OpfQ00jQSnOQ146H1/P95Ol69
         BTg7R1ZJOG2EXsklmg1dREpQofdUuTs1NzwRwXzLC4hGM+Sv9ChHK3LrDiG4SA+pVdcH
         5bV6ZGYNvKOq6/riEc7X0HK3M3Ba+bkmBJVo4=
Received: by 10.86.29.19 with SMTP id c19mr4716868fgc.28.1216636903706;
        Mon, 21 Jul 2008 03:41:43 -0700 (PDT)
Received: from ?192.168.1.167? ( [150.254.6.130])
        by mx.google.com with ESMTPS id l19sm1128157fgb.7.2008.07.21.03.41.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 21 Jul 2008 03:41:41 -0700 (PDT)
User-Agent: Mozilla-Thunderbird 2.0.0.14 (X11/20080509)
In-Reply-To: <p06240809c4a9d887fda4@[192.168.1.106]>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89337>

Stephen Bannasch wrote:
> I've setup a simple test class that integrates jgit to clone a git 
> repository. However I'm getting a NullPointerError when 
> RevWalk.parseAny ends up producing a null object id.
>
> The code and the stack trace for the error are here:
>
>   http://pastie.org/237711
>
> This problem occurs using the jgit from the master branch from this repo:
>
>   git://repo.or.cz/egit.git
Hello Stephen,

I think you've experienced error caused by the same bug as me, during my 
latest fetch/push GUI works few days ago.
Your code looks fine, probably  it's actually bug in jgit. I think it's 
some regression. Thanks for reporting.
I'll try to look at this problem or jgit fetch experts (Robin and Shawn) 
will have a look when they come back. 

Marek
