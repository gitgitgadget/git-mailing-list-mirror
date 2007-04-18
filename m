From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: git-format-patch for binary files / merges [Re: Expose subprojects as special files to "git diff" machinery]
Date: Wed, 18 Apr 2007 13:49:46 +0200
Message-ID: <81b0412b0704180449k34ac2606w82b8557d7d05945f@mail.gmail.com>
References: <Pine.LNX.4.64.0704151100550.5473@woody.linux-foundation.org>
	 <200704152116.26773.andyparkins@gmail.com>
	 <Pine.LNX.4.64.0704151402130.5473@woody.linux-foundation.org>
	 <4625DAEE.3090702@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
	"Andy Parkins" <andyparkins@gmail.com>, git@vger.kernel.org,
	"Junio C Hamano" <junkio@cox.net>
To: "Sam Vilain" <sam@vilain.net>
X-From: git-owner@vger.kernel.org Wed Apr 18 13:49:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1He8fd-0003Yw-HS
	for gcvg-git@gmane.org; Wed, 18 Apr 2007 13:49:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422889AbXDRLts (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Apr 2007 07:49:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422890AbXDRLts
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Apr 2007 07:49:48 -0400
Received: from an-out-0708.google.com ([209.85.132.250]:23081 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422889AbXDRLtr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Apr 2007 07:49:47 -0400
Received: by an-out-0708.google.com with SMTP id b33so148255ana
        for <git@vger.kernel.org>; Wed, 18 Apr 2007 04:49:46 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=cd2BJBG318ilNBhvOtIQZQGeK2yumUt87XvLM2IiXwDa0B0D+ntSxvpVtoRaV/v3d8mrmM5kgq1SHU2UTVJ/3Dn1xkEOmU5ecLoJ6kfGAE43wHNGoBYlpWYgnHhRPlf7j/olcMf2GWJojlj1tPC/3o7rs4n2EqLOtNXu1YKu6c4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=CaCA4P4ju7Vwtx2qMQmdyWvPtCmFQKeR5yqAHh91Hl+hWSB8BHpUrJsdo+dOfl12prMoMG5mOAZqV2xVZk/rGNJjpaD0m7VwGRmRYXcZ8ukxzjqzFEHZDSubYSkQ0jqMT/a1dNoOrUa5c6mlRjH1JnJGf8H+lzJ02WGYItcUFxI=
Received: by 10.100.120.5 with SMTP id s5mr277288anc.1176896986516;
        Wed, 18 Apr 2007 04:49:46 -0700 (PDT)
Received: by 10.100.86.19 with HTTP; Wed, 18 Apr 2007 04:49:46 -0700 (PDT)
In-Reply-To: <4625DAEE.3090702@vilain.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44890>

On 4/18/07, Sam Vilain <sam@vilain.net> wrote:
> Linus Torvalds wrote:
> >> Isn't this dangerous because it looks just like a normal diff with a
> >> file being rewritten, when in truth it is a tree entry record being
> >> rewritten.
> >>
> > Well, that's exactly what symlinks do too.
> >
> > You have to look at the mode to know what the rewriting *means*.
> >
> > But yeah, I wouldn't object at all to making it an "extended git header"
> > instead (possibly just for subprojects, possibly for symlinks too)
> >
>
> Speaking of 'custom' patch file formats, anyone put any thought to a
> format for the commits which can't be represented with patch, like
> binary files and merges?
>

There is binary diff (look for --binary in Documentation/).
And regarding merges: have you looked at git-bundle yet?
