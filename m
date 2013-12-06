From: Muzaffer Tolga Ozses <tolga@ozses.net>
Subject: Re: Git reports
Date: Fri, 6 Dec 2013 21:24:09 +0200
Message-ID: <CAMAQ3nL0xRQRqsUK+TuZqS5_LOpCtyi1xLRbZAw7zrEBU_0+sQ@mail.gmail.com>
References: <CAMAQ3n+OtBdYALh4pg6kywtbgPtQjHr6Xc-2ff63df-h=TLwbA@mail.gmail.com>
	<20131206210035.17413ee7bcdf3ca0c9655d81@domain007.com>
	<20131206210958.59f553060e3802d56f4a53b8@domain007.com>
	<CAMAQ3nKVjF-5oW2pZZaD9MSz9wqoXJBQDoGcdy5mb=gxCguuSA@mail.gmail.com>
	<20131206215334.1a9031a1450d9c436943ce3d@domain007.com>
	<CAMAQ3nLgnpDo1jWFL1rqtEvmQm8LeEpZ41Uxo0GTQOk8ttpSZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Konstantin Khomoutov <flatworm@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Fri Dec 06 20:24:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vp10a-0004Es-Fo
	for gcvg-git-2@plane.gmane.org; Fri, 06 Dec 2013 20:24:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754040Ab3LFTYM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Dec 2013 14:24:12 -0500
Received: from mail-wi0-f169.google.com ([209.85.212.169]:54533 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753417Ab3LFTYL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Dec 2013 14:24:11 -0500
Received: by mail-wi0-f169.google.com with SMTP id hn6so1437708wib.2
        for <git@vger.kernel.org>; Fri, 06 Dec 2013 11:24:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=dzGNlMOfXXtCwrqJt0heWpJQRSqRYK9u2F84tOGr+gY=;
        b=jidrxYCSGVEzIgw/eSz7UfCvhDF/5mKUOVGrgOlxh1dOCjqQYSnJDrFGP87PjeF7xs
         80E1tHDYeR6z/AfCEEt27jyKH3FS5O9ogILESyUW5N+N2QHDchwXq6FSK8en0+Ggaxql
         f+9PetaBCvl7OOR8voDx6etUiVM63kT3/pGMVrZsdResVYJ2NsTJZJ8lWAgL4VCPfqiA
         F+LXX3ZJts2nNFG9OKKeyasBFAkQSVNCkz3W1+C4cK5GrCO7A2G9BzdGChVXJq0wqIcz
         EIQku+8uSFBaBdGrRVTUc8tce+4x8drTWciBoHQ2guRnZacBIrd5TJzJQaYcFTvnmvdF
         q9EQ==
X-Gm-Message-State: ALoCoQn9JZG5gTeCpj23m7+Fj7gUb8EdLfbhNQlsi/OOBs77CN9GX5fS1PJjXALSzXYy0cXUNfeo
X-Received: by 10.194.20.202 with SMTP id p10mr31601783wje.39.1386357850042;
 Fri, 06 Dec 2013 11:24:10 -0800 (PST)
Received: by 10.216.174.70 with HTTP; Fri, 6 Dec 2013 11:24:09 -0800 (PST)
X-Originating-IP: [46.196.57.29]
In-Reply-To: <CAMAQ3nLgnpDo1jWFL1rqtEvmQm8LeEpZ41Uxo0GTQOk8ttpSZA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238945>

Sorry, my git server is on CentOS and git 1.8.4.2 and my machine on
which I clone is Ubuntu, 1.8.3.2

On 6 December 2013 21:19, Muzaffer Tolga Ozses <tolga@ozses.net> wrote:
> Hi,
>
>> What protocol/transport are you using (http, ssh, git)?
> I am cloning over http
>
>> Can you try running with:
>
>  GIT_TRACE_PACKET=$PWD/trace.out git clone ...
> GIT_TRACE_PACKET=$PWD/trace.out git clone
> http://git.webciniz.im/project/night_pharmacy.git
> Cloning into 'night_pharmacy'...
> Checking connectivity... done
>
> That's all I get. No trace.out was written.
>
>> So let's do the next test: does
>
>     echo test >&2
>
> print "test" on the box where Git does not report progress?
>
> Yes it does.
>
>> Another one: does Git report progress if you explicitly pass --progress
> to it?
>
> git clone --progress http://git.webciniz.im/project/night_pharmacy.git
> Cloning into 'night_pharmacy'...
> Checking connectivity... done
>
> That's all I get
>
>> Does it work if you do
>
>     git clone $URL 2>&1
>
> git clone http://git.webciniz.im/project/night_pharmacy.git 2>&1
> Cloning into 'night_pharmacy'...
> Checking connectivity... done
>
> That's all I get.
>
> Regards
> mto
>
> On 6 December 2013 19:53, Konstantin Khomoutov
> <flatworm@users.sourceforge.net> wrote:
>> On Fri, 6 Dec 2013 19:44:21 +0200
>> Muzaffer Tolga Ozses <tolga@ozses.net> wrote:
>>
>> [...]
>>> >> > Resolving deltas: 100% (369/369), done.
>>> >> >
>>> >> > whereas I don't get those with my own. What could I be doing
>>> >> > wrong?
>> [...]
>>> >> So it might turn out on your own server Git for some reason fails
>>> >> to figure out its standard error stream is connected to a terminal.
>>> >> Or, the error stream of your shell process is redirected somewhere
>>> >> (and hence inherited by Git).
>> [...]
>>> > So you might face a misbehaving shell logon script for instance.
>>> >
>>> > As to whether Git senses the TTY -- what does running
>>> >
>>> >   stty
>>> >
>>> > tells you?  Does it fail with something like "inappropriate ioctl
>>> > for device" or prints a couple of settings?
>>> stty tells me
>>> speed 38400 baud; line = 0;
>>> eol = M-^?; eol2 = M-^?; swtch = M-^?;
>>> ixany iutf8
>>>
>>> And I run identical commands on both servers, only URL changes.
>>
>> OK, so we could supposedly rule out the possibility Git does not sense
>> it's connected to a terminal.
>>
>> So let's do the next test: does
>>
>>     echo test >&2
>>
>> print "test" on the box where Git does not report progress?
>>
>> Another one: does Git report progress if you explicitly pass --progress
>> to it?
>>
>> Does it work if you do
>>
>>     git clone $URL 2>&1
>>
>> ?
>>
>> What Git and OS versions are on both machines?
