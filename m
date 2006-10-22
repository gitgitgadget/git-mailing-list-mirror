From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: [PATCH 3/3] Teach git-branch -v and -w options
Date: Sun, 22 Oct 2006 22:50:06 +0200
Message-ID: <8c5c35580610221350q7107286eqd2ee8c5a4b09d341@mail.gmail.com>
References: <1161516626749-git-send-email-hjemli@gmail.com>
	 <11615166273819-git-send-email-hjemli@gmail.com>
	 <7vmz7o5eki.fsf@assigned-by-dhcp.cox.net>
	 <8c5c35580610221254r7a5a009cg7ee9a9d5821f5e99@mail.gmail.com>
	 <7vy7r83x9f.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 22 22:50:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GbkGr-0004En-Io
	for gcvg-git@gmane.org; Sun, 22 Oct 2006 22:50:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751470AbWJVUuK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Oct 2006 16:50:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751488AbWJVUuJ
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Oct 2006 16:50:09 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:33972 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751470AbWJVUuI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Oct 2006 16:50:08 -0400
Received: by nf-out-0910.google.com with SMTP id c2so2149568nfe
        for <git@vger.kernel.org>; Sun, 22 Oct 2006 13:50:07 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IL/X+Tbsv203Z6JrmtLPR1H4s/K94uOpMvW3D/Ts+C5fmteAQgQMnnUh601Fv5k7TS5tRxCA4D/PcabK2nxjHbdyW/i1vmsQHKmt6V0wkYbCEXRvoDhccRZ1Pn7+MJOjudgjhB9OSupPN9FaGWK76LJJ3mhjWYMw9arwqHfnp3A=
Received: by 10.82.107.15 with SMTP id f15mr1171194buc;
        Sun, 22 Oct 2006 13:50:06 -0700 (PDT)
Received: by 10.82.171.10 with HTTP; Sun, 22 Oct 2006 13:50:06 -0700 (PDT)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7vy7r83x9f.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29789>

[the gitlist fell off my first reply, so I've put it back...]

On 10/22/06, Junio C Hamano <junkio@cox.net> wrote:
> I was almost going to say that your patch saddened me because
> doing builtin-branch on top of Linus's packed-refs work (which
> means doing the series on top of "next") was part of my plan,

Heh, I don't want to compete with your c-skills :-)


> If you are aware of Kristian's patch that is a good news.  I do
> not have much objection to add optional frills to git-branch
> listing output, but I'd rather not see it done in the shell
> implementation.  Doing anything on the current git-branch.sh
> means that would need to be re-done later.

Agreed. I'll try and come up with a builtin instead, and let you worry
about more interesting stuff.

-- 
larsh
