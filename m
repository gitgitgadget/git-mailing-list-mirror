From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 6/6] diff: deprecate -q option to diff-files
Date: Fri, 19 Jul 2013 14:01:06 -0700
Message-ID: <20130719210106.GZ14690@google.com>
References: <7vvc496ruf.fsf@alter.siamese.dyndns.org>
 <1374107406-14357-1-git-send-email-gitster@pobox.com>
 <1374107406-14357-7-git-send-email-gitster@pobox.com>
 <20130719033126.GA27853@google.com>
 <7vip07ypu7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Stefan Beller <stefanbeller@googlemail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 19 23:01:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V0Hnh-0008TE-7f
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jul 2013 23:01:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752444Ab3GSVBN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jul 2013 17:01:13 -0400
Received: from mail-pd0-f177.google.com ([209.85.192.177]:45451 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751416Ab3GSVBK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jul 2013 17:01:10 -0400
Received: by mail-pd0-f177.google.com with SMTP id p10so4688907pdj.22
        for <git@vger.kernel.org>; Fri, 19 Jul 2013 14:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=EO/WiWZ25EzLbqHTbJpcsGHpTqFMGafcFXKzhaKZd/0=;
        b=aq544s6PftlY0i5IcLV88QWUAzlM5JjKXdyACvJkQb1mmG/S4BYQIl4TEV/ZIJuBb7
         iIwVc1/3m9u2JdtszgjrkucGoaKgtCzIIdsSjnbecLtWrWaFg74HFOVDVhBuLiBB/tyz
         M8uXqgIdfj7MaSjLU94gJBQtmky/LrvktD3zIO9c52I+a8KE9FFng9JpIpGpde3DG3IW
         hEF8wP2BV44kR97TMoc2FACEYU59bhyzRoNsNKIfXPyNKb67/phPSeTwzdhhBHNbNGMT
         EjKN918NGo9GJJHxJ4K61quMoAtDmboIdgt5jCojbvXB6rVgYxidY7L3nLf9GSe3kafA
         D9lw==
X-Received: by 10.68.2.69 with SMTP id 5mr19186926pbs.124.1374267670055;
        Fri, 19 Jul 2013 14:01:10 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id fl2sm24396479pab.23.2013.07.19.14.01.08
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 19 Jul 2013 14:01:08 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vip07ypu7.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230851>

Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>> I don't mind seeing support for "-q" dropped, but I really don't think
>> it's worth delaying git 2.0 for that.  Would s/in Git 2.0/in some
>> future release/ be ok?
>
> I do not think keeping the support for "-q" in is any huge burden.
> We do not have to remove it, forever, for that matter.

I agree with the above, which is why I don't want a promise to remove
the "-q" option to cause Git 2.0 to be delayed.  It would be better to
schedule it for Git 3.0, or for another unspecified future git
release.

I thought the 2.0 boundary was a time for changes that everyone
already knew we should make, where we had been waiting for a good
moment to change behavior while giving people adequate warning to
avoid disrupting them too much.  We have a good collection of those
for 2.0, and the next batch can wait until 3.0.

Sorry for the lack of clarity,
Jonathan
