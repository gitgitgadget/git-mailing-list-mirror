From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 0/2] user-manual: reorganize the configuration steps
Date: Wed, 14 Oct 2009 17:14:22 +0300
Message-ID: <94a0d4530910140714i64c0b5f7gdb8ec4c95e3d2e7f@mail.gmail.com>
References: <1255293786-17293-1-git-send-email-felipe.contreras@gmail.com>
	 <20091014024940.GB9700@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: "J. Bruce Fields" <bfields@citi.umich.edu>
X-From: git-owner@vger.kernel.org Wed Oct 14 16:22:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1My4jp-0007YY-LO
	for gcvg-git-2@lo.gmane.org; Wed, 14 Oct 2009 16:22:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933403AbZJNOQM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Oct 2009 10:16:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933400AbZJNOQM
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Oct 2009 10:16:12 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:39319 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933325AbZJNOQK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Oct 2009 10:16:10 -0400
Received: by fg-out-1718.google.com with SMTP id d23so1405057fga.1
        for <git@vger.kernel.org>; Wed, 14 Oct 2009 07:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=jxQkgGCJscQJJpuD9XYqy4FLVadLhspGIF8Hz97w4cw=;
        b=E3NdAo4PZWMFYaoFhJPqSMn9Ud4mW/t+ISC84XYi152ycpdx31W5GoOOCcnchzZ58U
         np4KyhBIKsZ3lrlSKcC6slDvycqcKuT4LLzFD0BVVbt/6MrZl+OEJfQDmftZB6kVhA6q
         DddaJeXAMYaRVrT/CW5SD3n/cdnPDjAbZ6CBo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=KJVkA93q2YZCgOXo0KKVe6v7gMbITg16HyvfzTNAxraAsGdEMEhfNDcDgBKDB4lMvn
         yN8ZxwrNnXsCyvai6AnBoi1hwwvct7mBssLYhYl09JGGovfZvfqo6feJ+YqyRAp7GNfw
         l2D+DVqAFxEWtf+Zbxow2PgfMLbNybdC5QW7M=
Received: by 10.86.235.14 with SMTP id i14mr827925fgh.52.1255529662490; Wed, 
	14 Oct 2009 07:14:22 -0700 (PDT)
In-Reply-To: <20091014024940.GB9700@fieldses.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130291>

On Wed, Oct 14, 2009 at 5:49 AM, J. Bruce Fields <bfields@citi.umich.ed=
u> wrote:
> On Sun, Oct 11, 2009 at 11:43:04PM +0300, Felipe Contreras wrote:
>> This basically introduces the "getting started" section so users get=
 familiar
>> with the configuration from the get-go, and also, most people prefer=
 to teach
>> 'git config --global' to setup the user name and email. Here are a f=
ew
>> examples:
>
> I'm not personally a big fan of starting out with a "how to use
> git-config" section, because it's not that difficult or important:
> questions we get on this list suggest confusion about a lot of things=
,
> but git configuration is rarely one of them (that I've noticed).

Which means either people understand the configuration perfectly, look
somewhere else for that, or they don't do it at all.

Judging by the fact that most guides cover it at the beginning, and
people still send commits without proper user{.name,.email}, I would
say it is needed.

> I'd rather just point people to the git-config man page the first tim=
e
> we mention any git configuration. =C2=A0(And improve the man page if
> necessary to ensure it's up to the job.)
>
> If we have to do this, just keep it short....

That's what I tried to do.

--=20
=46elipe Contreras
