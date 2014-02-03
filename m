From: Erez Zilber <erezzi.list@gmail.com>
Subject: Re: Running "make rpm" fails on a CentOS 6.3 machine
Date: Mon, 3 Feb 2014 13:10:05 +0200
Message-ID: <CALMr_pXJTYvCjMQqOak8WhMkW7q4VmAP41V=uTWibx=Zb3SfzQ@mail.gmail.com>
References: <CALMr_pWHfaHq46418UPcqGKm6bFc61jw-VqGJYV8Ogc9yuHDFA@mail.gmail.com>
	<20140130181643.GG27577@google.com>
	<20140130185104.GV3241@zaya.teonanacatl.net>
	<CALMr_pVP-YVJ9K7ZpQxk3d5YBFQmCZBonFeUYY1fxdZNHHZJHA@mail.gmail.com>
	<20140202210724.GX3241@zaya.teonanacatl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Todd Zullinger <tmz@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 03 12:10:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WAHPr-0001Kl-3w
	for gcvg-git-2@plane.gmane.org; Mon, 03 Feb 2014 12:10:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751109AbaBCLKH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Feb 2014 06:10:07 -0500
Received: from mail-ob0-f174.google.com ([209.85.214.174]:36187 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750764AbaBCLKG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Feb 2014 06:10:06 -0500
Received: by mail-ob0-f174.google.com with SMTP id uy5so7599393obc.5
        for <git@vger.kernel.org>; Mon, 03 Feb 2014 03:10:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=vgycx+WfGj89Zw1txOK+eNq+iZhYheQrVdrw38dCYXE=;
        b=d3h+DttVbhCW4DoZR0n3+9+zUrMwnkbqPRpXgWVep1dqSlILYegiUxjTeg+Yixx1E5
         1N71jaJKLDGgJ/VVSqkB4IlKSLaco27zulGJQr3ExXBLHv0tSJewFMkH7nNaUWpQD48A
         ueRykWwKP8PfpTFGoLBEEGCcorEKepnsqxyHt8lregeHu1g+HRpuIf+ix+UPOrzc4dS/
         CmrjbaF+49ddVoPCFKh8Xmr+MZbk3FSAhuQp2rNfYLKsEK1LpAzhwtpqJKrmhMaxxqt0
         2xWKjyw8n+CXDbscqaIz6ypGxxWHra49c4Wnm1gfy61vcClRRpP18ax79CgT2wfljzON
         vcjA==
X-Received: by 10.182.102.134 with SMTP id fo6mr29691459obb.10.1391425805093;
 Mon, 03 Feb 2014 03:10:05 -0800 (PST)
Received: by 10.60.68.99 with HTTP; Mon, 3 Feb 2014 03:10:05 -0800 (PST)
In-Reply-To: <20140202210724.GX3241@zaya.teonanacatl.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241423>

On Sun, Feb 2, 2014 at 11:07 PM, Todd Zullinger <tmz@pobox.com> wrote:
> Hi Erez,
>
>
> Erez Zilber wrote:
>>
>> Thanks. I will try to use the rpm from Todd's build. BTW - if I want to
>> create such a build on Fedora that will create el6 packages (e.g.
>> git-1.8.5.3-2.el6.x86_64.rpm), what's the procedure?
>
>
> Something like this (this is from memory):
>
> # Install fedpkg
> $ yum install fedpkg

Thanks. Just making sure - I need to do all of this on a fedora
machine, not a RHEL/CentOS machine, right?

Erez
