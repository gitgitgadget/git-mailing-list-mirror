From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: recovering from "unordered stage entries in index" error
Date: Tue, 26 May 2015 20:37:23 +0700
Message-ID: <CACsJy8CqSERT+MXnU89gmSD-U9RBgRnQVyz2LAHFbCAxW-MESw@mail.gmail.com>
References: <D377A9280DB18546A2471214D5CBB0E908599428C7@exchdb01>
 <CACsJy8AS-9Cv6V=OKTckpnqd6OGsmvRy17TLoikT4QkA0sRofg@mail.gmail.com>
 <xmqqwq01kh8r.fsf@gitster.dls.corp.google.com> <CACsJy8Bdx5tto0w1q7rZ1ORx8RmHZCEKPyBqYs37k=YvbO3kzA@mail.gmail.com>
 <D377A9280DB18546A2471214D5CBB0E9087568F47B@exchdb01> <CACsJy8As8-b6kWHDnmAwAftyPG6X-BmoQdToQywzn9D4dtg2Fg@mail.gmail.com>
 <D377A9280DB18546A2471214D5CBB0E9087568F592@exchdb01> <CACsJy8B=ttGa1aBKTdZAe6bLN4rbEE1r3fA+ifNNvUWhYD0Yfg@mail.gmail.com>
 <D377A9280DB18546A2471214D5CBB0E9087568F735@exchdb01>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: "McHenry, Matt" <mmchenry@carnegielearning.com>
X-From: git-owner@vger.kernel.org Tue May 26 15:39:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YxF4M-00067H-0m
	for gcvg-git-2@plane.gmane.org; Tue, 26 May 2015 15:38:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755068AbbEZNil (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 May 2015 09:38:41 -0400
Received: from mail-ig0-f180.google.com ([209.85.213.180]:34190 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932298AbbEZNiE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 May 2015 09:38:04 -0400
Received: by igbhj9 with SMTP id hj9so59604363igb.1
        for <git@vger.kernel.org>; Tue, 26 May 2015 06:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=SPfyp0HoArpGimxya7Nn1xn/yuNBDma6f4NYgPYZHsc=;
        b=wIGDx5sde8/2fDgLZme3PvxtOt6bSeVQGlN7ShPhjkPkJM9/A7N4iH75e5x+KvfFZC
         jfLvHI6ui97OsSS3nbaZgvTWIy/nRsDchmDiHtMuD90NOproOvPgZpKQcsw6Yh+LYj5d
         NsnlbS00fdR5Yn4Q0Z6puQj1tNy1ZUAv7Ipa1g73pEBYlgJRaruJ71f9TJcFWBgNvOT6
         c68XJHSlNuZcfmfL7vBY5jhU2Cd60apbJTas7SJzJS+wD8fINVgb0kNxUrLvpz8VfoBh
         rhlSikyDiWaSYgim8g+6emD51zRFS8dq9wRu4etqYeGmvFVA6ghrlsxlWx8z+qmMYKpm
         +kxA==
X-Received: by 10.42.76.146 with SMTP id e18mr30983309ick.42.1432647474143;
 Tue, 26 May 2015 06:37:54 -0700 (PDT)
Received: by 10.107.181.136 with HTTP; Tue, 26 May 2015 06:37:23 -0700 (PDT)
In-Reply-To: <D377A9280DB18546A2471214D5CBB0E9087568F735@exchdb01>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269938>

On Tue, May 26, 2015 at 8:28 PM, McHenry, Matt
<mmchenry@carnegielearning.com> wrote:
>> see these commands, or something else. Could you try again with
>> GIT_TRACE=/absolute/path/to/some/where instead of GIT_TRACE=2 and post
>> the content of /abso../some/where?
>
>         It looks the same as far as I can see:
>
> $ GIT_TRACE=/tmp/git-trace git svn fetch
> fatal: unordered stage entries in index
> write-tree: command returned error: 128
>
> $ egrep -i 'read|tree|update|index' /tmp/git-trace
> 13:26:08.169921 git.c:348               trace: built-in: git 'write-tree'

OK I give up. Can't think of how the index is written, and by whom.
-- 
Duy
