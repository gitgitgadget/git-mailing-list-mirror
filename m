From: Kevin <ikke@ikke.info>
Subject: Re: confused about remote branch management
Date: Wed, 23 Jul 2014 15:30:32 +0200
Message-ID: <CAO54GHDC1rA9hNcAHw0dTcm7Ynu=QRacmnsP9ub09qSP_8NAEg@mail.gmail.com>
References: <1406083743.29001.139.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Ross Boylan <ross@biostat.ucsf.edu>
X-From: git-owner@vger.kernel.org Wed Jul 23 15:31:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X9wdG-0002Zd-4m
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jul 2014 15:30:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751709AbaGWNay (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2014 09:30:54 -0400
Received: from mail-yh0-f45.google.com ([209.85.213.45]:63967 "EHLO
	mail-yh0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751509AbaGWNax (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2014 09:30:53 -0400
Received: by mail-yh0-f45.google.com with SMTP id 29so772750yhl.18
        for <git@vger.kernel.org>; Wed, 23 Jul 2014 06:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=txrZFNaso0N8KYI7WZqsnmw6A6hef853UiA4eymQKEc=;
        b=yGd8myXb1i03H9P9vODla6C4OfsvfFTTMuMl5A8fyYqGrhhY3+uLglJC3CsV0myg9h
         zU/FcT6/iYfvAFkO4apj8YGDXxev1v3K2V7xdUTJwoq/HW2qjUbkJ7Ii8ZOcv8KPs21F
         mrujisM2Or3EpJj81ogTXD2rhNf4dRgfhglzL/o2wHXBXT4CP7n846jX0AiFsvLVyhRz
         cArn9V6wPzwbOELZY43KLYvjzPF5OMGc27z7zCLhIoEdzSWq/MNoqUsegcGYbs83C6dm
         4lEkfmYUwtilbVyrOchHzQDs7DGedkp7FQxdBXJ+yP8e0FYXDrJc99ZAItZinnPOefnf
         fwpg==
X-Received: by 10.236.7.109 with SMTP id 73mr1800076yho.148.1406122252669;
 Wed, 23 Jul 2014 06:30:52 -0700 (PDT)
Received: by 10.170.130.144 with HTTP; Wed, 23 Jul 2014 06:30:32 -0700 (PDT)
In-Reply-To: <1406083743.29001.139.camel@localhost>
X-Google-Sender-Auth: S5RSFA8US7COr7rumGB3ngJOVjM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254074>

On Jul 23, 2014 5:11 AM, "Ross Boylan" <ross@biostat.ucsf.edu> wrote:
>
> My local master branch is the result of a merge of upstream master and
> some local changes.  I want to merge in more recent upstream work.
> git pull doesn't seem to have updated origin/master, and git checkout
> origin/master also doesn't seem to work.
>

git pull with two parameters in older versions will not update remote
tracking branches. That's because the last parameter expects a refspec
with a source and destination and you only specify a source.

Doing a git fetch will update them.

> ross@tempserver:~/UCSF/Choi/GitHub/ESS$ git --version
> git version 1.7.10.4

Version 1.8.4 changes this behavior and will update the remote
tracking branches.
