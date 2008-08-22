From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: nicer frontend to get rebased tree?
Date: Fri, 22 Aug 2008 13:56:39 -0400
Message-ID: <32541b130808221056l75a3fd6bsa6c7933a1c3da60f@mail.gmail.com>
References: <20080822174655.GP23334@one.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Andi Kleen" <andi@firstfloor.org>
X-From: git-owner@vger.kernel.org Fri Aug 22 19:57:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWatO-0001kc-Pm
	for gcvg-git-2@gmane.org; Fri, 22 Aug 2008 19:57:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751965AbYHVR4m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2008 13:56:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751094AbYHVR4l
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Aug 2008 13:56:41 -0400
Received: from mail-gx0-f16.google.com ([209.85.217.16]:50126 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1749667AbYHVR4k (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2008 13:56:40 -0400
Received: by gxk9 with SMTP id 9so1416296gxk.13
        for <git@vger.kernel.org>; Fri, 22 Aug 2008 10:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=3qIANrUvFCfpmJv6an5f5sA/DH6q8+ES9oo92TbG1vE=;
        b=nt5i0kRIY4Ssgx3Z1D4YawwDpp0Ip0g5q943MLk0OAx7byvAThr6ZT1f8SKLQqc56N
         +TZmG8LL24GXZkhG0PTRDiDxns+tGq0g4yFZd/0aKUYdlKx0pi0SZbzmGJ+VxNDOTsd2
         t3Qtf2gJLTYokkWDRe7JEvZ5/gDjx54W1i8Vs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=v84w2og8n40uIhX6PLbce3D3SHRmFdCB/whSq0QfFgKxuDmQtLo73LNMpUz+kIqYgt
         CuXjdUAewSAFK6tEejNnRVIK9iW4LgbOM4p7+jQinmNV43q5J4VaXoGa04yyPNQZebzR
         WPU5BgZYejyTglGRDLjZVeY+gB0+6GqVWGYH8=
Received: by 10.151.51.18 with SMTP id d18mr2234203ybk.96.1219427799415;
        Fri, 22 Aug 2008 10:56:39 -0700 (PDT)
Received: by 10.150.98.19 with HTTP; Fri, 22 Aug 2008 10:56:39 -0700 (PDT)
In-Reply-To: <20080822174655.GP23334@one.firstfloor.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93337>

On Fri, Aug 22, 2008 at 1:46 PM, Andi Kleen <andi@firstfloor.org> wrote:
> But I presume that's a reasonable common usage. Would it
> make sense to have some standard git sub command that does that?
> ("get latest state of remote branch, doing what it takes to get it")
> Or is there already one that I missed?

Isn't that just

    git fetch somewhere branchname
    git reset --hard FETCH_HEAD

?

Have fun,

Avery
