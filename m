From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: sparse checkout syntax does not work in git version 1.9.5.msysgit.0
Date: Wed, 25 Feb 2015 21:06:21 +0700
Message-ID: <CACsJy8ByEn+Ed6qaBMdjrunghVtCHoEMisj6V8=ezaMKx3aDOg@mail.gmail.com>
References: <1424731264183-7625887.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: samt <sam777t@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 25 15:06:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YQcc5-0004Sg-Q7
	for gcvg-git-2@plane.gmane.org; Wed, 25 Feb 2015 15:06:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752166AbbBYOGx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Feb 2015 09:06:53 -0500
Received: from mail-ig0-f172.google.com ([209.85.213.172]:52940 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751848AbbBYOGw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Feb 2015 09:06:52 -0500
Received: by mail-ig0-f172.google.com with SMTP id l13so35576912iga.5
        for <git@vger.kernel.org>; Wed, 25 Feb 2015 06:06:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=UKV1QiYcczvg1hPzivbdrVtrIiDSNcXiYy2kLVOUNSs=;
        b=KSQFRn7+IS3SV8qIpO8E4omZnjxTKY9L8EVN4B461zeVpjWrmf7ESdW7I7mljgSXF0
         0uSlS6ciSz9RKNHiHvA6AY3YKFTn0ukcAXz2ig8JFMwg5sN3GMlWPvGPlEkF/kn7cMnZ
         g0ZvYbeqaMZcbHfkeekEz+kJoIJhbGsmFWA1x615vyYNIXL4ePgT0g2kQnL+81m+rOQT
         04KJpjtJAowWQ8Orot2eZ2Ymi3QEaGfGS4iJULMuPcowZAHLTcwd2sjV1Z3f5htwiTgZ
         D879RuV0UB42iF1LMurLaeMls/KXn3BOxmb4zq6MxofJEpnjnDvHjD7FPxIYroUCHkAB
         4W3A==
X-Received: by 10.107.170.220 with SMTP id g89mr4564484ioj.31.1424873212031;
 Wed, 25 Feb 2015 06:06:52 -0800 (PST)
Received: by 10.107.131.155 with HTTP; Wed, 25 Feb 2015 06:06:21 -0800 (PST)
In-Reply-To: <1424731264183-7625887.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264394>

On Tue, Feb 24, 2015 at 5:41 AM, samt <sam777t@gmail.com> wrote:
> The platform is Windows server 2008
> Git version is 1.9.5.msysgit.0
>
> I have a repository and I want EVERYTHING in the repository to be checked
> out into the workspace EXCEPT one directory.  I have a machine with  git
> version 1.7.8.msysgit.0 and the following syntax in
> .git/info/sparse-checkout file works fine:
>
> /*
> !engine/testdata/scenarios

It works for me. I rebuilt v1.9.5.msysgit.0 on linux and tested that
version. I changed line ending to cr/lf and it was still ok. Are you
sure there's no trailing spaces in that file? Maybe you can copy that
file to another test repo, rename it to .gitignore and see if it
ignores files correctly.

> This syntax does not seem to work with 1.9.5.msysgit.0  version. I have
> tried to alter the syntax based on some suggestions on the internet, but
> none of the combinations work. Git still attempts to checkout the directory
> that I do not want.  Does anyone know what syntax works for version
> 1.9.5.msysgit.0 ? Thanks.
--
Duy
