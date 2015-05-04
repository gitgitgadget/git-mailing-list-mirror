From: Thiago Farina <tfransosi@gmail.com>
Subject: Re: multiple source file extensions
Date: Mon, 4 May 2015 19:12:45 -0300
Message-ID: <CACnwZYdGKcdzgu1=Ysd_pxqeuSBpZu41i1EJBvBi4FqHzvV-Hw@mail.gmail.com>
References: <CACnwZYed_aHzLsbkJVm=OnydXw-CPi-Zm9V7928rzvpaFMNENw@mail.gmail.com>
	<CANuW5x3OBWNDnHeVbH7ZQaj5AUAingea6crJ0cF9AHFjcJE_bQ@mail.gmail.com>
	<20150502011100.GB5634@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Josh Hagins <hagins.josh@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	=?UTF-8?B?RHV5IE5ndXnhu4Vu?= <pclouds@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue May 05 00:13:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YpObj-0004P2-K2
	for gcvg-git-2@plane.gmane.org; Tue, 05 May 2015 00:12:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752083AbbEDWMv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 May 2015 18:12:51 -0400
Received: from mail-ob0-f179.google.com ([209.85.214.179]:34061 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751908AbbEDWMr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 May 2015 18:12:47 -0400
Received: by obfe9 with SMTP id e9so117091715obf.1
        for <git@vger.kernel.org>; Mon, 04 May 2015 15:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=jUPfl8z5X6b6uti5lk0RsXStdfXalosAtQ46Hfa6ieY=;
        b=HBesTbiiWBEdDeC+Pf6ggtM0HvDSorh1DvtssaVVlAorKPOiYySv/WUctiqkbsEX4W
         G3AqCVwuFo3IaftnbT6ZatowIXvnRdfTviGPuH4qzMmjMj9JRkgDNVsOo0RQQPyLyE2n
         U8caC2ddnXobjlRN91aAFYf2kRCmwZm472xSx3fKOkl8OKBjkYKX4ZZkYLWifvrZSyPH
         9igUI3sVCAPjqDD/phcJM78t3dhQExDhskZYcv1dhEZaJkK6Dj9b9Wq1a5RSoWDNys9A
         sni59f9xxScGD8SoEJBiI2JA4s2jmgdPzaFT7N1hL7mXsHnkoCIcoVRqblfQ3Di1xyd2
         BPxg==
X-Received: by 10.60.142.200 with SMTP id ry8mr16177093oeb.72.1430777565982;
 Mon, 04 May 2015 15:12:45 -0700 (PDT)
Received: by 10.202.80.136 with HTTP; Mon, 4 May 2015 15:12:45 -0700 (PDT)
In-Reply-To: <20150502011100.GB5634@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268364>

On Fri, May 1, 2015 at 10:11 PM, Jeff King <peff@peff.net> wrote:
> On Fri, May 01, 2015 at 08:49:14PM -0400, Josh Hagins wrote:
>
>> If you're using a recent version of bash, you could enable the
>> 'globstar' option:
>>
>>     $ shopt -s globstar
>>     $ git grep 'pattern' **/*.{cc,cpp,h}
>>
>> Does that work?
>
> That will only pick up files that are in the working tree. Which is fine
> for a stock "git grep" with no options, but would not be right for
> grepping in the index or an older tree. For that, you can ask git to
> glob for you:
>
>   git grep pattern -- '*.cc' '*.cpp' '*.h'
>
Is it possible to do a regex like the following?

".*\.[cChH]\(pp\)?"

http://stackoverflow.com/questions/277999/how-to-use-the-unix-find-command-to-find-all-the-cpp-and-h-files/3858879#3858879

-- 
Thiago Farina
