From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: An alternate model for preparing partial commits
Date: Sat, 28 Jun 2008 20:52:08 +0400
Message-ID: <20080628165208.GN5737@dpotapov.dyndns.org>
References: <9af502e50806262350t6e794a92g7751147f1882965@mail.gmail.com> <alpine.DEB.1.00.0806271408290.9925@racer> <9af502e50806271014l661dcfc9o4f61ee2b54677bd6@mail.gmail.com> <20080628021444.GI5737@dpotapov.dyndns.org> <9af502e50806271957o2df9e0abt9dadcb0514dd4173@mail.gmail.com> <20080628040344.GK5737@dpotapov.dyndns.org> <9af502e50806272320p23f01e8eo4a67c5f6f4476098@mail.gmail.com> <20080628123522.GL5737@dpotapov.dyndns.org> <9af502e50806280853i4c8564daxde2041aedc7fcb8d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Robert Anderson <rwa000@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 28 18:53:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCdfi-00053m-Md
	for gcvg-git-2@gmane.org; Sat, 28 Jun 2008 18:53:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753010AbYF1QwO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Jun 2008 12:52:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752980AbYF1QwO
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Jun 2008 12:52:14 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:47884 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751975AbYF1QwN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jun 2008 12:52:13 -0400
Received: by fg-out-1718.google.com with SMTP id 19so464221fgg.17
        for <git@vger.kernel.org>; Sat, 28 Jun 2008 09:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=GIRPlJbxPyc0vHWYSvr2l04xyBMwCdjOQkX6eF9k9hY=;
        b=Q5QDFWswtQO+iBoVbsN7IXHE7qfw8xCXdRUhmguwJaews8y+f15tdwBDAhSFO8DXs6
         SHE4sYgO1eDlqDinhQceE8KeE/fSEwxOVoMLKuSYsLzgYorfkF2KfLdoLqXL5I++9x7D
         hvspfL/HafjM8E9lWMTjTjrF3hn88nQsCpYqw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=HMb3Xwq6BenUHdZEYFaZjaUCJ2dJpUYpkYeZnbFnsoPJoe/f2iJOfvIZfPH7fRaymi
         DADul/VyGM/6IMaboWvIOO7eh+tl2uO+OVPEJmQKSjUKp5Um+z/mVVNCeXjOJgeT1jSo
         ncjH5tXmItZbV0zXlRJaYlTLBwvXgq8o2Cqlc=
Received: by 10.86.80.17 with SMTP id d17mr3710899fgb.47.1214671931834;
        Sat, 28 Jun 2008 09:52:11 -0700 (PDT)
Received: from localhost ( [85.140.169.188])
        by mx.google.com with ESMTPS id d4sm5199925fga.8.2008.06.28.09.52.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 28 Jun 2008 09:52:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <9af502e50806280853i4c8564daxde2041aedc7fcb8d@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86729>

On Sat, Jun 28, 2008 at 08:53:04AM -0700, Robert Anderson wrote:
> On Sat, Jun 28, 2008 at 5:35 AM, Dmitry Potapov <dpotapov@gmail.com> wrote:
> >> Fine, you like doing extra work for no benefit.  Enjoy yourself.
> >
> > I don't see where you find this extra work.
> 
> You aren't trying to.  You're knee-jerk defending the status quo, as
> is the case of 95% of reply mail sent to any SCM mailing list.

Nice... and you are an arrogant and narrow-minded individual who
believes that he knows better anyone else, but you are incapable to
produce neither code nor any solid logical argument to support your
view. So you limit yourself to verbal masturbation about some Git
deficiency and blah-blah-blah, which no one but you can notice here.
And then the workflow that you call you call as "inconvenient and
creates redundant work" produced Git, which has become self-hosted
in three days and has been developed very rapidly ever since then.
You can do better with your workflow? Prove it! Until then, I have
no interest in any further communication on this subject with you.

Thanks,
Dmitry
