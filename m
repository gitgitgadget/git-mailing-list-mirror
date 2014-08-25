From: Robert Dailey <rcdailey.lists@gmail.com>
Subject: Re: Show containing branches in log?
Date: Mon, 25 Aug 2014 18:35:01 -0500
Message-ID: <CAHd499CrxakA6+X8M0Ty4YtrRWjtsBUpwDW132NkSmp650SH+w@mail.gmail.com>
References: <CAHd499A78BRVawWSHNnzJcD1Ca7RfFeEnJf0SB7py1MD5qwL0g@mail.gmail.com>
	<CAA787rm=Pjy-GGzxCcy=NQNLUOCrTt4hYWS9iND8EAxxs67SuQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git <git@vger.kernel.org>
To: =?UTF-8?B?w5h5dmluZCBBLiBIb2xt?= <sunny@sunbase.org>
X-From: git-owner@vger.kernel.org Tue Aug 26 01:35:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XM3nJ-0002si-4a
	for gcvg-git-2@plane.gmane.org; Tue, 26 Aug 2014 01:35:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756746AbaHYXfR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 Aug 2014 19:35:17 -0400
Received: from mail-vc0-f174.google.com ([209.85.220.174]:62161 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755221AbaHYXfF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Aug 2014 19:35:05 -0400
Received: by mail-vc0-f174.google.com with SMTP id la4so15964265vcb.19
        for <git@vger.kernel.org>; Mon, 25 Aug 2014 16:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=yboMNF6P558n39uELiR8bMyyfbJan5qhh0XnUKKdSpw=;
        b=hgEAF2bMneWIq9H7/IyU3t1UFPv1+zZdzHiVsupoZ1x+r+rQeRXM/iinQZNdzwyTHh
         18vbMICJSGuiSUTUduDzQIHXU7ynWRpfaEWokI8KFJSLYu5wluGzloieDqOvXA3cuIxm
         U/8SslVlIDkhYxkWgtuaJscPl7gQiA6Ma1vT0MsczDauIvwSev4gLIL4Y408egLKcZEv
         wm2d1nQVUfbWKCTWetbPCUtDMVl7o2nBM7bZPiw/UUzzCMFo2tBRLlTC6VuXCuoqE8z6
         JzRgvO5Cs6+J1sJhotG8Wr7CqELqhhux1ZamQkm3DaCAs3SV2l1P2ozKMQN+qZRMaAcq
         sWtw==
X-Received: by 10.220.119.8 with SMTP id x8mr4148376vcq.62.1409009703399; Mon,
 25 Aug 2014 16:35:03 -0700 (PDT)
X-Google-Sender-Delegation: rcdailey@gmail.com
Received: by 10.220.102.201 with HTTP; Mon, 25 Aug 2014 16:35:01 -0700 (PDT)
In-Reply-To: <CAA787rm=Pjy-GGzxCcy=NQNLUOCrTt4hYWS9iND8EAxxs67SuQ@mail.gmail.com>
X-Google-Sender-Auth: RXOpkRHZAv4oTZF7TnfkFJIYgGo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255876>

On Thu, Jul 3, 2014 at 2:41 PM, =C3=98yvind A. Holm <sunny@sunbase.org>=
 wrote:
> On 2 July 2014 16:50, Robert Dailey <rcdailey.lists@gmail.com> wrote:
>> I know that with the `git branch` command I can determine which
>> branches contain a commit. Is there a way to represent this
>> graphically with `git log`? Sometimes I just have a commit, and I ne=
ed
>> to find out what branch contains that commit. The reason why `git
>> branch --contains` doesn't solve this problem for me is that it name=
s
>> almost all branches because of merge commits. Too much ancestry has
>> been built since this commit, so there is no way to find the "closes=
t"
>> branch that contains that commit.
>>
>> Is there a way to graphically see what is the "nearest" named ref to
>> the specified commit in the logs?
>
> I have created a script for just this functionality which I use very
> often, and have created a gist with the files at
> <https://gist.github.com/sunny256/2eb583f21e0ffcfe994f>, I think it
> should solve your problem. It contains these files:
>
>   git-wn
>
> "wn" means "What's New" and will create a visual graph of all commits
> which has a specified ref as ancestor. It also needs the following
> script, just put it into your $PATH somewhere:
>
>   git-lc
>
> "lc" means "List branches Containing this commit" and generates a lis=
t
> of all branches containing a specified ref.
>
> The files originates from <https://github.com/sunny256/utils>, but
> I've modified them in the gist to make your life easier. :)
>
> Hope that helps,
> =C3=98yvind

I'm finally getting around to trying this out but it isn't working on
Windows because there is no fmt command in msysgit. Do you have a
workaround I can use? Thanks.
