From: "Nigel Magnay" <nigel.magnay@gmail.com>
Subject: Re: [PATCH] Teach git submodule update to use distributed repositories
Date: Thu, 17 Jul 2008 13:21:28 +0100
Message-ID: <320075ff0807170521s26693381m60648468cce1c41c@mail.gmail.com>
References: <320075ff0807170508j3d3c1ef8j49df576fc47debe2@mail.gmail.com>
	 <alpine.DEB.1.00.0807171311010.8986@racer>
	 <320075ff0807170520r200e546ejbad2ed103bd65f82@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 17 14:22:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJSVB-00036v-V1
	for gcvg-git-2@gmane.org; Thu, 17 Jul 2008 14:22:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756656AbYGQMVb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jul 2008 08:21:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756495AbYGQMVb
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jul 2008 08:21:31 -0400
Received: from yx-out-2324.google.com ([74.125.44.28]:5260 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753118AbYGQMVa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jul 2008 08:21:30 -0400
Received: by yx-out-2324.google.com with SMTP id 8so1943354yxm.1
        for <git@vger.kernel.org>; Thu, 17 Jul 2008 05:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=f3bzDyRcln2M6e67bX/DLhG2dmZHkHCOIQWGzj5WfCY=;
        b=XDdquDJk0szIwJ2sUtu8TGafGi9m8lqqXQkO413isf5NV077fcivb6lFT4NHxkEt5p
         uy3e/xXxWY/eoSHJVN2TXXprZf1jaIXt2T8DCF8wE6s5WTameuOnkdIAs96q5k7K7UIK
         b/6GyaaHodXAhnxDoYnV06BohAm5ZGFVJCl/g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=dBhNASS6aXJMjBA2uyb4BlPkT3yPXGzGT6Oq1nS5HHnKeHhNcXmYtPGN4BUVFi8b4M
         H78MqRiKn5omhASu2HVdLBINPJW9LDk23v0gIoGzlWIgLAxv5PRPKQEQbCZTOBJ6WuvQ
         hsyU71yWmQyywYzjGYT0GVPpA9aYG4qZgEhk0=
Received: by 10.103.20.7 with SMTP id x7mr1867115mui.75.1216297288474;
        Thu, 17 Jul 2008 05:21:28 -0700 (PDT)
Received: by 10.103.246.15 with HTTP; Thu, 17 Jul 2008 05:21:28 -0700 (PDT)
In-Reply-To: <320075ff0807170520r200e546ejbad2ed103bd65f82@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88839>

On Thu, Jul 17, 2008 at 1:13 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Thu, 17 Jul 2008, Nigel Magnay wrote:
>
>> When doing a git submodule update, it fetches any missing submodule
>> commits from the repository specified in .gitmodules.
>
> Huh?  It takes what is in .git/config!  Not what is in .gitmodules.
>

Huh? And where does .git/config get it from? Oh, that's right, .gitmodules.

> So if you have another remote (or URL, e.g. if you have ssh:// access, but
> the .gitmodules file lists git://), just edit .git/config.
>

So for my usecase, you'd have me go in and change *evey single one* of
my submodule refs from the centralised repository, *every time* I want
to do a peer review?

Doesn't the current system strike you as being somewhat centralised in nature?

> I meant, that is the whole _point_ of having a two-step init/update
> procedure.
>

Are you just determined that submodules should remain useless for "the
rest of us"?

> Ciao,
> Dscho
>
