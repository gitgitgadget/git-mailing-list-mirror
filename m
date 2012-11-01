From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Segmentation fault in git diff
Date: Thu, 1 Nov 2012 08:58:40 +0700
Message-ID: <CACsJy8BTC30ipX=5y-53pF6H0TQvy-DAO8pQiZV2+J=3cwVUqA@mail.gmail.com>
References: <CAOomjNvLrC1N3T+KrVPzXFC-Efxr2meE1-jwT8V3ZQae7CPy6A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: aurelijus@astdev.lt
X-From: git-owner@vger.kernel.org Thu Nov 01 02:59:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TTk45-0006pm-Og
	for gcvg-git-2@plane.gmane.org; Thu, 01 Nov 2012 02:59:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752273Ab2KAB7N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Oct 2012 21:59:13 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:52277 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751182Ab2KAB7M (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Oct 2012 21:59:12 -0400
Received: by mail-oa0-f46.google.com with SMTP id h16so2124589oag.19
        for <git@vger.kernel.org>; Wed, 31 Oct 2012 18:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=1ZIUK67izZWStf3dxLVJXNyxWBTB6DKccqLQYmM7+9k=;
        b=TSHCv5xOMK/8XJScJ/iZoNQ/qTm0WYpgF39jvp7OubfbZBuM/YqFJhnzMSYFmO9aIo
         97uPRNc3lCYmR45UFKgz6llnkH4E6Ra4K+VnLoK7gdFXtXIb/6q8NA+yQA97fFkrDtrj
         028381M/GoMATn7amoh1VpfenAE/E/joe8cFNCQ1WHEXrl8E2o3puvz55LPzUQOJu0t6
         269PSdwaQt+4WcYbrOWaG8xZFzUAQ9myyu/1B172ezeQlAyNmnW3UTWLdynUm+ZLsWgv
         6OswfUY7BAHvL07t1FOXPh4jnLN0oMyyY2Of8ajYo9CESzcLk44lwyB/IFkscD4Jl9n2
         /A2A==
Received: by 10.182.179.100 with SMTP id df4mr32463198obc.59.1351735151160;
 Wed, 31 Oct 2012 18:59:11 -0700 (PDT)
Received: by 10.182.55.161 with HTTP; Wed, 31 Oct 2012 18:58:40 -0700 (PDT)
In-Reply-To: <CAOomjNvLrC1N3T+KrVPzXFC-Efxr2meE1-jwT8V3ZQae7CPy6A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208859>

On Thu, Nov 1, 2012 at 12:41 AM,  <aurelijus@astdev.lt> wrote:
> Hey,
> I'm getting "Segmentation fault (core dumped)" when running command:
> git diff -n1 -M -C -B --find-copies-harder --raw -t --abbrev=40
> 'd8c10caae6db3914695c3bc91cc7852777727625'^1
> 'd8c10caae6db3914695c3bc91cc7852777727625'

Where can we get these commits?
-- 
Duy
