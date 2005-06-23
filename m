From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: The coolest merge EVER!
Date: Thu, 23 Jun 2005 10:12:09 +1000
Message-ID: <2cfc4032050622171258636771@mail.gmail.com>
References: <Pine.LNX.4.58.0506221433540.2353@ppc970.osdl.org>
Reply-To: jon@blackcubes.dyndns.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 23 02:14:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DlFM8-0000yY-4d
	for gcvg-git@gmane.org; Thu, 23 Jun 2005 02:14:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261899AbVFWAQ5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Jun 2005 20:16:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261764AbVFWAOT
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Jun 2005 20:14:19 -0400
Received: from rproxy.gmail.com ([64.233.170.202]:49691 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261175AbVFWAMK convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jun 2005 20:12:10 -0400
Received: by rproxy.gmail.com with SMTP id i8so169050rne
        for <git@vger.kernel.org>; Wed, 22 Jun 2005 17:12:09 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QzC5F1RnUzS6geRRQje4WLjukFbpaOACSm7UDvueHxVynBk47McfMU2Am7b4so9mydsJoQvq3rzOBo0D59UtC/Rusl/N8z7hmfo2wjS/lxXvHlsvRwEeQUEF054ht8k3IeJhMmMiooxYcHOxqBv3ZfrrfkfHfotixdbssdL0QzY=
Received: by 10.39.2.65 with SMTP id e65mr581015rni;
        Wed, 22 Jun 2005 17:12:09 -0700 (PDT)
Received: by 10.38.104.42 with HTTP; Wed, 22 Jun 2005 17:12:09 -0700 (PDT)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0506221433540.2353@ppc970.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On 6/23/05, Linus Torvalds <torvalds@osdl.org> wrote:
> 
> Ok, Junio had some cool octopus merges, but I just one-upped him.
> 
> I just merged the "gitk" repository into git, and I did it as a real git
> merge, which means that I actually retained all the original gitk
> repository information intact. IOW, it's not a "import the data" thing,
> it's literally a merge of the two trees, and the result has two roots.
> 
> Now, the advantage of this kind of merge is that Paul's original gitk
> repository is totally unaffected by it, yet because I now have his history
> (and the exact same objects), the normal kind of git merge should work
> fine for me to continue to import Paul's work - we have the common parent
> needed to resolve all differences.
> 

You do realise what this means, don't you?

The Borg can now start accumulating software into one massive
repository of everything ever written and it will never forget -
resistance will be futile.

Of course, it may run out of disk space.

jon.
