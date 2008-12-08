From: "Peter Harris" <git@peter.is-a-geek.org>
Subject: Re: Can someone confirm what the contents of refs/heads/master means?
Date: Mon, 8 Dec 2008 14:55:27 -0500
Message-ID: <eaa105840812081155j1e402226i896a7ad3061966e1@mail.gmail.com>
References: <f78b0fcc-6165-440a-b76b-b1b0a281b15c@k8g2000yqn.googlegroups.com>
	 <eaa105840812081135p56eceb97yb968575b11a7f985@mail.gmail.com>
	 <f95d47890812081142k575264fctd77254ed3386a069@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "David Copeland" <davetron5000@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 08 20:56:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L9mDm-0003Aw-Ua
	for gcvg-git-2@gmane.org; Mon, 08 Dec 2008 20:56:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751649AbYLHTza (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Dec 2008 14:55:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751640AbYLHTz3
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Dec 2008 14:55:29 -0500
Received: from yx-out-2324.google.com ([74.125.44.28]:53634 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751631AbYLHTz3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Dec 2008 14:55:29 -0500
Received: by yx-out-2324.google.com with SMTP id 8so531959yxm.1
        for <git@vger.kernel.org>; Mon, 08 Dec 2008 11:55:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=+7yBDKdbEMz9GS/KALURhLiESe3P4jMuKOJdYsyn1Lo=;
        b=mVDaLydZCqpD90JC6H8vxpDYcn7GqNQi/aU9Bl9Tl2ywY+qXPOkx2L96V8DsH1kmnC
         npeXDa2YRuCrGy1I4ngvS8ZdNNSS0vyQ1G0UtTPKS3frx5JOIBqLToXZ6Rr4zEs3poTV
         Xz0ShfAehAVZIfgwbmzHC0VUoG3VPlXf4U8Ks=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=Akjb4zmr76KNE8vkCxsc/aMWjr4AVcsbBlksrbHUm2Z7gfawFvi3rbWxJmynulWlSA
         vF30ulAeq2Ac4fyX6Xlh73yAUAD1qdMUCvP16yRtz430AGYrz0hOOtajNSTtFmZZnD2B
         G63WdhCFHB31028hVpQd+pIEXvAuA9eIsogbE=
Received: by 10.65.75.2 with SMTP id c2mr3157404qbl.12.1228766127311;
        Mon, 08 Dec 2008 11:55:27 -0800 (PST)
Received: by 10.65.230.19 with HTTP; Mon, 8 Dec 2008 11:55:27 -0800 (PST)
In-Reply-To: <f95d47890812081142k575264fctd77254ed3386a069@mail.gmail.com>
Content-Disposition: inline
X-Google-Sender-Auth: d27ca482d85f77f5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102579>

On Mon, Dec 8, 2008 at 2:42 PM, David Copeland wrote:
> Thanks for the info :)
>
> The reason I edited by hand is when I was on trunk (e.g. git checkout
> trunk), I did a git svn dcommit and it worked, but said "you aren't on
> a branch", so I was concerned I might be in some weird state (i.e. if
> trunk isn't a branch, can I make a branch off of it?)

Trunk is a "remote branch", so you can't check it out. If you try, you
get what is called a "detached HEAD".

http://www.kernel.org/pub/software/scm/git/docs/user-manual.html#detached-head

And, yes, you can make a local branch off of a remote branch.

Peter Harris
