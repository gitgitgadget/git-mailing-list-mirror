From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2] Add new remote-hg transport helper
Date: Sun, 28 Oct 2012 05:24:29 +0100
Message-ID: <CAMP44s1a4ZjhQySTFbFzvgPhTwNJNoqLchP0xqmGekwHk5kqXw@mail.gmail.com>
References: <1350745206-28955-1-git-send-email-felipe.contreras@gmail.com>
	<20121020154301.GA31829@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Sun Oct 28 05:24:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TSKQa-0008GA-T9
	for gcvg-git-2@plane.gmane.org; Sun, 28 Oct 2012 05:24:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751386Ab2J1EYa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Oct 2012 00:24:30 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:51310 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751328Ab2J1EYa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Oct 2012 00:24:30 -0400
Received: by mail-ob0-f174.google.com with SMTP id uo13so3696068obb.19
        for <git@vger.kernel.org>; Sat, 27 Oct 2012 21:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=dYOgFWxcdNq/voY238dSPPd6hwh6sRICeE+QGAGHJjo=;
        b=UWojfXWtS03IQTiODLELF4lvkdrKDcB7tQv66xMqRM2C6nOxF86n8BjV7NFZlpryf3
         aPufdBXmZlLDdXtzz4bD5CwSS8vYEMa3b3s6tLlVTGPKC5dPYTYWWuOYKkBqdlhy+zZX
         p1v1lRrESehGMe29UaV268sYsd8OZfGKi89mA3YAmJOOk0RyKf5kvKrLJmTou9AmFSQ2
         kg+Q8E9gH2lm6ou9nMdMDV63ToBpc6UW/a8J1oVqc0Jb+O7fQQ8WDlhC8Kfbj5ZjdZWt
         3zJcUgPNNprqIEMLaFpIOJMfFUo1d2H/bU215qSm7IYZrEuef/zNCwotJdLWrd2+I18O
         ykCg==
Received: by 10.60.27.201 with SMTP id v9mr13958716oeg.85.1351398269258; Sat,
 27 Oct 2012 21:24:29 -0700 (PDT)
Received: by 10.60.4.74 with HTTP; Sat, 27 Oct 2012 21:24:29 -0700 (PDT)
In-Reply-To: <20121020154301.GA31829@glandium.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208532>

On Sat, Oct 20, 2012 at 5:43 PM, Mike Hommey <mh@glandium.org> wrote:
> On Sat, Oct 20, 2012 at 05:00:06PM +0200, Felipe Contreras wrote:
>> Changes since v1:
>>
>>  * Improved documentation
>>  * Use more common 'python' binary
>>  * Warn, don't barf when a branch has multiple heads
>>  * Fixed marks to fetch after cloned
>>  * Support for cloning/pulling remote repositories
>>  * Use a more appropriate internal directory (e.g. .git/hg/origin)
>>  * Fixes for python3
>
> Are the resulting commits identical to what you'd get from using hg-git?

Now they are :)

-- 
Felipe Contreras
