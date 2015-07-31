From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Confused about sparse vs untracked-cache
Date: Fri, 31 Jul 2015 18:28:58 +0700
Message-ID: <CACsJy8A9qcw+jCa+F5nOS2CMWMdnAVXwAkWxHiNdSyiMWFqWiA@mail.gmail.com>
References: <1438223527.18134.53.camel@twopensource.com> <CACsJy8C_PUq4htCSF=qUJ0HNWf-E4RGXJ2FuzbRhSRhLN2vrRg@mail.gmail.com>
 <1438299008.18134.59.camel@twopensource.com> <1438319612.18134.60.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git mailing list <git@vger.kernel.org>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Fri Jul 31 13:29:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZL8VN-00025P-2S
	for gcvg-git-2@plane.gmane.org; Fri, 31 Jul 2015 13:29:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751880AbbGaL3d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Jul 2015 07:29:33 -0400
Received: from mail-io0-f181.google.com ([209.85.223.181]:36509 "EHLO
	mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751857AbbGaL3c (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Jul 2015 07:29:32 -0400
Received: by ioeg141 with SMTP id g141so82492474ioe.3
        for <git@vger.kernel.org>; Fri, 31 Jul 2015 04:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=MbK+yl+ZQzCQKxruonz0LrSKh+zkOjAyoYB/YIgxuro=;
        b=B7OXFOX2yq+t3Xg128O5GxLL9rBm7SpW8kVfWUxeY2ROZu+591z/wdt23Y2FQPFT5h
         QDyEl/XK6urny+S51XC5Mlr+iOpCLg0aphkSoFP0agjqX75KgmoNurubVI9i300B6Uso
         hkp8xV9ZV6aKsD2jHqigOOZdLK+wCDX31ZCEnulFkftxGmmOWq0VkVrrftVwg7ZM3jIy
         /Fyh2a6F9fInvM1Hag6TYDf/ps60IJhFBHmAtNE4jFDkcywsLRqJ8CBE/rlbZWxhHyn5
         IVZnrLhM5RwrM/x1bi+z6DKbt9CxywEBI333LZvkozIwB2QelGd829dbi33xQrNSNlOu
         bqag==
X-Received: by 10.107.15.210 with SMTP id 79mr3820655iop.192.1438342168050;
 Fri, 31 Jul 2015 04:29:28 -0700 (PDT)
Received: by 10.107.191.193 with HTTP; Fri, 31 Jul 2015 04:28:58 -0700 (PDT)
In-Reply-To: <1438319612.18134.60.camel@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275047>

On Fri, Jul 31, 2015 at 12:13 PM, David Turner <dturner@twopensource.com> wrote:
> I should mention that other than that, skip-worktree + untracked cache
> seems to work fine.

Please go ahead and make a patch to allow it. I'll spend some more
time looking at this code. But I think it'll be fine.
-- 
Duy
