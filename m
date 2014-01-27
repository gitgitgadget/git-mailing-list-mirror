From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: What's with git blame --reverse ?
Date: Mon, 27 Jan 2014 21:15:47 +0700
Message-ID: <CACsJy8CCZxKYW=AAz-OsKxrjNo2NyqUQF=NJXH20hv4miFUs8g@mail.gmail.com>
References: <87y5218ufn.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Mon Jan 27 15:16:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W7mz8-0004JA-9P
	for gcvg-git-2@plane.gmane.org; Mon, 27 Jan 2014 15:16:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753545AbaA0OQS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Jan 2014 09:16:18 -0500
Received: from mail-qa0-f50.google.com ([209.85.216.50]:55877 "EHLO
	mail-qa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753366AbaA0OQR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jan 2014 09:16:17 -0500
Received: by mail-qa0-f50.google.com with SMTP id cm18so7180026qab.23
        for <git@vger.kernel.org>; Mon, 27 Jan 2014 06:16:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=NRL4qk8zfjfWzXskWtArvpeNAGWSQ+FS2249TKLmfhY=;
        b=b57kxAAY+vHzOheFjg8Efehre+4moNwRXACvOT9ZSYmt71HqOHXVuk0aGh5sZHF1du
         8EYYnLnwmOBGtCmioN6PTeUlSC7hyn2PzydIvPYqMfAQy0r5A1v+Zz/JlgblMIwsWxKj
         SnMDHMVIwz/fpB1V02CMseSWjzikrrdFNfLMzAG+Js9ZAO4AroQ9/VmGvFpOnfFZm0RM
         8lSaUxxHbxH5firNd5r1YUVVvXU7yrTiOM8JfgEAg1a4d03HzezGh4ko/Bq+58yyAlxM
         zx3/tRXdYEBTRrgFYd/TSEU5R3eBkK7ITwzAGp26Y1Qy+uJs3iIK7b+tfVK77ldptBJt
         7NXQ==
X-Received: by 10.224.36.129 with SMTP id t1mr43094063qad.8.1390832177316;
 Mon, 27 Jan 2014 06:16:17 -0800 (PST)
Received: by 10.96.136.98 with HTTP; Mon, 27 Jan 2014 06:15:47 -0800 (PST)
In-Reply-To: <87y5218ufn.fsf@fencepost.gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241136>

On Mon, Jan 27, 2014 at 7:45 PM, David Kastrup <dak@gnu.org> wrote:
>
> The git blame manual page talks about using git blame --reverse to
> figure out when a particular change disappeared, but I cannot make it
> produce anything useful regardless of what range I give it.  Using
> --root delivers a different state of uselessness.
>
> Can anyone give a recipe for using git blame --reverse on the Git code
> base for figuring out anything of relevance?

I rarely use blame, but the commit that introduces --reverse seems to
have an example. See 85af792 (git-blame --reverse - 2008-04-02)
-- 
Duy
