From: =?windows-1252?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: Enhancement Request: "locale" git option
Date: Thu, 04 Dec 2014 09:29:04 +0100
Message-ID: <54801B50.4080500@web.de>
References: <54801C39020000A1000182FA@gwsmtp1.uni-regensburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
To: Ulrich Windl <Ulrich.Windl@rz.uni-regensburg.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 04 09:30:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwRny-00064A-Ku
	for gcvg-git-2@plane.gmane.org; Thu, 04 Dec 2014 09:30:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753300AbaLDIaZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Dec 2014 03:30:25 -0500
Received: from mout.web.de ([212.227.15.4]:56703 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751878AbaLDIaY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Dec 2014 03:30:24 -0500
Received: from [192.168.88.199] ([194.47.243.242]) by smtp.web.de (mrweb004)
 with ESMTPSA (Nemesis) id 0Lfmd0-1XdLGx0QcU-00pKwO; Thu, 04 Dec 2014 09:30:21
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:31.0) Gecko/20100101 Icedove/31.2.0
In-Reply-To: <54801C39020000A1000182FA@gwsmtp1.uni-regensburg.de>
X-Provags-ID: V03:K0:6MlR4jy6D5x/sdohRsHboEPSsy1fi+rMGtOaQ0jQjZDDmdGa6tt
 1ovis7AUJiWnLyGacTgiiU8VUhNQ/n3a2s69akLqw/N4TNlp8IMGI+Y37hWFfKYNnUr3+2V
 ptbdtxL7CGyRakjAwMUhRkG8d7jH4QDX6Vde3YubJMX4HXbOsS0gX9BmHxWSZNXejfBUmzQ
 qsB5TJEVoNM4Sf30csy1g==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260743>

On 12/04/2014 08:32 AM, Ulrich Windl wrote:
> Hi!
>
> I'm native German, but German git messages confuse me (yopu'll have to correlate them with the man pages). At the moment git uses the locale settings from the environment, so you can only change git's locale settings by changing the environment (like "LANG= git ...").
> OTOH Git has a flexible hierachical option setting mechanism. Why not allow a Git language (locale) setting system-wde, user-wide, or repository-specific.
>
> Regards,
> Ulrich
How about
alias git='LANGUAGE=de_DE.UTF-8 git'
in your ~/.profile ?
(Of course you need to change de to the language you want )
