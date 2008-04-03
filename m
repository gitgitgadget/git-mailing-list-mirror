From: "Jonathan del Strother" <maillist@steelskies.com>
Subject: Re: [REGRESSION] git-gui
Date: Fri, 4 Apr 2008 00:15:39 +0100
Message-ID: <57518fd10804031615m5c299df6hf31de3c689e16521@mail.gmail.com>
References: <007901c89590$a827f7c0$93a7c10a@LGE.NET>
	 <57518fd10804030700r6de977f5p6f0418e6eaea2583@mail.gmail.com>
	 <200804032304.17054.barra_cuda@katamail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	"=?ISO-8859-1?Q?Andr=E9_Goddard_Rosa?=" <andre_rosa@lge.com>
To: "Michele Ballabio" <barra_cuda@katamail.com>, spearce@spearce.org
X-From: git-owner@vger.kernel.org Fri Apr 04 01:16:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JhYfS-0005w3-F5
	for gcvg-git-2@gmane.org; Fri, 04 Apr 2008 01:16:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753441AbYDCXPk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 Apr 2008 19:15:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753228AbYDCXPk
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Apr 2008 19:15:40 -0400
Received: from rv-out-0910.google.com ([209.85.198.190]:21327 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752657AbYDCXPj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Apr 2008 19:15:39 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1864060rvb.1
        for <git@vger.kernel.org>; Thu, 03 Apr 2008 16:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        bh=8oavSYI4L+JMWghObqto42pijbW5cjhHcKjRsa8W7NE=;
        b=m984Es6wyyhN41HsdweKBmHc7wSLVi+jJ9kILj9pwjdTXjX9jwAhkOOZWGdV75AnPrS4fXaPaZQWW0mcGYl2S+sybzEAgVod4lQpRqotmDejhallH4kY91cZm8+W2qik5qiLuPhUwbJSM8bsEmueiiF8WRc81NoF+Np0cZjDuKM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=OBB7igiEoGKL967eeGqb3y/4l1dkWy2kBdeADSAFPQGVZ8sznR1/5UtikCH6PoNziflHpLJGpNee3Rei4StQlaWLx1nXCljVTufIxvcbj2NO/zjWMm4Eq1AThr71cCf39oQJ7u3bOa+O7S+poufcclShlGAVKmXiAEvU88dbENI=
Received: by 10.140.139.3 with SMTP id m3mr296416rvd.38.1207264539161;
        Thu, 03 Apr 2008 16:15:39 -0700 (PDT)
Received: by 10.141.86.15 with HTTP; Thu, 3 Apr 2008 16:15:39 -0700 (PDT)
In-Reply-To: <200804032304.17054.barra_cuda@katamail.com>
Content-Disposition: inline
X-Google-Sender-Auth: f8e78c0a3115dcc0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78786>

On Thu, Apr 3, 2008 at 10:04 PM, Michele Ballabio
<barra_cuda@katamail.com> wrote:
>
> On Thursday 03 April 2008, Jonathan del Strother wrote:
>  > On Thu, Apr 3, 2008 at 2:43 PM, Andr=E9 Goddard Rosa <andre_rosa@l=
ge.com> wrote:
>  > > Hi, all!
>  > >
>  > >     After updating to git version 1.5.5.rc3 I always get the err=
or below
>  > >  when starting "git gui".
>  > >     Linux distributions used are opensuse 10 and opensuse Factor=
y.
>  > >
>  > >  # git gui
>  > >  Error in startup script: bad event type or keysym "["
>  > >     while executing
>  > >  "bind $ui_comm <$M1B-Key-\[> {show_less_context;break}"
>  > >     file "/usr/bin/git-gui" linux 2718)
>  > >
>  > >     I think it's related to git-gui 0.10 recently added into the=
 tree.
>  >
>  > Doh, I broke git :(
>  >
>  > The problem is in c91ee2bd61 (Add shortcut keys for Show More/Less=
 Context).
>  > Works fine on my OS X 10.5 installation with tcl 8.4.7 - can anyon=
e
>  > suggest an alternative way of binding the left/right brackets?  I'=
m
>  > not familiar with Tcl, and didn't manage to find a list of key nam=
es.
>
>  These changes should help (haven't tried):
>         \[ -> bracketleft
>         \] -> bracketright
>  but some European keyboards do not have easy access to brackets, so
>  other keys would be preferable (comma and period, for example, or 1 =
and 2).
>
>  See
>         man keysyms
>  for a list of key names.
>

Anyone else got any opinions on an appropriate shortcut?  How about
'=3D' and '-' (+ and - without the shift), or are those not necessarily
together either?  (Are there really layouts where '[' and ']' aren't
next to each other?)
