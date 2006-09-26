From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: Notes on Using Git with Subprojects
Date: Tue, 26 Sep 2006 15:07:27 -0700
Message-ID: <4519A49F.6000206@gmail.com>
References: <45196628.9010107@gmail.com> <Pine.LNX.4.64.0609261629160.9789@iabervon.org>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 27 00:07:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSL5W-0004c4-2r
	for gcvg-git@gmane.org; Wed, 27 Sep 2006 00:07:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932438AbWIZWHf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Sep 2006 18:07:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932439AbWIZWHf
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Sep 2006 18:07:35 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:54418 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932438AbWIZWHe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Sep 2006 18:07:34 -0400
Received: by nf-out-0910.google.com with SMTP id o25so315927nfa
        for <git@vger.kernel.org>; Tue, 26 Sep 2006 15:07:33 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=rKjnkAqJ4hC0FSfCRXunrS7Z6nIl/baZaa87/xjGJ2b4ZCKWFuBXvD/GSz3nGjVu0F/j1/r2sylxD+RQwcKiHC1R31o5SL1EZHyOGQb7K/AgOEvwFmMR9+e4pwp2gje+3d+AsSx7XBp/81yEx+PeG9MWpD67nWQ5SDv20gQILv8=
Received: by 10.78.204.20 with SMTP id b20mr595804hug;
        Tue, 26 Sep 2006 15:07:32 -0700 (PDT)
Received: from ?10.0.0.6? ( [67.20.67.46])
        by mx.gmail.com with ESMTP id 8sm3081678hug.2006.09.26.15.07.30;
        Tue, 26 Sep 2006 15:07:31 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.7 (X11/20060911)
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.64.0609261629160.9789@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27829>

Daniel Barkalow wrote:
> There are a bunch of use cases which people see as subprojects, with 
> slightly different desires. For example, I personally don't think there's 
> any point to subprojects if a commit of the parent project doesn't specify 
> the embedded commits of each subproject (so, for example, you can use 
> bisect on the parent project to figure out which act of updating a 
> subproject broke the resulting system). AFAICT, your design doesn't handle 
> that, but uses the most recently fetched versions of all subprojects, with 
> the revision control of the parent only handling revisions in the 
> arrangement and membership of subprojects in the parent.

That isn't that much different than what I outlined. Instead of 
recording the branch name and directory in the parent project, you could 
record the commit SHA1 ID for each subproject and directory. The 
machinery changes but the idea is the same.
