From: Yuri Mikhailov <yuri.mikhaylov@gmail.com>
Subject: Re: Load testing of git
Date: Tue, 5 Mar 2013 23:04:28 +0100
Message-ID: <CAGjB8pT-HCDY-M7nP_YCGyyvAtVZnMYynm7rVypp66Ve2g-azA@mail.gmail.com>
References: <CAGjB8pR+uByiJJikBXbaxUZO4rDgyfvJ31agxaQuWrMwSS1N7Q@mail.gmail.com>
	<201302241758.18316.thomas@koch.ro>
	<CAJo=hJvX5rmsuB4Jsbp7ZoqeyPtB_fwiZc=8VMWmF=HN0XKGLw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: thomas@koch.ro, git <git@vger.kernel.org>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Mar 05 23:04:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UCzyg-0001Hj-FV
	for gcvg-git-2@plane.gmane.org; Tue, 05 Mar 2013 23:04:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753547Ab3CEWE3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Mar 2013 17:04:29 -0500
Received: from mail-ie0-f181.google.com ([209.85.223.181]:50224 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753500Ab3CEWE2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Mar 2013 17:04:28 -0500
Received: by mail-ie0-f181.google.com with SMTP id 17so8397941iea.26
        for <git@vger.kernel.org>; Tue, 05 Mar 2013 14:04:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=tipwMEnuTDna1xcUy51rhra+2V4RIRBDkDuK/mryhYQ=;
        b=ZFY3EY2EDr4jwr1fzwnbsYwom5hiSmO6E8k0OriONv3Hy5MRPc2yscx1ZOku4MgZu7
         5EDHk4GFpdZ2Nb8S+LNC8GKyOa3y6mIQVLXZWg8DQhixPZMbvmYPyuLv1ln9e3WsAy7B
         5Up7dwWjDMerYXEE66suQafverv5p6vJUAToGgm0Gv1+aL+grPESH+hnuXEfsDvbW202
         cdK8s34yBhZtRCSwZGXpp+XO/qLqlU6K74QXzL74mGgTWiII43v6ae26mosdqukhUefy
         Vx6x1SoZgzEmqC8nf0LjuhgJNzXMtB3y9tnPWWn03k7dta6XqLtT3oGsinSb/hst0snr
         kwlQ==
X-Received: by 10.42.159.194 with SMTP id m2mr28412518icx.13.1362521068224;
 Tue, 05 Mar 2013 14:04:28 -0800 (PST)
Received: by 10.64.91.228 with HTTP; Tue, 5 Mar 2013 14:04:28 -0800 (PST)
In-Reply-To: <CAJo=hJvX5rmsuB4Jsbp7ZoqeyPtB_fwiZc=8VMWmF=HN0XKGLw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217487>

Thanks to everyone. The information was useful.

On 24 February 2013 21:31, Shawn Pearce <spearce@spearce.org> wrote:
> On Sun, Feb 24, 2013 at 8:58 AM, Thomas Koch <thomas@koch.ro> wrote:
>> Yuri Mikhailov:
>>> Dear Git community,
>>>
>>> I am a Software Developer and I have been using git for a while.
>>> Currently my company is looking for a version control system to use
>>> and we find Git a good candidate for us. But what is important for us
>>> to know is scalability of this VCS. Does anyone performed load testing
>>> of Git? What is the practical maximum number of files and revisions
>>> this system can handle?
>>>
>>> Best regards,
>>> Iurii Mykhailov
>>
>> Have a look at the projects using Git[1]. There are for sure projects that
>> exceeds the scalability you're thinking about. The linux Kernel might be the
>> biggest project.
>
> I highly doubt the Linux kernel is the biggest project.
>
> IIRC WebKit has more objects, more files, etc. Its repository's
> compressed form is >4G.
>
> I know of at least some proprietary repositories with 96G in them. Not
> much history, but a lot of binary blobs around 128M each doesn't
> compress well. And bup wasn't used so we didn't get very good
> compression over the files.
