From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] Add new @ shortcut for HEAD
Date: Mon, 29 Apr 2013 15:23:52 -0500
Message-ID: <CAMP44s0rT1097=481aSH=Gy465zb2Bd_xLv=Xvte-GHcamWLyA@mail.gmail.com>
References: <1367264106-2351-1-git-send-email-felipe.contreras@gmail.com>
	<7v61z5hzqg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jon Seymour <jon.seymour@gmail.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 29 22:24:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWucB-0008H9-GO
	for gcvg-git-2@plane.gmane.org; Mon, 29 Apr 2013 22:23:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758643Ab3D2UXz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Apr 2013 16:23:55 -0400
Received: from mail-la0-f42.google.com ([209.85.215.42]:61565 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757950Ab3D2UXy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Apr 2013 16:23:54 -0400
Received: by mail-la0-f42.google.com with SMTP id eb20so1206651lab.1
        for <git@vger.kernel.org>; Mon, 29 Apr 2013 13:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=flWTxO8cxArnTmH7l+fSPb7C1vTDbAB1qqW8hGKalcQ=;
        b=evxtzwOiy/TXdyvvD0WX+GCXGVfdccPv8irmz+9USihVS5Z1MGdC6nFDKpFRzCSy90
         WYDtWQxdCaSiDR9fuhv+D2jfzjdbo8YqEwWZ2VV7szfV8UncH+x5TnWbuRmZ6cDCYAxi
         3UvMAI9fhCIMr8gH1O9LdqlVPfnJPYZc2lE8O3Nn/zQE726nJM2F/7/mugcoj7FreRwV
         QC7g39ngDUVBdV8cw6ap6RB8IIFcxZEakX7eqT66QQuNGQeW6PZezEtanIIy4hmFuLwS
         I4n2dO1nyDiQ/dUiU4ZrD5UwbPIIIhxVmL137ZoHjfdo9DeHHFReYSNOJ+EaGlhx6mCg
         WVyw==
X-Received: by 10.112.146.133 with SMTP id tc5mr27533019lbb.88.1367267032834;
 Mon, 29 Apr 2013 13:23:52 -0700 (PDT)
Received: by 10.114.83.167 with HTTP; Mon, 29 Apr 2013 13:23:52 -0700 (PDT)
In-Reply-To: <7v61z5hzqg.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222859>

On Mon, Apr 29, 2013 at 3:02 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> So HEAD@{0}~0^0 is too much to type, but we can remove '^0', and we can
>> remove '~0', and we can remove 'HEAD', but we can't remove '{0}'?
>
> Another technical issue, even if you have reflogs.
>
> HEAD@{0} and @{0} are referring to two different reflogs, and means
> different things, even though they may refer to the same commit.

How? AFAICS the code substitutes @{0} with HEAD@{0}.

Plus 'git show HEAD@{1}', 'git show current-branch@{1}', and 'git show
@{1}' all show the same thing, even though 'git relog HEAD' shows a
different commit for HEAD@{1}.

-- 
Felipe Contreras
