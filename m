From: David Ebbo <david.ebbo@gmail.com>
Subject: Re: Seeing high CPU usage during git-upload-pack
Date: Thu, 10 May 2012 13:41:11 -0700
Message-ID: <CAPeUw3HyCz921upWA3YBtJXTOKTcdP5tDxUv3drR7=aovJ07_g@mail.gmail.com>
References: <CAPeUw3EsFCxki6obAAeVBb0g4MKNWBteL3VueG5djbajkFiv3A@mail.gmail.com>
	<CACsJy8DMm0ZNiQYQ1CvOfDJu5ogP42Y06792iA_xyzeHDGLJaw@mail.gmail.com>
	<CAPeUw3HCkKKBP6RnZzR0TYOO0hHtJ4_ma-Je4a-xKhPpNPJhHw@mail.gmail.com>
	<CACsJy8CbaM6UNCT3ZP0=VZE9GhH2eJpgKe-dnGU5ubn_4gS=Pw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git Mailing List <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 10 22:41:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSaAp-0000us-6a
	for gcvg-git-2@plane.gmane.org; Thu, 10 May 2012 22:41:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757304Ab2EJUlO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 May 2012 16:41:14 -0400
Received: from mail-qc0-f174.google.com ([209.85.216.174]:45374 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757300Ab2EJUlM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 May 2012 16:41:12 -0400
Received: by qcro28 with SMTP id o28so1525832qcr.19
        for <git@vger.kernel.org>; Thu, 10 May 2012 13:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=iESUwu/Elo91rL/yswP2HuzOGj8H8RmZQz+Zf4fAJqs=;
        b=xQwpBLCd+JYYCnn3TEho4JWe1IPuEwLvJqX2ZPhZ0E7pTwCKYpeVT2mzwxrGLwh8P3
         ZW79zIyPl6Pn2WJcayfP0YopR1D9c8n8sHRY8ZPvbqSIwsCV7PKyS+Rh5448H94ZkM8y
         aviosxequb9knYcmdG7Ze1cIrZaMna+ostZir9WS+mt3B6lKVueIImTHlcfxA+Kg68DH
         lVa4YEHPHFa8hPRM9OoMLo4o9VMxhwbN4QwDw4ysO0ZIVvytzSZiXF4n87V4bEysAA3v
         40tyZGNMVA8cfsSUQq1DUST186FSwARO/cD3XdUhCMWeIsNjzTgfod8ddEglKP0/FBjK
         hNBw==
Received: by 10.224.73.1 with SMTP id o1mr14131124qaj.43.1336682471815; Thu,
 10 May 2012 13:41:11 -0700 (PDT)
Received: by 10.229.238.8 with HTTP; Thu, 10 May 2012 13:41:11 -0700 (PDT)
In-Reply-To: <CACsJy8CbaM6UNCT3ZP0=VZE9GhH2eJpgKe-dnGU5ubn_4gS=Pw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197632>

On Wed, May 9, 2012 at 8:11 AM, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
>
> Ah... msysgit reimplements poll() function, in compat/win32/poll.c. If
> it goes rouge, you could get an active loop. But this is just my
> suspicion. I don't know anything about msysgit's poll implementation
> so I can be completely wrong here.
>

Sorry for the delayed replay, and thanks for pointing out that this is
msysgit specific and not general to all platform. I guess the next
step is to discuss it on their forum (msysgit@googlegroups.com).

thanks!
David
