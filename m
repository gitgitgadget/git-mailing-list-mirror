From: Petr Baudis <pasky@suse.cz>
Subject: Re: [FYI][PATCH] Customizing the WinGit installer
Date: Mon, 6 Oct 2008 19:23:48 +0200
Message-ID: <20081006172348.GQ10360@machine.or.cz>
References: <20081003122727.GE10360@machine.or.cz> <alpine.DEB.1.00.0810061621110.22125@pacific.mpi-cbg.de.mpi-cbg.de> <20081006141840.GO10360@machine.or.cz> <alpine.DEB.1.00.0810061718240.22125@pacific.mpi-cbg.de.mpi-cbg.de>
Reply-To: pasky@suse.cz
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: msysgit@googlegroups.com, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Mon Oct 06 19:27:28 2008
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from yx-out-2122.google.com ([74.125.44.26])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KmtpP-0006Yz-BK
	for gcvm-msysgit@m.gmane.org; Mon, 06 Oct 2008 19:25:03 +0200
Received: by yx-out-2122.google.com with SMTP id 22so1294840yxm.63
        for <gcvm-msysgit@m.gmane.org>; Mon, 06 Oct 2008 10:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received-spf:authentication-results:received:date
         :from:to:cc:subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent:reply-to:sender
         :precedence:x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        bh=XejQ8MqPcEGzA8PjMLl4bBYKDZ2sGEmYOdgox9gGOls=;
        b=aPYzgFa5dNMYrjB3lHr8jcU8KDqJ+BDzWY9hIe6iqvZSGYyUKFsqGfL8sQt4Xzo3Cs
         gg+wX7qOYRKaPFAyvjULzoFCLLXfEgeTubft76hQIc8/pI+8udEhqKeg+9UYoZrjEnSQ
         AoTwPrPPCmZsf0ymnFGjZvWaTrtsSLHLlC+tU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results:date
         :from:to:cc:subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent:reply-to:sender
         :precedence:x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        b=2mowZ1uFZM/WLrmI6g1spHtiZHD1Fzjk5D9LiB5Z9TFYEDytyQf8t5CUWAbVMxoKBT
         dgd75T18mQ2w/pUc0oIUuxMdA4Vi53LdnVaU81cc54UkYtYgPUnHnG7ghLKX1oR3tfR2
         qrAc8KpnPuqWF0Q0gtSfrfW7s4DlST6QDmcus=
Received: by 10.151.42.18 with SMTP id u18mr161818ybj.9.1223313830881;
        Mon, 06 Oct 2008 10:23:50 -0700 (PDT)
Received: by 10.44.74.68 with SMTP id w68gr3001hsa.0;
	Mon, 06 Oct 2008 10:23:50 -0700 (PDT)
X-Sender: pasky@machine.or.cz
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.90.71.15 with SMTP id t15mr77608aga.7.1223313830148; Mon, 06 Oct 2008 10:23:50 -0700 (PDT)
Received: from machine.or.cz (w241.dkm.cz [62.24.88.241]) by mx.google.com with ESMTP id 22si11160139yxr.1.2008.10.06.10.23.49; Mon, 06 Oct 2008 10:23:49 -0700 (PDT)
Received-SPF: neutral (google.com: 62.24.88.241 is neither permitted nor denied by best guess record for domain of pasky@machine.or.cz) client-ip=62.24.88.241;
Authentication-Results: mx.google.com; spf=neutral (google.com: 62.24.88.241 is neither permitted nor denied by best guess record for domain of pasky@machine.or.cz) smtp.mail=pasky@machine.or.cz
Received: by machine.or.cz (Postfix, from userid 2001) id 21F2E3939BDC; Mon,  6 Oct 2008 19:23:48 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0810061718240.22125@pacific.mpi-cbg.de.mpi-cbg.de>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: msysgit@googlegroups.com
Precedence: bulk
X-Google-Loop: groups
Mailing-List: list msysgit@googlegroups.com;
	contact msysgit+owner@googlegroups.com
List-Id: <msysgit.googlegroups.com>
List-Post: <mailto:msysgit@googlegroups.com>
List-Help: <mailto:msysgit+help@googlegroups.com>
List-Unsubscribe: <http://googlegroups.com/group/msysgit/subscribe>,
	<mailto:msysgit+unsubscribe@googlegroups.com>
X-BeenThere-Env: msysgit@googlegroups.com
X-BeenThere: msysgit@googlegroups.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97607>


  Hi,

On Mon, Oct 06, 2008 at 05:23:19PM +0200, Johannes Schindelin wrote:
> To give them an idea about their _rights_.  Because they are entitled by 
> the GPL to get -- in source -- the changes that were done to that 
> particular distributions.
> 
> Speaking from experience, companies usually do not want to tell you about 
> your rights with regard to free software.
> 
> And in this case, I have a personal interest.  I feel that my efforts to 
> the msysGit project are not really rewarded.  People like to use it, but 
> they hardly give anything back (you being a very notable exception).

  Maybe this is a little of a misunderstanding. This is not a "consumer"
aimed customized Git version. This is for internal Git usage within the
corporation, the users have varying interest in Git but it is generally
very low, they just regard it as another tool and they will never hack
or customize it; I just don't see a point in bothering them with another
extra installation step. Maybe in more general Git distribution I would
agree this change indeed is not that appropriate (even though in my own
GPL'd project, I wouldn't add the GPL step to the installer anyway).

-- 
				Petr "Pasky" Baudis
People who take cold baths never have rheumatism, but they have
cold baths.
