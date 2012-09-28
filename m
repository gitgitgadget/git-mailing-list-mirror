From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Using bitmaps to accelerate fetch and clone
Date: Fri, 28 Sep 2012 08:38:15 +0700
Message-ID: <CACsJy8BCoCqD=CGxbibpUiW2f1D9nn3MPFvRASqad1RPeehSow@mail.gmail.com>
References: <CAJo=hJstK1tGrWhtBt3s+R1a6C0ge3wMtJnoo43Fjfg5A57eVw@mail.gmail.com>
 <CACsJy8D0vkyEArNChXE0igUkanH6PwjmPitq22a9sudfmWF4kA@mail.gmail.com> <20120927172037.GB1547@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Shawn Pearce <spearce@spearce.org>, git <git@vger.kernel.org>,
	Colby Ranger <cranger@google.com>, David Barr <barr@github.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Sep 28 03:39:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1THPXb-0007kL-W0
	for gcvg-git-2@plane.gmane.org; Fri, 28 Sep 2012 03:38:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755601Ab2I1Bir (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Sep 2012 21:38:47 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:32869 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754936Ab2I1Biq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Sep 2012 21:38:46 -0400
Received: by ieak13 with SMTP id k13so6152205iea.19
        for <git@vger.kernel.org>; Thu, 27 Sep 2012 18:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=1BYh2ZQtvSm66sQh6qA6GspYTsq3mZVaxWALAPmfIIA=;
        b=0snHb2+j7Jbf8/o4dWRis+3IkqpmrRC6LXx0gMZcDhECP0TUW5UhKf3K3GQi4eV459
         ZlqrhwGNN3GlHJW9bmyg+SjeOaMWbDQUGwDrdcr0Y6UT9HRCWBo51AOPB/umQKzujaOQ
         Anoi7NTBsgtM6BZmoQoak+yeCMxEvIrZwmoraaefjSKbXEq9d+N/DN9BbPq0rHlnQrfc
         YtessUzMZW1Jasot/0I669aPyDN2YN+8NEZO8L5645Uw7bzUa5Kkf6xU2r9QzmOIezCA
         jfY0qtdPEZHKtb4zy8SlD2NB7x6FBIX+kKa26PhJTq3RsAiIUKinQjqPaeOfy4Ho3EDx
         sIGA==
Received: by 10.50.212.97 with SMTP id nj1mr258221igc.26.1348796325889; Thu,
 27 Sep 2012 18:38:45 -0700 (PDT)
Received: by 10.64.29.199 with HTTP; Thu, 27 Sep 2012 18:38:15 -0700 (PDT)
In-Reply-To: <20120927172037.GB1547@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206533>

On Fri, Sep 28, 2012 at 12:20 AM, Jeff King <peff@peff.net> wrote:
>> Definitely :-). I have shown my interest in this topic before. So I
>> should probably say that I'm going to work on this on C Git, but
>> sllloooowwwly. As this benefits the server side greatly, perhaps a
>> GitHubber ;-) might want to work on this on C Git, for GitHub itself
>> of course, and, as a side effect, make the rest of us happy?
>
> Yeah, GitHub is definitely interested in this. I may take a shot at it,
> but I know David Barr (cc'd) is also interested in such things.

Great. Now I can just sit back and enjoy :)
-- 
Duy
