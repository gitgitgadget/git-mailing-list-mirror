From: Tony Wang <wwwjfy@gmail.com>
Subject: Re: [PATCH] Copy resolve_ref() return value for longer use
Date: Sun, 11 Dec 2011 10:28:53 +0800
Message-ID: <AA4A611395C84795932A33DE2F2FF32B@gmail.com>
References: <CACsJy8Aw4_O_GMiK_D=HTENfxGUXTTzCHqM7FkriqU+mQtVWtA@mail.gmail.com>
 <1320719428-1802-1-git-send-email-pclouds@gmail.com>
 <7vehxcpns5.fsf@alter.siamese.dyndns.org>
 <CACsJy8ARAzNWjZfXwnNG0AprCFXLCkiDrE+eFj9icbeNX14xKw@mail.gmail.com>
 <7vobwgo3l5.fsf@alter.siamese.dyndns.org>
 <626C086D699644D181B9FA573EDFFCA6@gmail.com>
 <CACsJy8Bg1=ESaZq8WQmZufsb6E8DY4RHqG0TWG-7uFX671zO6Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 11 03:29:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZZA9-0007w8-Rd
	for gcvg-git-2@lo.gmane.org; Sun, 11 Dec 2011 03:29:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751406Ab1LKC3E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Dec 2011 21:29:04 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:65144 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751289Ab1LKC3B (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Dec 2011 21:29:01 -0500
Received: by iaeh11 with SMTP id h11so1025870iae.19
        for <git@vger.kernel.org>; Sat, 10 Dec 2011 18:29:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:message-id:in-reply-to:references:subject:x-mailer
         :mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=7ZL0oTNY6SNDYEuVpy7GMkIzGsy85j6TYfss5k3z5ys=;
        b=xbrae1jMcGVVLXwqJ7i9+NW59h66dx8qEMxm3tokSkGwtBJbAuJr4R4HLAkQ9CxSnh
         WdY4nCNh7p6wn4nTJRzDBS93LSNHar4S8JZBKW3P0Hu8mLGeR5Q9E4rC8oGYaPxZ7wy0
         qdjgO7BwqepG6PlLLmOlibS8CJYP259zPfb7s=
Received: by 10.50.212.40 with SMTP id nh8mr3446235igc.34.1323570541060;
        Sat, 10 Dec 2011 18:29:01 -0800 (PST)
Received: from tony-mac.local (wwwjfy.net. [68.68.99.210])
        by mx.google.com with ESMTPS id r18sm10046073ibh.4.2011.12.10.18.28.56
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 10 Dec 2011 18:28:59 -0800 (PST)
In-Reply-To: <CACsJy8Bg1=ESaZq8WQmZufsb6E8DY4RHqG0TWG-7uFX671zO6Q@mail.gmail.com>
X-Mailer: sparrow 1.5beta1 (build 1034)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186797>

Just notice that, thanks. :)


-- 
BR,
Tony Wang


On Saturday, December 10, 2011 at 12:48, Nguyen Thai Ngoc Duy wrote:

> On Sat, Dec 10, 2011 at 10:43 AM, Tony Wang <wwwjfy@gmail.com (mailto:wwwjfy@gmail.com)> wrote:
> > Hi,
> > 
> > I don't know about the procedure, but wonder is any one following this?
> 
> This series has been merged in master. I'll resend patches to rename
> resolve_ref() to resolve_ref_unsafe() soon.
> -- 
> Duy
