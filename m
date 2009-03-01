From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: jgit and ignore
Date: Sun, 1 Mar 2009 09:31:44 -0500
Message-ID: <9e4733910903010631p51f9d4a7xddf9d823ff848bde@mail.gmail.com>
References: <9e4733910902280831j70448ce9h7239f14e13b92b76@mail.gmail.com>
	 <20090228172622.GC26689@spearce.org> <49AA5F64.6070207@pelagic.nl>
	 <9e4733910903010454u662eb5afob45f608321660500@mail.gmail.com>
	 <49AA884D.1050806@pelagic.nl>
	 <9e4733910903010608u1777f0d4j843f12551154f962@mail.gmail.com>
	 <49AA9A05.6010404@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Ferry Huberts (Pelagic)" <ferry.huberts@pelagic.nl>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>
To: =?ISO-8859-1?Q?Tor_Arne_Vestb=F8?= <torarnv@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 01 15:33:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LdmjQ-00071P-QF
	for gcvg-git-2@gmane.org; Sun, 01 Mar 2009 15:33:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754729AbZCAObs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 1 Mar 2009 09:31:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752980AbZCAObr
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Mar 2009 09:31:47 -0500
Received: from mail-gx0-f174.google.com ([209.85.217.174]:44514 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751960AbZCAObq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 1 Mar 2009 09:31:46 -0500
Received: by gxk22 with SMTP id 22so4008985gxk.13
        for <git@vger.kernel.org>; Sun, 01 Mar 2009 06:31:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Hh1vYqE8Szfqs5R/go7vRH8fNZ+SV/FrAeLwFJUkuTM=;
        b=yFCABM4ifNGzWRk4iD6QvkP9zpYTmbaVqDkxL/h6fzCMYf7DPFMuRAD+YQi51rMeeA
         a35IK9lYlTAGS2OhvH8FmfDRF0TGVqMws09u+KGc/V0AkRHhJvTFlID9X/WA43wJWOwc
         g/0MlvMlyV3kwmCIqGLSi5z3p8lq35YsFvHOI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=TSuGYFImmgKeeq9L1m/qpMMplEFuFgaQxIq5j04eQz70Oq+5QaOsTXmWSYrt5Qlb9p
         EqsR7OOMUgNnVIMX/L9MEZotZ24dNEBinAbU+hTa5WPic5C+yGeVH4tVOe+Di5WVFXeD
         mgJ04brbdEU9qw0S1UJSrAi25sytkf2jryhbI=
Received: by 10.220.97.147 with SMTP id l19mr1414214vcn.8.1235917904140; Sun, 
	01 Mar 2009 06:31:44 -0800 (PST)
In-Reply-To: <49AA9A05.6010404@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111847>

On Sun, Mar 1, 2009 at 9:21 AM, Tor Arne Vestb=F8 <torarnv@gmail.com> w=
rote:
> Jon Smirl wrote:
>> I have a C/C++ perspective open right now. Navigator is on the left,
>> editor in the middle, outline on the right. In the navigator there a=
re
>> several files that should be ignored. I'd like to right click on the=
m
>> and select team/ignore. When I do that they will be ignored in git a=
nd
>> also disappear from my navigator.
>
> That would be Team->Add to .gitignore, as Eclipse does not have a way=
 to
> add files to the global ignore from context menus, but I agree, we
> should have something like that eventually.
>
> If we were to also remove ignored files from the views we would have =
to
> either add a View Filter for .git-ignored files, or for globally igno=
red
> files. Good idea for enhancement, please report in the issue tracker:
>
> =A0 =A0http://code.google.com/p/egit/issues/
>
>> I also don't like how I have a global .git for all of my projects
>> instead of a .git for each project individually. (Did I select that
>> when I first installed egit and didn't know what I was doing?) Now I=
'm
>> in a mess and can't publish individual projects.
>
> That's a result of choosing "Create repository in project's parent
> directory" when you shared the project in Eclipse.
>
> Perhaps we should try to detect if the project is a Java (/JDT) proje=
ct,
> or otherwise likely to be a "child"-project, where it makes sense to
> have the repository in the parent directory?

My .git got created in my workspace root. Is there ever a case where
you would want .git in your workspace root? If not, remove this choice
when the parent directory is the workspace root.

>
> Tor Arne
>
>



--=20
Jon Smirl
jonsmirl@gmail.com
