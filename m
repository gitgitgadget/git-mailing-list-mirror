From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Huge win, compressing a window of delta runs as a unit
Date: Fri, 18 Aug 2006 09:50:30 -0400
Message-ID: <9e4733910608180650j4542ab09q7daf4250825d3333@mail.gmail.com>
References: <9e4733910608161020s6855140bs68aaab6e1bbd3bad@mail.gmail.com>
	 <Pine.LNX.4.64.0608172323520.11359@localhost.localdomain>
	 <9e4733910608180615q4895334bw57c55e59a4ac5482@mail.gmail.com>
	 <Pine.LNX.4.63.0608181536250.28360@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Nicolas Pitre" <nico@cam.org>,
	"Shawn Pearce" <spearce@spearce.org>, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 18 15:52:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GE4ks-0004as-VG
	for gcvg-git@gmane.org; Fri, 18 Aug 2006 15:51:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030396AbWHRNue (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 Aug 2006 09:50:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030403AbWHRNue
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Aug 2006 09:50:34 -0400
Received: from nz-out-0102.google.com ([64.233.162.202]:31401 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1030396AbWHRNuc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Aug 2006 09:50:32 -0400
Received: by nz-out-0102.google.com with SMTP id 14so8856nzn
        for <git@vger.kernel.org>; Fri, 18 Aug 2006 06:50:31 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jzfeIObmLtoqsBN2QRBSmQ0ZEICI7nINRPx4WFAeOWSCynVwm7gWR8olFh8u37s1kKN2diYRvMHx41nOhk/1kXPqjU0E3hf8p/aqSt41Xce9953NwOX0j9zq6JSFBFrijFWvjVONuC5vZmmmlWZnE0OGOtLoZ/EcYA/HprP1B+w=
Received: by 10.65.95.14 with SMTP id x14mr3690539qbl;
        Fri, 18 Aug 2006 06:50:30 -0700 (PDT)
Received: by 10.65.133.17 with HTTP; Fri, 18 Aug 2006 06:50:30 -0700 (PDT)
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0608181536250.28360@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25665>

On 8/18/06, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Fri, 18 Aug 2006, Jon Smirl wrote:
>
> > I suspect the size reduction is directly proportional to the age of
> > the repository. The kernel repository only has three years worth of
> > data in it.  Linus has the full history in another repository that is
> > not in general distribution. We can get it from him when he gets back
> > from vacation.
>
> Maybe you mean
>
> http://www.kernel.org/git/gitweb.cgi?p=linux/kernel/git/tglx/history.git

That one only goes to 2002, the full one goes back to around 1990.

>
> Ciao,
> Dscho
>
>


-- 
Jon Smirl
jonsmirl@gmail.com
