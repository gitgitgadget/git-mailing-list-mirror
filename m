From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: Notes on Using Git with Subprojects
Date: Tue, 26 Sep 2006 15:45:51 -0700
Message-ID: <4519AD9F.7020303@gmail.com>
References: <45196628.9010107@gmail.com> <Pine.LNX.4.63.0609262203510.25371@wbgn013.biozentrum.uni-wuerzburg.de> <4519A321.4010507@gmail.com> <Pine.LNX.4.63.0609270009400.25371@wbgn013.biozentrum.uni-wuerzburg.de>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 27 00:46:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSLh1-0002nn-49
	for gcvg-git@gmane.org; Wed, 27 Sep 2006 00:46:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964867AbWIZWp4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Sep 2006 18:45:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932476AbWIZWp4
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Sep 2006 18:45:56 -0400
Received: from py-out-1112.google.com ([64.233.166.181]:34784 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932474AbWIZWpz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Sep 2006 18:45:55 -0400
Received: by py-out-1112.google.com with SMTP id n25so3182735pyg
        for <git@vger.kernel.org>; Tue, 26 Sep 2006 15:45:54 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=liSWHMYbedq57L3M1x8fuNQZVXa6Ter3t9cM+z+J6zMKJSrqq7TqcpI5/o8NuZDiQ45xXKtPRl6AJISvqNMgZTsx0kcUeDdpLCRc7eEBiE7Nzve1hkbeG8smUY2qFcf571bCzacRQaxbL/4ArzmnIybnixV88tDnZPn6aB3xw7M=
Received: by 10.65.38.13 with SMTP id q13mr54309qbj;
        Tue, 26 Sep 2006 15:45:54 -0700 (PDT)
Received: from ?10.0.0.6? ( [67.20.67.46])
        by mx.gmail.com with ESMTP id a5sm4161096qbd.2006.09.26.15.45.53;
        Tue, 26 Sep 2006 15:45:54 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.7 (X11/20060911)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0609270009400.25371@wbgn013.biozentrum.uni-wuerzburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27834>

Johannes Schindelin wrote:
> Hi,
> 
> On Tue, 26 Sep 2006, A Large Angry SCM wrote:
> 
>> How the state (subproject list, branch names, etc.) is recorded in a 
>> parent project is only important to the parent project. The parent 
>> project must also know how to interact with with each of its 
>> subprojects.
> 
> Granted, if you mix VCSes, this is most pragmatic.
> 
> But it is also wrong: The whole point in bundling the subprojects together 
> is (IMHO) to get the benefits of a VCS for the root project, i.e. for the 
> combined states of the subprojects. After all, you want to say "I know 
> that this collection of projects at these states compiled and worked 
> fine."
> 
> And if you let a build system handle the stitching of the subprojects, you 
> completely lose these benefits.

Bundling and subproject support are two different things. Bundling is 
for convenience. Subprojects are usually the result of a dependency on a 
project managed or controlled by some other entity or on some part of 
the larger project with radically different development requirements.

Recording which version of a subproject to use is important and my note 
failed to discuss it. That I'll remedy over the next several days.
