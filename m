From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: Converting to Git using svn-fe (Was: Speeding up the initial
 git-svn fetch)
Date: Thu, 14 Oct 2010 22:07:22 +0200
Message-ID: <AANLkTi=PwLmKSb_gF=k+xVSZfM1CDCFZFZdR7pLgh6t6@mail.gmail.com>
References: <AANLkTimn99ErpLNfX-Jxn2t6cKCOoKFb91g1_m3TypOf@mail.gmail.com>
 <12137268.486377.1287073355267.JavaMail.root@mail.hq.genarts.com> <20101014163441.GD16500@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Matt Stump <mstump@goatyak.com>, git@vger.kernel.org,
	David Barr <david.barr@cordelta.com>,
	Tomas Carnecky <tom@dbservice.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Stephen Bash <bash@genarts.com>,
	Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 14 22:07:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P6U5f-0003d2-GK
	for gcvg-git-2@lo.gmane.org; Thu, 14 Oct 2010 22:07:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755432Ab0JNUHo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Oct 2010 16:07:44 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:62083 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755249Ab0JNUHn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Oct 2010 16:07:43 -0400
Received: by gxk6 with SMTP id 6so19234gxk.19
        for <git@vger.kernel.org>; Thu, 14 Oct 2010 13:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=zkmNRcLVpxyt5sHsI2+g2nw9tiv6RUn6SdIux1JXk/0=;
        b=pWTby8CezdfDlgqQI9hINcoX0gSqgOzR+s6owNG9lL3lon5FiMOiVuOai/lDtHtCPU
         MzcFxCmVW4V9w5JAYRDNwZk/OMiTxhz/pH4W7Zz04pdqMx6UFzXl4bk88QgIIg2x02eB
         G6ZWmrOw7eJhIjnN2vBqrq73GMJtDHeaBZW3Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=xnWL4T0NuRRMYg2C7wVSNeiBQSue+jMj9wY0k131zvD+OzO7fcpecIROv3LWCy1G8G
         L2QPR9AaBm5DSgKT6wKe1eHMgSAJnxpGn7MM+7S5H0PJrbD5a0iNYMx7qY/32Mud0qLd
         apLMF7gFDh9kQio0I9hVuqymYoQbBLzwdaD8c=
Received: by 10.150.147.11 with SMTP id u11mr3918601ybd.386.1287086862657;
 Thu, 14 Oct 2010 13:07:42 -0700 (PDT)
Received: by 10.151.15.8 with HTTP; Thu, 14 Oct 2010 13:07:22 -0700 (PDT)
In-Reply-To: <20101014163441.GD16500@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159070>

Heya,

On Thu, Oct 14, 2010 at 18:34, Jonathan Nieder <jrnieder@gmail.com> wrote:
> [just cc-ing David, Tom, Sverre, Ram, who might be interested.]

Thanks, I'm definitely interested.

> Stephen Bash wrote:

>>> I hate making more work for people but I would love a copy of your
>>> notes.
>>
>> Okay, here we go!

Thanks for the very interesting read. It seems like a (very) long
pipeline though, I wonder how we can make this not only easier, but
also more streamlined for git-remote-svn. Do you have any suggestions
on how you would prefer this to be done in git-remote-svn? (Main
advantage for git-remote-svn might be that we can use git notes to
store commit conversion information, instead of having to mine commit
messages.)

-- 
Cheers,

Sverre Rabbelier
