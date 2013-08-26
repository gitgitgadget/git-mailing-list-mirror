From: Bruce Korb <bruce.korb@gmail.com>
Subject: Re: git-svn - canonicalize: Assertion `*src != '/'' failed.
Date: Mon, 26 Aug 2013 10:32:19 -0700
Message-ID: <CAKRnqNK4ZftcejAHjCcnFukr=Dm_U109uFmXEmXT+VpeW4DCBA@mail.gmail.com>
References: <521B8D61.8040608@gmail.com> <20130826172853.GR4110@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: GIT Development <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 26 19:32:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VE0ek-0001Fz-NE
	for gcvg-git-2@plane.gmane.org; Mon, 26 Aug 2013 19:32:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752124Ab3HZRcn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Aug 2013 13:32:43 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:55275 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751717Ab3HZRcm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Aug 2013 13:32:42 -0400
Received: by mail-wi0-f178.google.com with SMTP id c10so214970wiw.11
        for <git@vger.kernel.org>; Mon, 26 Aug 2013 10:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=LsDHQK2l7xQcPANH6mGVctu+FU+LSSRv4vX37IawZX0=;
        b=FkMbY+AizVZemP9OI5lMPB/O2QR+xmghaAJrEabjqiYgQdBrexRLh16DnWptRREwXM
         ZNeT4WPWoRiSDqIokGQeNrvy0FeSBjET37aNIdPghw1RkTcHCX9l3JFJWrkqVY3RO1iq
         AbltEFJ/4kgDnQQUgtzuTAMAGVMj0dKgXJLBVmPYLd665Xo7AdiNPXUEQI3s1IFsLndc
         ALc2ygNXtFQ0RNglm4canJlW6xmv9fXYZP8W/pk0JiKQUrFG7kKVT6VZ1ZGoAPJHU4Ve
         ODeNNK29inVRm8SniHnAFHfxagnuX4G6gbKcDpQ6hdsWLpPdfpCh/f8qvzQXVQfp7zPD
         Vt5Q==
X-Received: by 10.180.39.36 with SMTP id m4mr7766872wik.6.1377538361075; Mon,
 26 Aug 2013 10:32:41 -0700 (PDT)
Received: by 10.194.24.193 with HTTP; Mon, 26 Aug 2013 10:32:19 -0700 (PDT)
In-Reply-To: <20130826172853.GR4110@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233010>

Hi,

On Mon, Aug 26, 2013 at 10:28 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Bruce Korb wrote:
>> I was trying to clone a SVN repo, but not having luck:
>>
>>> $ git svn clone $PWD/private-lustre-svn $PWD/private-lustre-git
>>> perl: subversion/libsvn_subr/dirent_uri.c:321: canonicalize: Assertion `*src != '/'' failed.
>>> error: git-svn died of signal 6
>>
>> What is Perl or Subversion or GIT trying to tell me, please?  Thank you!
>
> What version of git are you using?  And what version of libsvn (and the
> libsvn perl bindings)?
>
> Thanks,

$ git --version
git version 1.8.1.4
$ git svn --version
git-svn version 1.8.1.4 (svn 1.7.11)

Thank, _you_! :)  -- Bruce
