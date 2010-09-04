From: Ramana Kumar <ramana.kumar@gmail.com>
Subject: Re: inaccurate commit message message?
Date: Sun, 5 Sep 2010 08:55:49 +1000
Message-ID: <AANLkTi=Vb2cQHPo388m9HYVdYkk3XC_-pM9bm182PWyf@mail.gmail.com>
References: <AANLkTinbq8z-ygVUWPRq9PA95-+8O8SwOJCLkfMKCg9T@mail.gmail.com> <AANLkTinGNss5siAjpic07OB036y8K0kvBjSj=unDhQWs@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 05 00:56:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Os1ei-0000xC-8K
	for gcvg-git-2@lo.gmane.org; Sun, 05 Sep 2010 00:56:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754005Ab0IDW4L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Sep 2010 18:56:11 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:34067 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753765Ab0IDW4K (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Sep 2010 18:56:10 -0400
Received: by wyf22 with SMTP id 22so1490479wyf.19
        for <git@vger.kernel.org>; Sat, 04 Sep 2010 15:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=N3xkz0jVenrF2Yo3G1C+bNQXXOYQORNABuFhPtZYGa8=;
        b=pQx7vU+7nhmoLDFxrRZEOPZT/+0qTY90ZuQ3mywv5O29O6KPLVz1wMPsbXa1gRMCkd
         g5ouVTJHQJIUwbo+igu+X/kUAs+DX4IKKUILGFkVPG4zF+l9R+pt7e3W413XIX6RDM8R
         4+HeUaDahQPwxKKq2caYvXFu7E9s6DYjH1umo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=mAbpTLs8/gyRusaKDJVEp/8IZNqKcj0wQdY92B9sg7fDEsjLgdalO0CP9RdOswymNT
         wkfgaT1RnNrGNT/pm5xBVzpTbkSEwGU09E1VwAU3qnsvLfQGCu5cbkdT5Jy0cwqgeNXg
         00rNLJAC6AAqMeWZ2pUyDQus0DbQ5rw4lK7DY=
Received: by 10.227.133.72 with SMTP id e8mr139398wbt.71.1283640969196; Sat,
 04 Sep 2010 15:56:09 -0700 (PDT)
Received: by 10.216.25.9 with HTTP; Sat, 4 Sep 2010 15:55:49 -0700 (PDT)
In-Reply-To: <AANLkTinGNss5siAjpic07OB036y8K0kvBjSj=unDhQWs@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155384>

On Sun, Sep 5, 2010 at 7:55 AM, Sverre Rabbelier <srabbelier@gmail.com> wrote:
> Heya,
>
> On Sat, Sep 4, 2010 at 16:37, Ramana Kumar <ramana.kumar@gmail.com> wrote:
>> The commit message message says "Lines starting with '#' will be
>> ignored", but fails to say "Lines below this message will be ignored,
>> even if they don't start with '#'".
>
> Because they're not. Only those starting with # are ignored.
>
>> If the second sentence is true, I think it (or something equivalent)
>> should be said, especially because of the relevance during commit
>> --verbose.
>
> It is not true.
>
>> In fact the documentation for commit --verbose explicitly says to note
>> that the diff lines won't start with '#'s, as if warning people that
>> those lines might show up in the commit message.
>> Yet they do not seem to show up... (and I don't think they should)
>
> Ah, you are apparently talking about 'git commit --verbose'. It works
> a little different there, all lines starting with # are ignored, as
> well as everything in and after the diff.

The documentation, both in man git-commit and in the commit message
message, is misleading when you do git commit --verbose.
My proposal is to make it less misleading, by saying in at least one,
and ideally both, of those places what you just told me for the first
time: when you do a git commit --verbose, the diff lines and
everything after will be ignored for the commit message.

>
> --
> Cheers,
>
> Sverre Rabbelier
>
