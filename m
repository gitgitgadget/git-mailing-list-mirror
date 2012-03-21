From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [GSoC] Designing a faster index format
Date: Wed, 21 Mar 2012 10:22:30 +0100
Message-ID: <8D287169-1AD9-4586-BDBC-F820220328FC@gmail.com>
References: <F9D452C3-B11E-4915-A0F2-B248F92CE5DE@gmail.com> <CACsJy8CKqv2P2Co9MKpePfOTwe4fu-wxAYiigbYt3YHTxZ6wWQ@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 21 10:22:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SAHkd-0004Ap-GD
	for gcvg-git-2@plane.gmane.org; Wed, 21 Mar 2012 10:22:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964983Ab2CUJWe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Mar 2012 05:22:34 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:47427 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964794Ab2CUJWd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Mar 2012 05:22:33 -0400
Received: by eekc41 with SMTP id c41so282372eek.19
        for <git@vger.kernel.org>; Wed, 21 Mar 2012 02:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:mime-version:content-type:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to:x-mailer;
        bh=vXSIV6Ugh0qeizZrUOoK1CcJENVCgB5RWMtBbjYG5vs=;
        b=vufhqIZmGwSpluBhORZ0VbOCZqtv3g3HTK/jTUscWmTSiLTIPwXXAocK9xHjl9uuCs
         2P2qIC58McuI7O2STIAU/RvB78lCUV7XXvdqJRY1nkgO70oB/UqaMvkMO/U/Q3iFSzhT
         RgPSVJIkmhLh+AoHCEaaWlwrg0VhEOhRVqVLqgI0HN0nsjWhC6ugO2zy6DhUN7CkBxFz
         gtJDb4SEijyTPth0FaNGykgvmX/pCOX8xS5vOGgH+d/cZ9vugPgn+jK6PA1v3HBOAhvc
         16O1YL1eKigCie+W4UsL/MyWlwLetGlN02FZvFS3lnEfyIqJj3e5lj8PMMO0s25Ud2aF
         gE6w==
Received: by 10.14.194.72 with SMTP id l48mr412132een.100.1332321752370;
        Wed, 21 Mar 2012 02:22:32 -0700 (PDT)
Received: from tommi-mac.unibz.it ([46.18.27.126])
        by mx.google.com with ESMTPS id z47sm3862118een.5.2012.03.21.02.22.31
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 21 Mar 2012 02:22:31 -0700 (PDT)
In-Reply-To: <CACsJy8CKqv2P2Co9MKpePfOTwe4fu-wxAYiigbYt3YHTxZ6wWQ@mail.gmail.com>
X-Mailer: Apple Mail (2.1257)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193561>


On Mar 21, 2012, at 2:29 AM, Nguyen Thai Ngoc Duy wrote:

> On Wed, Mar 21, 2012 at 4:17 AM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
>> There are some questions I would have about the project.
>> Has there already been any development or thoughts in that direction?
> 
> Tree-based format seems to be favored by core developers, for example
> in the footnote in [1]. But there have been no attempts to realize it.
> You may want to search mail archive for more.
> 

Thanks for your answer, so I would probably implement a tree based structure.
However I got one more question, since I'm not yet really familiar with the
code and internal structure of git, what exactly does the SHA1 over the
index exactly achieve? Is it only for checking if the index is still correct
for the next time it is used and has not been changed or is there a more
important function of it?

--
Thomas Gummerer
