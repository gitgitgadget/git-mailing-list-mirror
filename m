From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Wrap commit messages on `git commit -m`
Date: Sat, 3 Nov 2012 01:07:22 +0530
Message-ID: <CALkWK0n3nvu4neica==bXaGCtDish8cfUhcsmJT0w3ihrq6coA@mail.gmail.com>
References: <CALkWK0kQ+qCsOa87yY4wma279mp+9h+LFv3qCP_qrNdDyGNcsQ@mail.gmail.com>
 <m3a9v170ca.fsf@black.gullik.net> <CAO54GHDRBDyQYvo-g_xEvsQJRgtfbbT-4-kop8hoSK1D37G44w@mail.gmail.com>
 <20121101221203.GE6213@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Kevin <ikke@ikke.info>,
	=?UTF-8?Q?Lars_Gullik_Bj=C3=B8nnes?= <larsbj@gullik.org>,
	git <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 02 20:38:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TUN43-0007CF-60
	for gcvg-git-2@plane.gmane.org; Fri, 02 Nov 2012 20:37:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751419Ab2KBThq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Nov 2012 15:37:46 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:35153 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751195Ab2KBTho (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Nov 2012 15:37:44 -0400
Received: by mail-wg0-f44.google.com with SMTP id dr13so2609397wgb.1
        for <git@vger.kernel.org>; Fri, 02 Nov 2012 12:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=thLfClXhpogFz6jQX91Y7mApcHFM6GR1jw5Ur9ieuHQ=;
        b=pZB+jN9XL1tCm23B1kzcuWRjpz7+5vRnOoZqjY0yjaw1dcauRQhBkXSl4pV+8DjBxp
         0LKqGO2Ep/2/pFSJbyFrKkYz6JYstq8iJMgd7OmWWoLuE/HqnB/NuhnVJ6fs6YA1S9q0
         wxXE3rEFgOoToppvz8x6mueCQiuLPOo5gfp5AZF88kezVODtKsAXYRy6kFdIJQLNTgi6
         q76gAVGgdUtSAjrSFy895QiO2baLhNSkBEjR+7n+EQ89y3pnJAKT/kgcwsDzDalk9izw
         YFL+enkU6VfxeJBrDJ6rqWcqced0oZbvS1THNMAzctiKqXZ3mRHMU9yhnb8u5qBJwFeb
         vJ7g==
Received: by 10.216.200.163 with SMTP id z35mr960093wen.53.1351885063456; Fri,
 02 Nov 2012 12:37:43 -0700 (PDT)
Received: by 10.217.69.201 with HTTP; Fri, 2 Nov 2012 12:37:22 -0700 (PDT)
In-Reply-To: <20121101221203.GE6213@elie.Belkin>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208969>

Jonathan Nieder wrote:
> Kevin wrote:
>
>> As I see it, the problem is not the possibility to add new lines, but
>> colleagues being too lazy to add them.
>
> I suspect the underlying problem is that we make it too hard to tell
> git which text editor to run.

Don't we just use $EDITOR?

> Ram, what platform do your colleagues use?

Red Hat Enterprise Linux 5.

Ram
