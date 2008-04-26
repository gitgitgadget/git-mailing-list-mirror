From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: Merge *to* branch instead of merge *from* branch?
Date: Sat, 26 Apr 2008 19:17:32 -0400
Message-ID: <32541b130804261617y1fb2a8d9jf8fc6f58ca07b44f@mail.gmail.com>
References: <alpine.DEB.1.00.0804270037220.1149@perkele.intern.softwolves.pp.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Peter Karlsson" <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Sun Apr 27 01:18:31 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jptf0-00083D-70
	for gcvg-git-2@gmane.org; Sun, 27 Apr 2008 01:18:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753109AbYDZXRi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Apr 2008 19:17:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753010AbYDZXRi
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Apr 2008 19:17:38 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:27085 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752139AbYDZXRh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Apr 2008 19:17:37 -0400
Received: by fg-out-1718.google.com with SMTP id l27so4249222fgb.17
        for <git@vger.kernel.org>; Sat, 26 Apr 2008 16:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=ocjYaNP+KXcaQW6a2kVP3tTav1/FjwZWt4ONXfo8H4Q=;
        b=xgQpr+HBSEwvGnGLB4B5czS3bFhUSUewxHEHpctyaGdAMXxoz1XWcFqSDyrkh560Hp3xKBWYhu8kLvJcq1G5eSKj8jxTkbUj2za8shlBeTIZ3NmeYZZUi0CqDZs0H+taPMwxJPTHYWE2gV7M3K/xFo3vdFaHPbZ+b0vfizt74IE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rHRMkONGzHW+I857zo1N6erxpP/Wbe/AyYdea2ADrcbOX0nljNUE83/jWMw/rtZl3SUTT/jpzaTvvtiM+jAg2dWhmJBpSWyOjAiEkWawI0s7KlPKPanHL/FSKRO1MgDiRuo9oVmpGR7RjiZy4b3wgiIF1yssFX5yF2mqSVkDVVI=
Received: by 10.82.183.19 with SMTP id g19mr3138188buf.80.1209251852281;
        Sat, 26 Apr 2008 16:17:32 -0700 (PDT)
Received: by 10.82.166.12 with HTTP; Sat, 26 Apr 2008 16:17:32 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0804270037220.1149@perkele.intern.softwolves.pp.se>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80397>

On 4/26/08, Peter Karlsson <peter@softwolves.pp.se> wrote:
>  Is there any way of not having to do the "git checkout master" first?
> Basically I want a flag to merge or checkout saying that I want to merge my
> branch into the branch I'm switching to. I can't seem to find any such flag.

How about this?

git merge master
git branch -D master
git branch master HEAD

In other words, just make a copy of your current branch after merging
and call it the new 'master'.  That's all fast forwarding would do
anyhow.

Have fun,

Avery
