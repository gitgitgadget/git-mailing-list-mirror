From: Vicent Marti <vicent@github.com>
Subject: Re: Git Pack: Improving cache performance (maybe a good GSoC practice)
Date: Wed, 30 Mar 2011 12:46:18 +0300
Message-ID: <AANLkTim+Ge2c-i_jUi8YN8g+cQmXuyKYrdHC+jYukjQy@mail.gmail.com>
References: <4D925B63.9040405@googlemail.com> <AANLkTin6z3hM7nyMqOUPdHrY9TmRVAzpchM+4O=S7KKj@mail.gmail.com>
 <4D92EDA0.8030309@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Shawn Pearce <spearce@spearce.org>, git@vger.kernel.org
To: Sebastian Thiel <byronimo@googlemail.com>
X-From: git-owner@vger.kernel.org Wed Mar 30 11:46:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4rzC-0006ne-1o
	for gcvg-git-2@lo.gmane.org; Wed, 30 Mar 2011 11:46:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755699Ab1C3Jqk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Mar 2011 05:46:40 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:62774 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755021Ab1C3Jqj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Mar 2011 05:46:39 -0400
Received: by wya21 with SMTP id 21so907438wya.19
        for <git@vger.kernel.org>; Wed, 30 Mar 2011 02:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:in-reply-to:references:from
         :date:x-google-sender-auth:message-id:subject:to:cc:content-type;
        bh=hlC7t96UJbdMHiRtdQHZIGkxnjaimAvG8aV05MSUMtU=;
        b=cyshlshTy9/iRnF9XRTuZBcnvvWMwz8XQp95K5SLnzDH7kMr+Nyh86KnA6/PaP8ggh
         uYyxx0zumKxvSc4glPEIVQKT25jbQCfA9lauD4Da0OdtPRYUdOwk5Vc4QL0N71tQ6wkg
         LsH0MAoaAc6d0t3U9Lyyt56G73n0z0BUyIQmo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        b=WWwAjyQsZffh4PljMB90SorDKDM9G56fqs7Gyt/J6VJY65w77xqyRB1bCgt+MYcG6k
         ztJKxpRUerBsOt6pEUMU/ngDySuibSzIqiSYbSijopxY55AIpD4p+oiEz/q66V2IW9Uv
         MqL1DJrd9zVkzm3zQx89dAyg5mNYd5DJ0UyX4=
Received: by 10.216.244.6 with SMTP id l6mr956075wer.51.1301478398092; Wed, 30
 Mar 2011 02:46:38 -0700 (PDT)
Received: by 10.216.243.7 with HTTP; Wed, 30 Mar 2011 02:46:18 -0700 (PDT)
In-Reply-To: <4D92EDA0.8030309@googlemail.com>
X-Google-Sender-Auth: 60AFHgrauAgvEqS9iofK20q8RLU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170371>

On Wed, Mar 30, 2011 at 11:45 AM, Sebastian Thiel
<byronimo@googlemail.com> wrote:
>> Have considered wrapping libgit2 with a C++ binding? Just curious.
>
> The project appears to be silent for nearly 5 months now, and it is in a
> rather early stage of development. There is no delta cache yet, nor is there
> a sliding window mmap implementation which would be required on 32 bit
> systems, at least if you want to have big file support.

wat?

http://libgit2.github.com
https://github.com/libgit2/libgit2

Cheers,
Vicent
