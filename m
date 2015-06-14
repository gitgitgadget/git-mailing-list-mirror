From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Failed assertion in pathspec.c
Date: Sun, 14 Jun 2015 17:30:29 +0700
Message-ID: <CACsJy8AJJyJkECxn-DgqRQa4eE0wDAtf0C984psea-x7bFTmaw@mail.gmail.com>
References: <20150613191839.3585effd@SaMobile> <CACsJy8DX9ZnUiFvyLwrhG=BDtXr333WpK5y0Axd0-6grOOf6aA@mail.gmail.com>
 <20150614122158.4f8042ca@SaMobile>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Sami Boukortt <samiboukortt@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 14 12:31:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z45By-0005Yn-0h
	for gcvg-git-2@plane.gmane.org; Sun, 14 Jun 2015 12:31:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751524AbbFNKbC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Jun 2015 06:31:02 -0400
Received: from mail-ig0-f176.google.com ([209.85.213.176]:33897 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750845AbbFNKbA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jun 2015 06:31:00 -0400
Received: by igboe5 with SMTP id oe5so11468968igb.1
        for <git@vger.kernel.org>; Sun, 14 Jun 2015 03:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=iDWqsQfG7I8m23N+BPPhbv37S8oVHh5kxUmu8JSIZwU=;
        b=PHSLwyuSBoeRJOoiALiLTATnlSqpeADrtO7s/V2a+WI0mRNHEdlSAhUQHENopzoYv6
         +v13xHVvquTP1TIk9C3T5gKqHJrMDrMVwQGBQ1IxHQkk71ODuvnRrxt4KBUPXb3bQfgf
         nLTdxqp8G/Jjui8h8ZbnJAZv8RT+uHxgoqvKqAYhwXu2pvFbsjJnhiSpnK6C+jVbd/Ui
         l5BhsI/CVNhopPAsRtHrgDE2MAcRt2QaPMshWlCAHRXpZf3w2wXWb0LvCZ4vO95WyN5l
         f1MA8sTvETVZyo9i4ukFOOAsmUCnCYDzzTodbgrKQyaYZDdLVlNiMT2c/pfoV4SOp6II
         v2Yw==
X-Received: by 10.50.29.40 with SMTP id g8mr14295288igh.41.1434277859995; Sun,
 14 Jun 2015 03:30:59 -0700 (PDT)
Received: by 10.107.6.9 with HTTP; Sun, 14 Jun 2015 03:30:29 -0700 (PDT)
In-Reply-To: <20150614122158.4f8042ca@SaMobile>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271635>

On Sun, Jun 14, 2015 at 5:21 PM, Sami Boukortt <samiboukortt@gmail.com> wrote:
>> On Sun, Jun 14, 2015 at 12:18 AM, Sami Boukortt
>> <samiboukortt@gmail.com> wrote:
>> > git: pathspec.c:317: prefix_pathspec: Assertion
>> > `item->nowildcard_len <= item->len && item->prefix <= item->len'
>> > failed.
>>
>> Known issue, but no one stepped up to fix it yet
>>
>> http://thread.gmane.org/gmane.comp.version-control.git/267095
>
> Oh, I see. Sorry for the duplicate report.

No, it's actually good. It reminded me about this bug again. Maybe
I'll do something about it :)
-- 
Duy
