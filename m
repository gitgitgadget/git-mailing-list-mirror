From: Dario Rodriguez <soft.d4rio@gmail.com>
Subject: Re: [RFC] Convert builin-mailinfo.c to use The Better String Library.
Date: Fri, 11 Jun 2010 10:33:58 -0300
Message-ID: <AANLkTikvBg1IEauZIzZP4XINqUjrb3F3ill5vP9zqIpR@mail.gmail.com>
References: <46DDC500.5000606@etek.chalmers.se>
	<1189004090.20311.12.camel@hinata.boston.redhat.com>
	<vpq642pkoln.fsf@bauges.imag.fr>
	<4AFD7EAD1AAC4E54A416BA3F6E6A9E52@ntdev.corp.microsoft.com>
	<loom.20100610T204637-685@post.gmane.org>
	<m3mxv1pxli.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Ian Molton <ian.molton@collabora.co.uk>, git@vger.kernel.org,
	Dmitry Kakurin <dmitry.kakurin@gmail.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 11 15:34:12 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ON4N6-0000hH-Ro
	for gcvg-git-2@lo.gmane.org; Fri, 11 Jun 2010 15:34:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760295Ab0FKNeB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jun 2010 09:34:01 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:47067 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760244Ab0FKNeA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jun 2010 09:34:00 -0400
Received: by bwz7 with SMTP id 7so326342bwz.19
        for <git@vger.kernel.org>; Fri, 11 Jun 2010 06:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=iqa9/cv4+UClL2pAy2/2AZJhYK3p1NurIL9CelDatxY=;
        b=bp7aPnLuCGWWjfQNQr88dxzJ68Pbq94/2riH3ndwEZhLNiBXoaYYylyn7gopDLvIEl
         dxb4eiulFNNGiYhSQuT0Zzn/z6GIbIxhdk7lqeGMBDDuLwgIC0RlvIdhHILK8pW2Z0Qy
         4KMpAfe7987jKK2bJOhB0nVu0j0j/YGkOljqM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=N+tiDNNDSZYsORHzdxpKV0e8v1D7eID9dpj/ECaqNEqa4Llc5BPu57sMjNGzCCA1lA
         VbdnhTxUNI4rC0I2KazOP5aDlBvh9Td8ALwmoUw9pYSCTf05kBJ6tOzN02pqFtijsdFW
         5QLo2HR8Y5/uArSR66cZVUpqAV2DIhOgV8XRY=
Received: by 10.204.81.223 with SMTP id y31mr1289670bkk.87.1276263238505; Fri, 
	11 Jun 2010 06:33:58 -0700 (PDT)
Received: by 10.204.82.142 with HTTP; Fri, 11 Jun 2010 06:33:58 -0700 (PDT)
In-Reply-To: <m3mxv1pxli.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148947>

On Fri, Jun 11, 2010 at 9:23 AM, Jakub Narebski <jnareb@gmail.com> wrote:
> Also, I don't know when Dmitri written his post, but git uses its own
> string manipulation mini-library, named strbuf, at least since end of 2007
> (Documentation/technical/api-strbuf.txt was added as stub on 2007-11-24).

An interesting point, Dmitri written this post on September 2007...
why the flamewar continuation? just curiosity...

Now, as a resume of flames and concepts, the 'better' things in the
string library (also the first excuse for C++ apologists, as a
repetitive piece of youknowwhat) are pure algorithms and data
structures, easy to code in C. The goal isn't in the OO design or
abstraction itself, or in the language...

Personally, I use C++ almost every day at work and I found it stupid.
I love pure C.

Cheers,
Dario (argentina)
