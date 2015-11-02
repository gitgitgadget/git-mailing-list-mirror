From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: git log --author=me
Date: Mon, 2 Nov 2015 19:37:09 +0100
Message-ID: <CACsJy8D83-Mg8UHA-=CPJ3z37CQTn7USjEbfO8QcU1T+=tS0Bg@mail.gmail.com>
References: <563764B8.4010101@exec64.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Harry Jeffery <harry@exec64.co.uk>
X-From: git-owner@vger.kernel.org Mon Nov 02 19:37:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZtJzE-0006pv-Ux
	for gcvg-git-2@plane.gmane.org; Mon, 02 Nov 2015 19:37:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754508AbbKBShk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Nov 2015 13:37:40 -0500
Received: from mail-lf0-f52.google.com ([209.85.215.52]:35909 "EHLO
	mail-lf0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753964AbbKBShk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Nov 2015 13:37:40 -0500
Received: by lffz202 with SMTP id z202so65915932lff.3
        for <git@vger.kernel.org>; Mon, 02 Nov 2015 10:37:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=jFCqWN85E/tOtey3H5L6ImKfdgrWX8LCk+8hhlwwzxE=;
        b=ihyqKJTatDj7g0PmJdXr3tOHAZdw8fHUVeE3PHBnWbaLy5BQDLxuobhjJ6U2AT0lqi
         fM9Y2QAJG+uMVdhOM1ktbt/ZfzZCCcnvnS6c5/9bZhoADX0BbSbytDoqd2BX1DJtfOem
         CA46kevQB9UDIKFOHj8Qqw4iQ2F9TfuiRWOfN6vLiYZj3/pz9HUBELZAFunuaWzd307B
         vb5MKKEO9NIjhLKrNn6MdmrG2PGrg/jwSZDK1hhwc+alS475il39G4dOaPhZvHjxO8i/
         tABumVgGYb4HCXUZLhBbIFAGPzmbtxUoVm0WPZrLZMDNDSLBOo91jyYJR2D1oSMz326g
         Dy+g==
X-Received: by 10.25.167.2 with SMTP id q2mr7134692lfe.15.1446489458615; Mon,
 02 Nov 2015 10:37:38 -0800 (PST)
Received: by 10.112.255.229 with HTTP; Mon, 2 Nov 2015 10:37:09 -0800 (PST)
In-Reply-To: <563764B8.4010101@exec64.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280708>

On Mon, Nov 2, 2015 at 2:27 PM, Harry Jeffery <harry@exec64.co.uk> wrote:
> Hi,
>
> I've written a patch that allows `me` to be used as shorthand for
> $(user.name) or $(user.email) in the `--author` and `--commiter` fields.
>
> The purpose being to make finding your own commits quicker and easier:
>     git log --author=me
>

It would be even cooler if it accepts mail aliases, then you can
define "me" to your address and also have shortcuts to a few of your
best friends. Though as Andreas pointed out --author is not a good fit
because it accepts regex, and you can't use --mine either, so more
work..
-- 
Duy
