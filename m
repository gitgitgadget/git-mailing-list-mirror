From: Christian Couder <christian.couder@gmail.com>
Subject: Re: Permission denied ONLY after pulling bundles
Date: Fri, 5 Jun 2015 18:01:14 +0200
Message-ID: <CAP8UFD0gMCnaJnXNxe6Tmwxes7c4Wqgga1d8AzSNEcFxtHtGWg@mail.gmail.com>
References: <CAJeiYQGUsB-9XYdnqDgoSy5JU-EVTbf-1OuTU5BGfpT9q6xKbg@mail.gmail.com>
	<CAP8UFD1=96Y484GvG9ms2uiWm2uyWO0qE2Lh6SH2UwrwHpEF8w@mail.gmail.com>
	<41C6F74EB68C43E183AF26092D2AAD44@PhilipOakley>
	<CAJeiYQH9jF4S6FivHW5xc_xeef5kL1r1xF+yjJuHf7Wa0yUifw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Philip Oakley <philipoakley@iee.org>, git <git@vger.kernel.org>,
	"dario.ligorio" <dario.ligorio@selex-es.com>
To: Rossella Barletta <rossella.barletta@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 05 18:01:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0u3d-0002R3-IA
	for gcvg-git-2@plane.gmane.org; Fri, 05 Jun 2015 18:01:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752968AbbFEQBR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jun 2015 12:01:17 -0400
Received: from mail-wi0-f182.google.com ([209.85.212.182]:36713 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932608AbbFEQBP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jun 2015 12:01:15 -0400
Received: by wiam3 with SMTP id m3so23930447wia.1
        for <git@vger.kernel.org>; Fri, 05 Jun 2015 09:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Or3oDzRY5zJd6iUXsEmSN8kFhWMVo+Kw7yGiN8TQ5Uk=;
        b=Lr9z9quQ78USLlC9gJ1cdTnU5kNHGysSSfhxwvRg1dIWD+CdoQTmOZLrKLby6QbRdm
         tVuUb1R/rWIXNClWPvwkemuPa/iCgIYRIsREdrs1k1kmsEb+CQTwgLHuL8UIRCUqbV9o
         gTs878iZmqH46FLloRJFdfUGvZBoR7ttxaRCvX7VesWqaxZGv34bxUxdqrEk0IZelz29
         sRI7Dt8zRS9LBbZSxJdFo7nSyaoE/cBk7yTFjj7CZD1OPOzPCI2mrtpu1hA7dTkHsINm
         ng/jlZvvmTss1I8GUl3yUj6SauxU7jlTJgf+oPr7S9jDLIIMI92TGHUQWOCEbYLYapm9
         fLpw==
X-Received: by 10.194.237.34 with SMTP id uz2mr7772377wjc.155.1433520074665;
 Fri, 05 Jun 2015 09:01:14 -0700 (PDT)
Received: by 10.194.40.8 with HTTP; Fri, 5 Jun 2015 09:01:14 -0700 (PDT)
In-Reply-To: <CAJeiYQH9jF4S6FivHW5xc_xeef5kL1r1xF+yjJuHf7Wa0yUifw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270844>

On Fri, Jun 5, 2015 at 8:54 AM, Rossella Barletta
<rossella.barletta@gmail.com> wrote:

[...]

> FIST ONE (PERMISSION PROBLEMS)
>
> - Repo is on windows
> - Repo folder is shared
> -Repo is a copy of another repository being on a machine in another
> city on which we cannot access. We got all the files, included the
> folder .git a put everything in our shared folder
> - Mounted the Repo folder on Linux
> -Created the clone
> - got a bundle from the original repository (bundle created from a branch)
> -pulled the bundle in the same branch
>
>
>
> SECOND ONE (NO PROBLEMS BUT WE CANT USE THIS)
> - Repo is on Linux
> -Repo is a copy of another repository being on a machine in another
> city on which we cannot access.
> - got a bundle from the original repository (bundle created from a branch)
> -pulled the bundle in the same branch
>
>
>
> 4) Git version is 1.7.1

It would be nice if you could try to reproduce the problem:

- using a recent Git, as v1.7.1 is 5 years old,
- using a small fake repo,
- doing everything on Windows.

Best,
Christian.
