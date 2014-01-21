From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 0/2] Two janitorial patches for builtin/blame.c
Date: Tue, 21 Jan 2014 08:55:46 -0800
Message-ID: <20140121165546.GE18964@google.com>
References: <1390157870-29795-1-git-send-email-dak@gnu.org>
 <87d2jlqp7x.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Tue Jan 21 17:56:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W5ecH-00062n-K4
	for gcvg-git-2@plane.gmane.org; Tue, 21 Jan 2014 17:55:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754922AbaAUQzy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jan 2014 11:55:54 -0500
Received: from mail-yh0-f54.google.com ([209.85.213.54]:46838 "EHLO
	mail-yh0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754751AbaAUQzx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jan 2014 11:55:53 -0500
Received: by mail-yh0-f54.google.com with SMTP id z6so866079yhz.41
        for <git@vger.kernel.org>; Tue, 21 Jan 2014 08:55:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=tl+LhxMVeIimw5OYA1uBPs9/HcaAcvAp+2WqGnvsLRE=;
        b=0TTacbkCImxGdkSoMsccIDKoCmqAsGWbPC2ftAHL9qrACn0yZk1KU63dyvtE9UPYgx
         Sm7CCaoie2Z1jVj8VOhUJJwqSzNm1DYYKtid1eiEvxOPfQeGAvXQZUSMlvhZOISEU9bJ
         2PT9tW6ZHrkwHJ4hGDagyEjbuq+R198RUI97p7Snqd10aDQ5MuciosQK+kSPreb/+qAv
         PC9Xg92nhBa87D8VD2AlSQkFXPscWdj8gxC8GqYYKlQr+9O1pBVpCZqs6JDnaYB5Ceiq
         Miuws0Yph4xxSlQQDD44vVh7TjinaE2N1iokTauSXbx9x8aJAywE5gpWxhNHjdLhzuSZ
         KxMw==
X-Received: by 10.236.125.10 with SMTP id y10mr23919907yhh.58.1390323350581;
        Tue, 21 Jan 2014 08:55:50 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id k3sm14627970yhc.13.2014.01.21.08.55.49
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 21 Jan 2014 08:55:50 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <87d2jlqp7x.fsf@fencepost.gnu.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240754>

David Kastrup wrote:

> Now I might have sent at an unopportune time: blame.c is mostly
> attributed to Junio who seems to have been a few days absent now.
>
> I also have seen quite a few mails and patch submissions on the list go
> basically unanswered in the last few days.

In the U.S., yesterday was a federal holiday (Martin Luther King, Jr.
day) and the two days before were the weekend.

[...]
>             maintained indefinitely and may be redistributed consistent with
>             this project or the open source license(s) involved.
>
> Now the file involved (builtin/blame.c) itself does not state _any_
> license.

Most of git is GPLv2-only.  (As an aside, if there's interest then I'd
be happy to see most of it change to GPLv2-or-later since that makes
it possible to link to code under the Apache License.  But I'm also
happy with the status quo.)

[...]
> As far as I am concerned, I am willing to license my work under the
> GPLv2 or any later version at the discretion of whoever wants to work
> with it.  I think that should be compatible with the project goals.
>
> Now the above passage states "you might note so in your copyright
> message", but my patches do not even contain a copyright message and it
> is not clear to me that they should, or that there is a sensible place
> to place such "copyright messages".

Yeah, since these patches aren't adding a large new chunk of code
there's no need for a new copyright notice and so no place to put that
kind of thing unless Junio wants to relicense blame (which would be
orthogonal to these patches).

Thanks and hope that helps,
Jonathan
