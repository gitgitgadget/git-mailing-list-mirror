From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] GIT user survey
Date: Thu, 29 Jun 2006 11:49:58 +0200
Organization: At home
Message-ID: <e807o0$p98$1@sea.gmane.org>
References: <4d8e3fd30606240918m6b452314m6514b5e5fc86f147@mail.gmail.com> <94fc236b0606241455m22c4d285led04846a915267a2@mail.gmail.com> <20060624221523.GA4335@spinlock.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Thu Jun 29 11:50:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FvtAL-0005zL-KH
	for gcvg-git@gmane.org; Thu, 29 Jun 2006 11:50:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932791AbWF2Ju0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Jun 2006 05:50:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932874AbWF2Ju0
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jun 2006 05:50:26 -0400
Received: from main.gmane.org ([80.91.229.2]:20687 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932791AbWF2JuZ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Jun 2006 05:50:25 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FvtA7-0005wE-4b
	for git@vger.kernel.org; Thu, 29 Jun 2006 11:50:15 +0200
Received: from host-81-190-27-124.torun.mm.pl ([81.190.27.124])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 29 Jun 2006 11:50:15 +0200
Received: from jnareb by host-81-190-27-124.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 29 Jun 2006 11:50:15 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-27-124.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22852>

Matthias Kestenholz <lists@spinlock.ch> wrote:
> Adrien Beau (adrienbeau@gmail.com) wrote:
>> 
>> The results of the Mercurial survey have been posted there:
>> http://www.selenic.com/mercurial/wiki/index.cgi/UserSurvey
>> 
>> An interesting read.
> 
> I find the answers to the question, what people most like to see
> improved interesting: The improvement which got mentioned most often
> was "merge across rename", something which git does already.
> 
> It seems, that partial checkouts and truncated history are the
> only things left to implement for git from this list.

I think that at least some of the infrastructure for partial checkouts
is in place due to preliminary work for subproject (gitlink or bind)
support in git: git-read-tree and git-write-tree --prefix=<prefix>/
option suppport. But I might be mistaken.

Truncating history "by hand" is possible even now, using graft file.
There is recurring talk about "shallow clones", lately about "lazy clones".
There were mentioned here also split-history idea and sparse clone idea.  

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
