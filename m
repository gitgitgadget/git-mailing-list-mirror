From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: "git branch HEAD" dumps core when on detached head (NULL pointer dereference)
Date: Thu, 21 Feb 2013 20:32:27 +0700
Message-ID: <CACsJy8B_jfgvneRtF0u=G_bLbb_SKEi4s=T8OPUtcV9a3mK_vw@mail.gmail.com>
References: <512612AD.4000609@opera.com> <CACsJy8CuRvwsbXbcKr7dHneEDF7UmoG4ioCxfDi_7qWDD-4wgQ@mail.gmail.com>
 <51261FF9.2090304@opera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Per Cederqvist <cederp@opera.com>
X-From: git-owner@vger.kernel.org Thu Feb 21 14:33:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U8WH5-0004sE-4B
	for gcvg-git-2@plane.gmane.org; Thu, 21 Feb 2013 14:33:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752309Ab3BUNc6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Feb 2013 08:32:58 -0500
Received: from mail-oa0-f53.google.com ([209.85.219.53]:46465 "EHLO
	mail-oa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751725Ab3BUNc5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Feb 2013 08:32:57 -0500
Received: by mail-oa0-f53.google.com with SMTP id m1so9251408oag.12
        for <git@vger.kernel.org>; Thu, 21 Feb 2013 05:32:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=li43Wi+aYmbxBksmF97M6p/IFaWVoIkITYTxZ+fGfc8=;
        b=FKZuDmxbHjpQOJ/sk1XbLP1m3KrxO9kOA9P4XGhkRFdWIJDP9b85/xA8BX014Yb1Xn
         8mOCDR7shMX350ad4qQZy/xpCMDmSGp52UyXzuw+nBAWilHIBVIK2RzzKvBqyGl0wZq3
         WBdoDLsLMfGvwtbpbzz8iBRDD4R73dBmxZOjafmDaptKNfrk8DLozvfyx/Mlgu8gEx1Y
         bE2LsLC6ndqJRwpQo3D+HPQd0xhplSdRbJ6tgAZNdg5Sg5XkOcgaGmJQNRqSqpegRbMm
         s2ve3GGoqwOEBxhf51lsVftR8uPxf7F+sqq9R95IgQpvHK7VYIw86eDKiB22s8o1CsPJ
         aPLQ==
X-Received: by 10.60.1.129 with SMTP id 1mr10681920oem.93.1361453577066; Thu,
 21 Feb 2013 05:32:57 -0800 (PST)
Received: by 10.76.154.197 with HTTP; Thu, 21 Feb 2013 05:32:27 -0800 (PST)
In-Reply-To: <51261FF9.2090304@opera.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216773>

On Thu, Feb 21, 2013 at 8:24 PM, Per Cederqvist <cederp@opera.com> wrote:
> Sorry, but isolating the issue reporting it here is about as much time
> as I can spend on this issue. Learning the coding standard of Git and
> how to write test cases is not something I'm prepared to do, at least
> not at the moment. I hope there is a place for users and reporters of
> bugs in the Git community.

Sure. No problem. I just thought you might want to finish it off. I'll
look into it.
-- 
Duy
