From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Staging Individual Lines
Date: Sun, 21 Apr 2013 18:52:52 -0500
Message-ID: <CAMP44s0Mj+inGX24=-RuV+oT5MZB==HZZvu6_5uZrP68qdPoZw@mail.gmail.com>
References: <517466B9.8010607@blueyonder.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: ode <ode5002@blueyonder.co.uk>
X-From: git-owner@vger.kernel.org Mon Apr 22 01:53:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UU44G-0001RO-7i
	for gcvg-git-2@plane.gmane.org; Mon, 22 Apr 2013 01:53:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751717Ab3DUXwy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Apr 2013 19:52:54 -0400
Received: from mail-lb0-f182.google.com ([209.85.217.182]:62502 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751222Ab3DUXwy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Apr 2013 19:52:54 -0400
Received: by mail-lb0-f182.google.com with SMTP id z13so5158974lbh.13
        for <git@vger.kernel.org>; Sun, 21 Apr 2013 16:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=8PsthJN0hgS1XCjUY6ykJ9Rok6dMdueVsebxIwbk3d0=;
        b=1Jhl/oGRKOZLD1uQOTVjutz3KHBqP0f088PC2jh9Xkohr8nEJcTSCnhgiGncj4W+ie
         ibZ6E/8So1xey7/ig3v2jSk6x1BCYQvP5tRTQzsSq6jQg1Q5OqE2gfFSyCZajI5qx0Gw
         TqnhVwVtdTRLwh4Bht55GudWGZ/5ygXZ6uWRViqoTB/ZW4dcRXRSiWsDTB4jD0k5D6lC
         MBDkYjoXXQz9NlN4DpGWvAt82AF9KmShuXixiE11csFxQPijIk6LElCZV5A5YhYIP1OJ
         CIHcGT4knXWE6W4Qf3EHVzfHX0uCQgTdxI3b1OumA+NcL01kijzm6mOkBgRWYgSj/yzs
         qdww==
X-Received: by 10.152.6.162 with SMTP id c2mr11998018laa.20.1366588372723;
 Sun, 21 Apr 2013 16:52:52 -0700 (PDT)
Received: by 10.114.83.167 with HTTP; Sun, 21 Apr 2013 16:52:52 -0700 (PDT)
In-Reply-To: <517466B9.8010607@blueyonder.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221984>

On Sun, Apr 21, 2013 at 5:22 PM, ode <ode5002@blueyonder.co.uk> wrote:
> Hi,
>
> I had a big commit I wanted to break up and was wondering if there is
> any way to stage individual lines from the command line.
>
> I am using git add -i but it couldn't split the hunks any smaller.
>
> I went looking on Google and found git-cola gui client which works for
> staging individual lines to the commit.
>
> But it's a bit clumsy to do this with the mouse and I was wondering if
> there is a way to do this without having manually editing the file and
> changing the diff numbers in git add -i when it can't break the hunks
> smaller.
>
> Why must we still manually edit the diff numbers when git-cola seems to
> be able to work out the changes automatically when adding single lines?

There is an 'edit' option. 'git add -p' might be faster.

Cheers.

-- 
Felipe Contreras
