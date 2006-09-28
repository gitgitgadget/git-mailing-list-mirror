From: Matthew L Foster <mfoster167@yahoo.com>
Subject: Re: git and time
Date: Thu, 28 Sep 2006 10:33:50 -0700 (PDT)
Message-ID: <20060928173350.95443.qmail@web51004.mail.yahoo.com>
References: <Pine.LNX.4.64.0609281003070.3952@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Rogan Dawes <discard@dawes.za.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 28 19:34:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSzlw-0004ai-9Y
	for gcvg-git@gmane.org; Thu, 28 Sep 2006 19:34:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030266AbWI1Rdx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Sep 2006 13:33:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030279AbWI1Rdx
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Sep 2006 13:33:53 -0400
Received: from web51004.mail.yahoo.com ([206.190.38.135]:20104 "HELO
	web51004.mail.yahoo.com") by vger.kernel.org with SMTP
	id S1030273AbWI1Rdw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Sep 2006 13:33:52 -0400
Received: (qmail 95445 invoked by uid 60001); 28 Sep 2006 17:33:50 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=HyiqjaodRZyFWoCU7AOt2Q0EMrHkEFX5e26MPSHulrE7LfCOrscL3dM7roajIfQGLmnKSbKsQXJlh4ZC0h6e4MnFmPk+cj/jp3TczZtjduds5WtFri16PiyY/p0D6MQNOF5O0Y3grPA9qHuRHbKYUxgE2se9FNhvhg2LUygiuX0=  ;
Received: from [207.172.80.85] by web51004.mail.yahoo.com via HTTP; Thu, 28 Sep 2006 10:33:50 PDT
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0609281003070.3952@g5.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28024>


> Trust me. When we say that git ignores time, WE MEAN IT. Git does not rely 
> on time, git does not use time, git does not CARE!

I understand that git doesn't care about time internally as it treats it as a random number for
people to care about or not on their own, I am only saying that local time is more likely to be
cared about than disparate remote creation times. 

It should be possible to export git data, through say a web interface, in a such a way that local
time order is consistent with commit order. 

-Matt


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
