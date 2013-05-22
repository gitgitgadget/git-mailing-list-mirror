From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] prompt: fix show upstream with svn and zsh
Date: Tue, 21 May 2013 19:03:09 -0500
Message-ID: <CAMP44s3nMSj5=pr-WmWTd_iUjK4iU_8KnOKHYgRHLAQyyMH9bA@mail.gmail.com>
References: <1369169667-25166-1-git-send-email-t.gummerer@gmail.com>
	<20130521224119.GF30969@goldbirke>
	<CAMP44s1cbO-xzUAHR4THz4MPdqxY6SHG7uf_da_OM8YCDbTi+A@mail.gmail.com>
	<20130521233617.GG30969@goldbirke>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Gummerer <t.gummerer@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com
To: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Wed May 22 02:03:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UewWR-0007yj-Op
	for gcvg-git-2@plane.gmane.org; Wed, 22 May 2013 02:03:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753970Ab3EVADL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 21 May 2013 20:03:11 -0400
Received: from mail-lb0-f172.google.com ([209.85.217.172]:40379 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753426Ab3EVADL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 May 2013 20:03:11 -0400
Received: by mail-lb0-f172.google.com with SMTP id p10so1460749lbi.3
        for <git@vger.kernel.org>; Tue, 21 May 2013 17:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=ClCiHJxRh8peQM9eMMz35pgDZ6RhHRdMeULDDga2Fpw=;
        b=nJOEhA6mLOkdjzeMAXIR54D49aOorxdFa35vQKxp43EHaTGmfA0twPfH9pS+V1YZ2p
         D/2kqR0XBQJ3+iyuPDZNhvTNyLw0XpxUWz2CBT40SBHAMAKb+IAk15N7PmrYRH4K/+8z
         SPBMThd5sfOHGgpNhkTfAcW+1KHq9SEoSxjAQIPjBOY1KQ81rbDMXCF8Ofmx1jiMoWtH
         ni9EKd6ALgnzpc/WNa7Rmu/qs1QnFJH+YQKXUxzAE8QjYtMZYYMkra2iMmG9mwIgc9h5
         XUk5YNW2J21BjDEcQg3m9UWCVNLHmIjmNQ6AK4XOokrB6mlC/xCO2wgOx9Zt/hXNOcBl
         H6tQ==
X-Received: by 10.112.145.72 with SMTP id ss8mr2864671lbb.12.1369180989316;
 Tue, 21 May 2013 17:03:09 -0700 (PDT)
Received: by 10.114.184.3 with HTTP; Tue, 21 May 2013 17:03:09 -0700 (PDT)
In-Reply-To: <20130521233617.GG30969@goldbirke>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225097>

On Tue, May 21, 2013 at 6:36 PM, SZEDER G=C3=A1bor <szeder@ira.uka.de> =
wrote:
> On Tue, May 21, 2013 at 06:04:35PM -0500, Felipe Contreras wrote:
>> On Tue, May 21, 2013 at 5:41 PM, SZEDER G=C3=A1bor <szeder@ira.uka.d=
e> wrote:
>>
>> > On Tue, May 21, 2013 at 10:54:27PM +0200, Thomas Gummerer wrote:
>> >> Currently the __git_ps1 git prompt gives the following error with=
 a
>> >> repository converted by git-svn, when used with zsh:
>> >>
>> >>          __git_ps1_show_upstream:19: bad pattern: svn_remote[
>> >>
>> >> This was introduced by 6d158cba (bash completion: Support "diverg=
ence
>> >> from upstream" messages in __git_ps1), when the script was for ba=
sh
>> >> only.  Make it compatible with zsh.
>> >
>> > What is the actual cause of this problem/incompatibility and how/w=
hy do
>> > these changes fix it?
>>
>> I think the commit message makes that very clear.
>
> If that were the case I wouldn't have asked in the first place.

You are not the authority on what *I think*, or if you meant s/If that
were the case/If the message was clear/, still; you are not the
authority on what is or is not true. Only on what is your opinion.

--=20
=46elipe Contreras
