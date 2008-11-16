From: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCH] gitk: try to set program icon
Date: Sun, 16 Nov 2008 03:14:25 +0100
Message-ID: <cb7bb73a0811151814va151c32ud5e940820ff92011@mail.gmail.com>
References: <1226792745-18408-1-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Paul Mackerras" <paulus@samba.org>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 16 03:15:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L1XAw-0006dz-G4
	for gcvg-git-2@gmane.org; Sun, 16 Nov 2008 03:15:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753614AbYKPCO2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Nov 2008 21:14:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753592AbYKPCO1
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Nov 2008 21:14:27 -0500
Received: from ey-out-2122.google.com ([74.125.78.25]:35547 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753400AbYKPCO1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Nov 2008 21:14:27 -0500
Received: by ey-out-2122.google.com with SMTP id 6so786254eyi.37
        for <git@vger.kernel.org>; Sat, 15 Nov 2008 18:14:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=Ydaz++Xlw+oK63xZeLSKXIpGdds/qpZr5l1Ror6PQbw=;
        b=iRK3G+8g6my9Dy6VOu0KHrWIFIlCPXr0ZFe9T4CxED37fmqw3np2MgtOBPzoglmWrz
         eRGZOU3tdGLWr6HVlhcOSZRNVlXxHL/xYy1rSViiLr98gCttD0tCD6GQt71Q3pLQFDmn
         3ExsVDTK8CY5rdxLkoOf5h+2WNi8PORlfxVUU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=j4FjwerlGfMxIHgiXEN/giyGhPek6AikXuJVJBNA4hzUE5hQiGThD7r0rdpxFf7qys
         1aOQ5Ntmu0ti3eyuTUwGfU8J9qNvS1wQ5Q3PAiZJquvz9dhZCGzN3FC7QOp0KDmUguRv
         mlRHcTFuUBlA37+pDUi3ecnmMHMvJuVWBab90=
Received: by 10.210.12.18 with SMTP id 18mr526273ebl.53.1226801665651;
        Sat, 15 Nov 2008 18:14:25 -0800 (PST)
Received: by 10.210.132.16 with HTTP; Sat, 15 Nov 2008 18:14:25 -0800 (PST)
In-Reply-To: <1226792745-18408-1-git-send-email-giuseppe.bilotta@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101112>

On Sun, Nov 16, 2008 at 12:45 AM, Giuseppe Bilotta
<giuseppe.bilotta@gmail.com> wrote:
> We add the git icon in three formats (.xbm, .ico, .ppm), which we try to
> set as window icon.

[snip]

Scratch this. I've seen how it's done in git-gui, and I think that's a
better way to do it. I've provided a patch for git-gui to introduce
the icon under X, so I'll just use something like that, maybe using wm
iconphoto for all platforms.

-- 
Giuseppe "Oblomov" Bilotta
