From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: native-git-svn: A Summer of Code 2010 proposal
Date: Sun, 21 Mar 2010 06:08:08 -0500
Message-ID: <20100321110807.GA24016@progeny.tock>
References: <f3271551003191018j67aa133es2fee4e3dda519ce0@mail.gmail.com>
 <32541b131003191132y119037f8rae598d0037786703@mail.gmail.com>
 <fabb9a1e1003191139v6ea37df3uba441f2cba9bc992@mail.gmail.com>
 <32541b131003191430ld0eaa9cw1d2aac08cff15682@mail.gmail.com>
 <alpine.DEB.1.00.1003201148230.7596@pacific.mpi-cbg.de>
 <f3271551003201334o4919cd47s44d06288b0d6068b@mail.gmail.com>
 <20100320210406.GA29899@progeny.tock>
 <alpine.DEB.1.00.1003211125290.7596@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	Stephan Beyer <s-beyer@gmx.net>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Mar 21 12:07:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NtJ00-00071J-5X
	for gcvg-git-2@lo.gmane.org; Sun, 21 Mar 2010 12:07:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752684Ab0CULHK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Mar 2010 07:07:10 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:36297 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752613Ab0CULHI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Mar 2010 07:07:08 -0400
Received: by gyg8 with SMTP id 8so2229412gyg.19
        for <git@vger.kernel.org>; Sun, 21 Mar 2010 04:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=t7qqNzeSQbXrNtF9JxxOGj4WWpXCJm4SDf+y1DdHIVY=;
        b=eOD1NjV+jc5c+LUqD8B1zmLUnaXeYokrDmjh+8qgH9bE4Q6z4u8eZq48qh+34PgyAV
         9eQCNu+c3IC25BwlFY8YVywLR1rwPNDCK8SCyO9sX0+wEhC/iBVemcE5gYzvRqe5q3IQ
         i2mJiyYNjlvh224PolSjBxOiEilV3dl1bATD4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=vzj6Ddi7MUY2PG0l+l/K1+qFi2zmN3yuLAhHJd5jqaDf5FdgFSdAiW6RKh6rLSLvvS
         DJPWJCxBZiRWzXx8kMbYH2w8PbB118pzytb2eChIXgyMTaOp+CAww71CjIR2CllxUEnZ
         rlMG85iiltoP8rj/HMc6v4ZqwSwE+Xw6mL1CY=
Received: by 10.101.7.14 with SMTP id k14mr6171663ani.173.1269169626146;
        Sun, 21 Mar 2010 04:07:06 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 23sm3388507iwn.14.2010.03.21.04.07.05
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 21 Mar 2010 04:07:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.1003211125290.7596@pacific.mpi-cbg.de>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142817>

Hi,

Johannes Schindelin wrote:
> On Sat, 20 Mar 2010, Jonathan Nieder wrote:
>> Ramkumar Ramachandra wrote:

>>> == Timeline ==
>>
>> The one thing I worry about is that you are proposing to wait a while 
>> before submitting your changes upstream.  I would suggest pushing 
>> whatever pieces work to contrib/ early on to get more feedback from 
>> reviewers and testers.  (I am saying this selfishly, as a potential 
>> tester.)
>
> I would rather have frequent updates about the progress on the mailing 
> list, and a long-running branch in which the code is developed, only 
> rebasing to Junio's next/pu when absolutely necessary.

You are usually right about this kind of thing, so I will not disagree
too strongly.

But I will say: I think this was a mistake in the git sequencer
project.  Stephan did excellent work both on and off list, and I think
it is a shame that as little of his code reached mainline by the end
of the summer as did.  I imagine that submitting bit by bit would have
required a different approach: maybe a sequencer--helper that would
gradually grow to absorb more of the functionality of the prototype
script.  Harder, but the result would be working code.

Now it is hard enough to merge current master into the sequencer
branch...

Whether to use stable topic branches or rebased-against-master patch
series as the means of submission is a decision that matters less to me.
(I prefer the former.)

> After all, it would be additional work to put it first into contrib/ and 
> then to integrate it fully into git.git.

I am not sure I understand this point.  Are you saying the change in
filenames would be problematic?

Curious,
Jonathan
