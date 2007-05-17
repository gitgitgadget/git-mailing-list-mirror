From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: Smart fetch via HTTP?
Date: Fri, 18 May 2007 03:24:54 +1200
Message-ID: <46a038f90705170824g4ef8c800w826ada3964b711a@mail.gmail.com>
References: <20070515201006.GD3653@efreet.light.src>
	 <46a038f90705152225y529c9db3x8615822e876c25a8@mail.gmail.com>
	 <Pine.LNX.4.64.0705161232120.6410@racer.site>
	 <46a038f90705161426n3b928086t2d3e68749557f866@mail.gmail.com>
	 <Pine.LNX.4.64.0705170152470.6410@racer.site>
	 <20070517010335.GU3141@spearce.org>
	 <alpine.LFD.0.99.0705162309310.24220@xanadu.home>
	 <Pine.LNX.4.64.0705171143350.6410@racer.site>
	 <alpine.LFD.0.99.0705170954200.24220@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>, "Jan Hudec" <bulb@ucw.cz>,
	git@vger.kernel.org
To: "Nicolas Pitre" <nico@cam.org>
X-From: git-owner@vger.kernel.org Thu May 17 17:25:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hohqh-0000QF-DF
	for gcvg-git@gmane.org; Thu, 17 May 2007 17:25:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754114AbXEQPY5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 May 2007 11:24:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754356AbXEQPY5
	(ORCPT <rfc822;git-outgoing>); Thu, 17 May 2007 11:24:57 -0400
Received: from wx-out-0506.google.com ([66.249.82.236]:23912 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754114AbXEQPY4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 May 2007 11:24:56 -0400
Received: by wx-out-0506.google.com with SMTP id h31so576398wxd
        for <git@vger.kernel.org>; Thu, 17 May 2007 08:24:56 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JB09SksxCMhKMP5yJxgr9vQs+NERotSrBI6J7l9AgMippIZw0c7lJqBkHVVcnt2KrihBoFBe4VVnRHh3YMt83H2/02GSTtVWoWSoAPZ1OvhK73/KAstD9NFXTgjm1OaHdv0zsFAhzwtMxsV8w9faPH8Cpsgz292Mj6U9c+BxNi8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=U+wbopTDI+/SK2fkPl/3eST9V+x58GySW/AvMPyYSe3saMnUmcmTz7aMFSC5LFDnyqEyQyldt2AR50q7rXz+s2+RzXHkjX9EGWF8mBJ8U5dShLSNnvSzSdsBBnpTogc/ozsy3v72Q0BOzH29XjjAN0Kp1kXrJp2rAwLA8SwbWKM=
Received: by 10.90.115.9 with SMTP id n9mr687940agc.1179415494930;
        Thu, 17 May 2007 08:24:54 -0700 (PDT)
Received: by 10.90.75.15 with HTTP; Thu, 17 May 2007 08:24:54 -0700 (PDT)
In-Reply-To: <alpine.LFD.0.99.0705170954200.24220@xanadu.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47531>

On 5/18/07, Nicolas Pitre <nico@cam.org> wrote:
> And if you have 1) the permission and 2) the CPU power to execute such a
> cgi on the server and obviously 3) the knowledge to set it up properly,
> then why aren't you running the Git daemon in the first place?

And you probably _are_ running git daemon. But some clients may be on
shitty connections that only allow http. That's one of the scenarios
we're discussing.

cheers,


m
