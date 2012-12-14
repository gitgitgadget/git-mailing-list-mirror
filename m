From: David Michael <fedora.dm0@gmail.com>
Subject: Re: Build fixes for another obscure Unix
Date: Fri, 14 Dec 2012 14:48:52 -0500
Message-ID: <CAEvUa7nP=yWZTLLoSRN_gucrj_eDhCz5ki3DMsHd+_c6ci14CA@mail.gmail.com>
References: <CAEvUa7nn9M5np3wD=Z1152K4pwNGhSKkC=rS9U=yc=UcaOxMCw@mail.gmail.com>
	<871B6C10EBEFE342A772D1159D13208539FF9088@umechphg.easf.csd.disa.mil>
	<CAEvUa7nNNYREAsxc==tfg+e1XNZFbDVOpGXE6z-7+SfbqNrp6Q@mail.gmail.com>
	<kaem06$3go$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Dec 14 20:49:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TjbFv-0007ey-Jj
	for gcvg-git-2@plane.gmane.org; Fri, 14 Dec 2012 20:49:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756687Ab2LNTsy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Dec 2012 14:48:54 -0500
Received: from mail-vb0-f46.google.com ([209.85.212.46]:50321 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754461Ab2LNTsx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Dec 2012 14:48:53 -0500
Received: by mail-vb0-f46.google.com with SMTP id b13so4486599vby.19
        for <git@vger.kernel.org>; Fri, 14 Dec 2012 11:48:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=NaII3LFPbfIkI2p2DquyBZMwzwtMMY6Bu+lNwP6+t1Y=;
        b=aHnpQT3cwBHDSv/x4/uHter8D1byTWhBJI/rEm9/XxTKrvwGjTtHH/th30GpA6P49G
         LZ9Q0O2h5jDa/eBCJkkfznQq4+yjuQRVgNMsUjBLDyNHniqEnx3o43YO3erweGSwrEDJ
         4zDX8dk8hlO8FtBSNHwLd7PV1gAgF6EM4/ZQPmtUE8ifClf+c7Fki8qNrnp1wSg9U6KG
         c+MBTw7FIZJP9tg9oQ9k9pwO4KGLdFrZcKn0Dl0UN4WLkG7RJ2w8+CnxD99OtHZ+ZaO6
         sKMR/fJnNZw7Q9eHJlBmBDfnCy10NuW0xJthm34OztZH2DYyeYXnQoRVG+MfnHAVBZYi
         auQg==
Received: by 10.59.13.197 with SMTP id fa5mr11244923ved.47.1355514532975; Fri,
 14 Dec 2012 11:48:52 -0800 (PST)
Received: by 10.58.85.138 with HTTP; Fri, 14 Dec 2012 11:48:52 -0800 (PST)
In-Reply-To: <kaem06$3go$1@ger.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211499>

Hi,

On Fri, Dec 14, 2012 at 2:54 AM, Joachim Schmitz
<jojo@schmitz-digital.de> wrote:
> For what's it worth: I ACK your HP-NonStop patch (as you can see by my
> comment in git-compat-util.h I was thinking along the same line)
> https://github.com/dm0-/git/commit/933d72a5cfdc63fa9c3c68afa2f4899d9c3f791e
> together with its prerequisit
> https://github.com/dm0-/git/commit/301032c6488aeabb94ccc81bfb6d65ff2c23b924
>
> ACKed by: Joachim Schmitz <jojo@schmitz-digital.de>

Okay, thanks for verifying.  Especially since another port needing
that header was just sent to the list, I'd prefer to see some
generalized feature test rather than building and maintaining an
explicit OS list.

No one has suggested any adjustments, so I'll send out those patches now.

Thanks.

David
