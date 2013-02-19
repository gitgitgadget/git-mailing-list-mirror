From: Adam Spiers <git@adamspiers.org>
Subject: Re: Proposal: sharing .git/config
Date: Tue, 19 Feb 2013 14:38:43 +0000
Message-ID: <CAOkDyE-at6jJZGV-3H4jEZhAsid41oqcQtEmad+5rwRhYiFUpQ@mail.gmail.com>
References: <CALkWK0npW6TLdMNd5_zw-RAB0bjF9DDoyAVSx4Zx=7AmvdEo3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 19 15:39:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7oLd-0007e2-NX
	for gcvg-git-2@plane.gmane.org; Tue, 19 Feb 2013 15:39:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932945Ab3BSOiq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2013 09:38:46 -0500
Received: from mail-oa0-f53.google.com ([209.85.219.53]:49723 "EHLO
	mail-oa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932877Ab3BSOip (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2013 09:38:45 -0500
Received: by mail-oa0-f53.google.com with SMTP id m1so6962521oag.26
        for <git@vger.kernel.org>; Tue, 19 Feb 2013 06:38:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=bm9qSH5yTE6ygDPyYNxK+qeE0OL8xLiCFNeBNmK0yHU=;
        b=dryDB2INVscXD3yy8fvrwwAjZhEAd1aY/IfKeGuIyubSJAtda+iAUk+ymbRK/B8f2Y
         qqp9L1fhivh/bqgtD6QipqVrnmldMajLaw5MwaFQL/G6UoyUqz4eemfO0UGnWSypxcRR
         ivXZQdfUgD8SsZeUn41zvophl8IL4BDmBnhHnDtybXeCaONsSTHKqFzxZr9v/uV2HaLV
         FOnLjtQdzPJUyML/3D4/Lx/Mt1OKJiOFa6hjKotNAmDofqcaxf66HBMkToOSYcDotQnq
         dtYGV8CxlosS9UIxvawjUNCOBRuIIH3AVC+nRMF0zWqEwIuPAu6Cs23Yp/SbXx1+cYL5
         S2Jw==
X-Received: by 10.60.172.84 with SMTP id ba20mr7615216oec.10.1361284723709;
 Tue, 19 Feb 2013 06:38:43 -0800 (PST)
Received: by 10.182.122.106 with HTTP; Tue, 19 Feb 2013 06:38:43 -0800 (PST)
In-Reply-To: <CALkWK0npW6TLdMNd5_zw-RAB0bjF9DDoyAVSx4Zx=7AmvdEo3w@mail.gmail.com>
X-Google-Sender-Auth: ZWMxMTjNJ3ZzDAe11re5r9Acqsc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216621>

On Tue, Feb 19, 2013 at 9:25 AM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> Hi,
>
> I have this itch where I want to share my remotes config between
> machines.  In my fork, I should be able to specify where my upstream
> sources are, so remotes get set up automatically when I clone.  There
> are also other things in .git/config that would be nice to share, like
> whether to do a --word-diff (why isn't it a configuration variable
> yet?) on the repository.  The only problem is that I have no clue how
> to implement this: I'm currently thinking a special remote ref?

I handle these kinds of configuration tasks out of band using mr,
and it works pretty well:

  https://github.com/aspiers/mr-config/#readme
  https://github.com/aspiers/mr-config/blob/master/sh.d/git-remotes

Food for thought ...
