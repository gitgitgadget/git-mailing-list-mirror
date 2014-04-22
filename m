From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Project idea: github-like diff view
Date: Tue, 22 Apr 2014 16:59:17 +0700
Message-ID: <CACsJy8DnJeZ-43Ydg_j00CO6=6NOA1wdzQ+EwCX6idrUOLn8gA@mail.gmail.com>
References: <CACsJy8CQxPrqs31nBvr_oPRD3EJ6Hu-Lq=++7nWpxx5BQZYi8Q@mail.gmail.com>
 <20140420144620.GA16596@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Apr 22 11:59:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WcXUa-0006yJ-8R
	for gcvg-git-2@plane.gmane.org; Tue, 22 Apr 2014 11:59:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755260AbaDVJ7u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2014 05:59:50 -0400
Received: from mail-qg0-f54.google.com ([209.85.192.54]:37610 "EHLO
	mail-qg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754929AbaDVJ7s (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2014 05:59:48 -0400
Received: by mail-qg0-f54.google.com with SMTP id z60so5120428qgd.27
        for <git@vger.kernel.org>; Tue, 22 Apr 2014 02:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=6i6CiBxhQzR46p+PkcvYRaUfcUn30Dh90cueHa49yig=;
        b=Rx72fSAb54PcJfzpO7dDV2mMbG93MmFXw3V1plMm2MwBs7GSfZCPW6FWAKY5vddBaJ
         n50AUzfvUaxpJaiza/qDjiut2fbLOLAfNQ3EKJqQVObtj/la7g45qmO7PqIP2d7GwgH0
         QEQkOtkbeGHUO9wSVtiZtfpoIAKivUu1w4hLTOGtTtCLbgP2GWukYMCRNK2+/9Khup3N
         6N2JSiSitiDoNsmGTsvVmsNZ+vfOZVxQySqmMRQg1lLRkwxxMxwZfj2WHp4ogsxbFKQ0
         LzaGCzW13mlIxyM0tXetwzYC6QWHOc2T/lsGj9VEKtz8H0sZDXyTOCZg7oOiLOJjLVQT
         D8EQ==
X-Received: by 10.229.176.72 with SMTP id bd8mr45905679qcb.12.1398160787111;
 Tue, 22 Apr 2014 02:59:47 -0700 (PDT)
Received: by 10.96.138.9 with HTTP; Tue, 22 Apr 2014 02:59:17 -0700 (PDT)
In-Reply-To: <20140420144620.GA16596@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246724>

On Sun, Apr 20, 2014 at 9:46 PM, Jeff King <peff@peff.net> wrote:
> On Sun, Apr 20, 2014 at 04:58:28PM +0700, Duy Nguyen wrote:
>
>> - --color-words within unified diff format, using background color to
>> show what part of the line has changed. This is only enabled for
>> 1-line changes.
>
> See contrib/diff-highlight.

Thanks. I'd rather have it built in core git still. I'll try to see if
I can rewrite it in C. Else, any objection to promote it to a core
helper and setup pager automatically? We can have a config key to turn
it off, but if git diff is colored, then it could be on by default.
-- 
Duy
