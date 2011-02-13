From: "Vasyl'" <vvavrychuk@gmail.com>
Subject: Re: [PATCH 0/4] clean-up store_updated_refs
Date: Sun, 13 Feb 2011 20:37:21 +0200
Message-ID: <AANLkTi=fN+cDjgDqLKas5n0iCAetRTAZfnPqcgyeYoX0@mail.gmail.com>
References: <1297550311-17723-1-git-send-email-vvavrychuk@gmail.com>
	<AANLkTi=k9z67zmG6qBCh2uQWiofNceqs2erZ74XQARYq@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 13 19:37:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PogpF-0006aW-1b
	for gcvg-git-2@lo.gmane.org; Sun, 13 Feb 2011 19:37:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754731Ab1BMShX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Feb 2011 13:37:23 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:36349 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754676Ab1BMShW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Feb 2011 13:37:22 -0500
Received: by bwz15 with SMTP id 15so4817136bwz.19
        for <git@vger.kernel.org>; Sun, 13 Feb 2011 10:37:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:content-type;
        bh=6nVVtqgcUskXdty5HbEioFP7B9qQ+grSgxYciYfYA2c=;
        b=m2LuRQK0BYktHHRTHQBiN3dxLqFYB6UTN4n7NF3OQDU/SaiH5Y5fdSsPHVwBJXyDqC
         oEjpmozq1OOf0d3wRRXs1/4AtbnhQuItM0M4jsYPtuNYBWiVFHBG8J/SSN2SCxS9wMNU
         3YtHFIwZp0hZJZ4eu/38fg7pe1a1g9Xf4si+E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        b=BIYwCvL3IEUfhVN8odWsGXP09L1XFc1/w0OKD85a9ImTDp4OY6LMZbEv7L5mvxRdae
         vh1yqGec0V7qWvoRl0oTDW6lO56uHO+Ir13ji1hPGgLPQrEbLIgzPtq7HOXngnS8lWan
         b3kgyxClNeW8HIMgLt2khxnmZ+yhXgJGBVtwo=
Received: by 10.204.76.1 with SMTP id a1mr2623894bkk.5.1297622241138; Sun, 13
 Feb 2011 10:37:21 -0800 (PST)
Received: by 10.204.179.84 with HTTP; Sun, 13 Feb 2011 10:37:21 -0800 (PST)
In-Reply-To: <AANLkTi=k9z67zmG6qBCh2uQWiofNceqs2erZ74XQARYq@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166672>

Hi,

I've needed this as part of bigger change which is collecting all
.git/FETCH_HEAD related code across different files to
fetch-head.[ch]. Which in its case I do as part of git-pull.sh to C
porting. So thats motivation chain :)

On Sun, Feb 13, 2011 at 2:09 AM, Sverre Rabbelier <srabbelier@gmail.com> wrote:
> Heya,
>
> On Sat, Feb 12, 2011 at 23:38, Vasyl' Vavrychuk <vvavrychuk@gmail.com> wrote:
>> Vasyl' Vavrychuk (4):
>
> Neither the patches, nor this cover letter explain _why_ this is being
> done. Motivation needed :).
>
> --
> Cheers,
>
> Sverre Rabbelier
>
