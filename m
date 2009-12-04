From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: How do you best store structured data in git repositories?
Date: Thu, 3 Dec 2009 20:45:21 -0500
Message-ID: <32541b130912031745i60dc918dk3e510ef1a3b28526@mail.gmail.com>
References: <1259788097.3590.29.camel@nord26-amd64> <32541b130912021317y705d1d4cj28e230a3e727df2e@mail.gmail.com> 
	<20091204001359.GA6709@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: sebastianspublicaddress@googlemail.com, git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 04 02:45:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NGNEw-0003BR-Tp
	for gcvg-git-2@lo.gmane.org; Fri, 04 Dec 2009 02:45:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754760AbZLDBpg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Dec 2009 20:45:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754742AbZLDBpf
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Dec 2009 20:45:35 -0500
Received: from mail-pw0-f42.google.com ([209.85.160.42]:35223 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753564AbZLDBpe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Dec 2009 20:45:34 -0500
Received: by pwi3 with SMTP id 3so1672355pwi.21
        for <git@vger.kernel.org>; Thu, 03 Dec 2009 17:45:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=uQDm3IWXhSIAW+DKkxqdCqwAEaTnrWWGwG8kAl4odmI=;
        b=JQ4dM0AgNGH+BcGtloc7vysDhO3j0suZ5Lcovep06YtTnk4UEwswOmeLMPLOdDDCX9
         BsVDBKNyXTNjVY0NjvMDKqvT7kjRprW4tPMbuGZccqYr3onfX0SSrUekxc0LP4q+GQTZ
         cVPYD7Y64ADc/KHfqbPX+GQOG3rYKTv65pOTM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=Nx9ec0cun/ytVtU0Y92BXIieX3Xn3Stp4+Hwwp3NDYmOFPR4a90f0n/BBCA75AmYMI
         dnI5nnESnynRx64NKA98WZ8IFlk4iVGRQn1nwbAhqAWrHOrEUT8blvF/9GGsNikHzsoB
         joiWgGZ6Gg2qQ4ibuwvlox/GrGfYPJKBchMhw=
Received: by 10.140.126.13 with SMTP id y13mr145252rvc.247.1259891141103; Thu, 
	03 Dec 2009 17:45:41 -0800 (PST)
In-Reply-To: <20091204001359.GA6709@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134489>

On Thu, Dec 3, 2009 at 7:14 PM, David Aguilar <davvid@gmail.com> wrote:
> JSON's not too bad for data structures and is known to
> be friendly to XML expats.
>
> http://json.org/

yaml is also really good for storing structured data, and its
line-by-line format lends itself to easy merging (if you don't feel
like writing a custom merge algorithm).

Have fun,

Avery
