From: Frans Klaver <fransklaver@gmail.com>
Subject: Re: git gui does not open bare repositories
Date: Fri, 28 Sep 2012 10:08:20 +0200
Message-ID: <CAH6sp9N1cFH7orPNmfbhgHq6oUNtQNe=-5f5jkYNXzr+6Xp_pQ@mail.gmail.com>
References: <CAB9Jk9CA+e8xR9sz7cW+5+990FmTeYN3pjxs4ZKFpkzb6OL35Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Angelo Borsotti <angelo.borsotti@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 28 10:08:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1THVd4-0002Sr-Lc
	for gcvg-git-2@plane.gmane.org; Fri, 28 Sep 2012 10:08:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755491Ab2I1IIq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Sep 2012 04:08:46 -0400
Received: from mail-qa0-f46.google.com ([209.85.216.46]:51290 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753529Ab2I1IIV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Sep 2012 04:08:21 -0400
Received: by qadc26 with SMTP id c26so4573591qad.19
        for <git@vger.kernel.org>; Fri, 28 Sep 2012 01:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=IlEpWTbQswgd6CgwX3io3yRjeqE/E5jycoPd1PBmiqc=;
        b=eC8na1qR+5DWzg7TRFBbi01CsbU80xb1+Gl0hFRbbMefUvxgVUWW3gXzvsMLuC9NK4
         EBy0Rqhz+x9NxOHDKaeoAUoimKZ/UxQxajIxKi9tW+hfpE3ZAKqSRH3A065xsSJQltSa
         rJrNWgbRI758VSSeoxrKmn5ZRIcOk2MWVuc2kTSnt8s2D6/e2KaQBNIO4RqaIuCbmL6H
         0NLlo5abDOXZEhao3PDj4Ynkr4PUH+mvw8gEJl2/ywMV5ckwDYqaEVb5p/1A4q880L3P
         ec81gU1Bf7SW1TW+YYzzrZQ7X8r2RKWtJ38OyYyp7qTS2E34z2q+AD/UKbvX7o3Fs1WA
         7NBg==
Received: by 10.224.209.8 with SMTP id ge8mr15423376qab.0.1348819700522; Fri,
 28 Sep 2012 01:08:20 -0700 (PDT)
Received: by 10.224.80.141 with HTTP; Fri, 28 Sep 2012 01:08:20 -0700 (PDT)
In-Reply-To: <CAB9Jk9CA+e8xR9sz7cW+5+990FmTeYN3pjxs4ZKFpkzb6OL35Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206544>

On Fri, Sep 28, 2012 at 9:50 AM, Angelo Borsotti
<angelo.borsotti@gmail.com> wrote:

> I have created a bare repository:
>
> $ mkdir remote.git
>
> angelo@ANGELO-PC /d/gtest (master)
> $ git init --bare
> Initialized empty Git repository in d:/gtest/

This creates a bare repository in d:/gtest, not in
d:/gtest/remote.git. You'll need to cd into remote.git to create a
bare repo.


> and then tried to open it with the git gui, but have got the message:
> "remote.git is not a git repository".

So this message is correct.

Be as it may, as soon as you've initialized the repo as required, git
gui will (probably) tell you:

"Cannot use bare repository:

d:/gtest/remote.git"

So nothing gained there. So I'm wondering what you expect git gui to
give you in a bare repo? It seems to me that this tool is specifically
aimed at non-bare repos, allowing for creating commits, merges and
whatnot; all things you cannot typically do in a bare repo.


Frans
