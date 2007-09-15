From: "Nikodemus Siivola" <nikodemus@random-state.net>
Subject: Re: Data Integrity & un-Commited Branches
Date: Sat, 15 Sep 2007 16:11:55 +0300
Message-ID: <6bcc356f0709150611i97d31f0yb91016e53c4f5e9f@mail.gmail.com>
References: <2a8a071a0709140028o472bcr8c82bd88e37cc4e9@mail.gmail.com>
	 <2a8a071a0709140036l5db62c0fl5af01f75f35610ba@mail.gmail.com>
	 <7vk5qtd3le.fsf@gitster.siamese.dyndns.org>
	 <2a8a071a0709141740l144b60aevdfec2b6cdab8bb60@mail.gmail.com>
	 <20070915025129.GY3099@spearce.org>
	 <20070915073845.GB3782@efreet.light.src>
	 <20070915075144.GB3099@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Jan Hudec" <bulb@ucw.cz>,
	"Brian Scott Dobrovodsky" <brian@pontech.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Sep 15 15:12:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IWXRM-00025D-7h
	for gcvg-git-2@gmane.org; Sat, 15 Sep 2007 15:12:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752084AbXIONL5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Sep 2007 09:11:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751677AbXIONL5
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Sep 2007 09:11:57 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:40212 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751489AbXIONL4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Sep 2007 09:11:56 -0400
Received: by nf-out-0910.google.com with SMTP id g13so847685nfb
        for <git@vger.kernel.org>; Sat, 15 Sep 2007 06:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        bh=wu+qSneQ40OAcxMQYiHUuB8BSqm2ZkGtbjBJGUSXssI=;
        b=gE+SiQtRlM7DqxanzWjg9o24NsfaP4LkMkiWX7ntzx64DsmlKe9OzZDzOWs73noKsM4oAQxIYuNo64L4kQUo1jN6tNH7pN6UO1ukY+FyUNOhhwZggkg5QfkTFKo8t53bOLMKjBH2g7bmfh5BO6RrwZaaASv7kNFFEI5VcGJsMac=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=si+v9IaWncbZjOnoHbxh6npyEfstkLR35eA/kddiCiK/ovBwWTak52FDFlYNjEAhJjIDhUIhgxql+gfB74FOkjstyH7aPKaE84OKuHPiQn4X9UU8qs09FXyRnhLwgAipvvQy3Qndo61jyH71najUw+zyhL1UuBKvXC9K/RuTj/I=
Received: by 10.86.58.3 with SMTP id g3mr2142559fga.1189861915328;
        Sat, 15 Sep 2007 06:11:55 -0700 (PDT)
Received: by 10.86.4.5 with HTTP; Sat, 15 Sep 2007 06:11:55 -0700 (PDT)
In-Reply-To: <20070915075144.GB3099@spearce.org>
Content-Disposition: inline
X-Google-Sender-Auth: 278ac6bcdcc7ffe1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58240>

One thing that I've been bitten a couple of times is that
I think I'm on branch X, which should be clean, whereas
I'm really on branch Y with uncommitted changes. Then I
checkout another branch, and see the uncommitted work -- and
given that I have a couple of dozen related feature branches
in my tree it may take a while to figure which branch the
uncommitted work came from.

It would be nice if the "uncommitted changes" message when
swithching branches told you which branch you came from...

Cheers,

 -- Nikodemus
