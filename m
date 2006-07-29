From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Licensing and the library version of git
Date: Sat, 29 Jul 2006 00:31:00 -0400
Message-ID: <9e4733910607282131i4429e93fx7da0022791d53b69@mail.gmail.com>
References: <9e4733910607270554p5622ee20ida8c264cf3122500@mail.gmail.com>
	 <20060727195614.7EDAE353B04@atlas.denx.de>
	 <20060728050444.GA30783@spearce.org>
	 <Pine.LNX.4.63.0607281041420.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	 <20060729035632.GC28128@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Wolfgang Denk" <wd@denx.de>, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jul 29 06:31:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G6gTi-0007IR-W4
	for gcvg-git@gmane.org; Sat, 29 Jul 2006 06:31:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161458AbWG2EbD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 29 Jul 2006 00:31:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161460AbWG2EbD
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Jul 2006 00:31:03 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:37439 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1161458AbWG2EbB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Jul 2006 00:31:01 -0400
Received: by ug-out-1314.google.com with SMTP id m3so33683ugc
        for <git@vger.kernel.org>; Fri, 28 Jul 2006 21:31:00 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kPfKOXq6cDRtAfzYEJVtyzNWuqcl4nG3mFT0EEnqO00aHu9Pc/T+S0woMchWFgrwatNd0bqs+L44Dn3PUJ1VMwVIVDacdmAoe3iM5Y3jfXTuuMneA7BI0w2srT89n+QCQTIiHJEZ3Ajwba3W3hKBGYsx5o4nV3imxtk8t02u2Tg=
Received: by 10.78.120.3 with SMTP id s3mr23089huc;
        Fri, 28 Jul 2006 21:31:00 -0700 (PDT)
Received: by 10.78.149.8 with HTTP; Fri, 28 Jul 2006 21:31:00 -0700 (PDT)
To: "Shawn Pearce" <spearce@spearce.org>
In-Reply-To: <20060729035632.GC28128@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24415>

On 7/28/06, Shawn Pearce <spearce@spearce.org> wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > Hi,
> >
> > On Fri, 28 Jul 2006, Shawn Pearce wrote:
> >
> > > [...] as the GPL is incompatible with the Sun JRE runtime lirbary.
> >
> > This is not true. You can legally write and run GPLed software on the JRE
> > runtime library.
> >
> > BTW I found an Eclipse plugin which is GPLed:
> >
> > http://www.eclipseplugincentral.com/Web_Links-index-req-viewlink-cid-651.html
>
> Thanks.  I did a little research on it myself after reading your
> email. I turned up the following two pages from the FSF:
>
>   http://www.gnu.org/licenses/gpl-faq.html#InterpreterIncompat
>   http://www.gnu.org/licenses/lgpl-java.html
>
> Both suggest that I can license everything under the GPL but provide
> exclusions to allow users to run the code against its dependencies
> which aren't GPL'd:
>
>   - the end-user may 'link' the code against any Java runtime library
>     of their choice;
>
>   - the end-user may 'link' the code against any Eclipse platform
>     or derivative of their choice;
>
> So given that I'm seriously considering changing the license to
> GPLv2 for the next version.

Using the GPL plus your own exceptions creates another new license
which is a pain for everyone involved. Why not just use the standard
version with exceptions, the LGPL. The LGPL already allows the two
exceptions listed.

I don't believe there is any legal way to link GPL code into a Java
app since there are no free Java runtimes. This includes both C
libraries and Java code.

GPL is great for a kernel, but it runs into difficulties in user space
where there are hundreds of historical licenses that it can't mix
with. The viral concept only works if the target app has the ability
to relicense which is usually impossible for existing code.

-- 
Jon Smirl
jonsmirl@gmail.com
