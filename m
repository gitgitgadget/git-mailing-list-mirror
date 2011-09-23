From: Jon Forrest <nobozo@gmail.com>
Subject: Re: More Beginning Git Questions
Date: Fri, 23 Sep 2011 11:14:56 -0700
Message-ID: <4E7CCCA0.50909@gmail.com>
References: <4E7C9AAD.7060209@gmail.com> <m3ipojqhpm.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Sep 23 20:14:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R7AGq-0007NJ-Ra
	for gcvg-git-2@lo.gmane.org; Fri, 23 Sep 2011 20:14:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751124Ab1IWSOk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Sep 2011 14:14:40 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:48007 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751092Ab1IWSOk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Sep 2011 14:14:40 -0400
Received: by ywb5 with SMTP id 5so2890249ywb.19
        for <git@vger.kernel.org>; Fri, 23 Sep 2011 11:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=CWyVERWFAOnDhzssRsgt7k5qtBNFoJcsmKQxuOYTfQI=;
        b=d5kCWFv4yB1CK5ra52gnZHfMhfWRpKzaNYrQ5BNZlhPJSoLKULvXrXn/1wiUviVtWD
         z3TTv4Wmt4+aeNeL57kd7sG8wRoZ5z7l/8DLQzUAlnRysKp87DABhmMtEK+pNtHGuGfa
         VTyFnkFdAW36Yas4lMYwAAC5hursZSMuiDzZc=
Received: by 10.236.154.137 with SMTP id h9mr23685389yhk.26.1316801679510;
        Fri, 23 Sep 2011 11:14:39 -0700 (PDT)
Received: from [192.168.50.71] (206-80-5-2.static.twtelecom.net. [206.80.5.2])
        by mx.google.com with ESMTPS id p14sm42438963anh.25.2011.09.23.11.14.38
        (version=SSLv3 cipher=OTHER);
        Fri, 23 Sep 2011 11:14:38 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:6.0.2) Gecko/20110902 Thunderbird/6.0.2
In-Reply-To: <m3ipojqhpm.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181984>

On 9/23/2011 10:42 AM, Jakub Narebski wrote:

> I recommend reading "Pro Git" book (http://progit.org)

I'm reading that too. I have some similar pedantic questions
about that book but I don't want to be a pest so I'll
stick with the tutorial now. Maybe some of my questions
about "Pro Git" will get answered.

>> Does this include both changes that Alice has checked in to
>> her repository and uncommitted changes in her working tree?
>
> Generally Alice shouldn't have uncommitted changes when doing
> "git pull".

That's what the tutorial said but I'm trying to understand
what happens if she does have uncommitted changes. I'm
trying to understand the total picture.

> When there is a merge conflicts, the index gets populated by more than
> one version: "ours" (i.e. Alice version) in stage 2, "theirs"
> (i.e. Bob version) in stage 3, and "base" (common ancestor version) in
> stage 1.  The stage 0, where "git add" / "git stage" puts contents of
> file, is empty.

I didn't know there were multiple staging areas.

> You can see it using "git ls-files --abbrev --stage".

That's very helpful.

Thanks to (almost) everyone who has responded. I'm hoping that
others new to Git will benefit from this discussion.

Jon
