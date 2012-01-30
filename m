From: Frans Klaver <fransklaver@gmail.com>
Subject: Re: [PATCH 2/3] completion: remove old code
Date: Mon, 30 Jan 2012 12:19:21 +0100
Message-ID: <CAH6sp9Of2rT4ESMYj9kC2NPtapsN58X3A0FpHTTZO-kSqpb-2Q@mail.gmail.com>
References: <1327880479-25275-1-git-send-email-felipe.contreras@gmail.com>
	<1327880479-25275-3-git-send-email-felipe.contreras@gmail.com>
	<20120130023642.GA14986@burratino>
	<CAMP44s1H6Db6Xq_iZseXppaTwpBCeu14ySgPfmoQnpELfywQ-Q@mail.gmail.com>
	<7vd3a1erwf.fsf@alter.siamese.dyndns.org>
	<CAMP44s2j+qotu8Fb-1qq9bqHqt+ZF877YzZFXHiMo7Z_BGzTMA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 30 12:19:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RrpGh-00053C-HB
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jan 2012 12:19:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752274Ab2A3LTX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jan 2012 06:19:23 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:33841 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752135Ab2A3LTW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jan 2012 06:19:22 -0500
Received: by qcsg15 with SMTP id g15so2137051qcs.19
        for <git@vger.kernel.org>; Mon, 30 Jan 2012 03:19:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=q4Nw90Y1F09gO5n9kdyk8e/jKY2MvOc1DW26wQDIG+M=;
        b=Nms6PlIj3Gol++acNXy7SMgf1/aY08xCDPyKteo9+OTkGNE5tw+Z90N6+gsLEbW0Ta
         43qGgk9GbHqZ7nHqQFzkEabKBtUiycgdDk5CWBt93R7lZ7eJwT+DHraa8IerUbb+TMxe
         9r7efQOMeY/6BuQFGCMA/KelpU1yD3K7FcLEw=
Received: by 10.229.137.72 with SMTP id v8mr6225568qct.43.1327922361554; Mon,
 30 Jan 2012 03:19:21 -0800 (PST)
Received: by 10.224.105.143 with HTTP; Mon, 30 Jan 2012 03:19:21 -0800 (PST)
In-Reply-To: <CAMP44s2j+qotu8Fb-1qq9bqHqt+ZF877YzZFXHiMo7Z_BGzTMA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189343>

Hi,

On Mon, Jan 30, 2012 at 11:51 AM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> On Mon, Jan 30, 2012 at 6:27 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>
>>> OK, maybe some people use it, but most likely they are using an old
>>> version of git, and thus an old version of the completion script.
>>
>> Please adjust your attitude about backward compatibility to match the
>> standard used for other parts of Git.
>
> What attitude?

This attitude:

> I am simply stating a fact. How much percentage of
> people do you think still have .git/remotes around? How many people do
> you think have clones more than 3 years old? And how many of these
> people would complain if remotes were not properly completed for these
> repos?
>
> I doubt anybody would have complained, but I guess we would never
> know, because I already proposed a solution that would work for them
> and only uses a *single* line of code, unlike the current 40 ones.
>
> I don't see what is the problem with the attitude of sending a patch
> to remove code that most likely nobody cares about (neither you or I
> have numbers on this), and then finding an alternative when people do
> care about it.

I don't think Junio actually meant an "attitude", but just your angle
of approach (== attitude) on backwards compatibility.

Maybe numbers for this could be generated from the next git user
survey. If numbers justify this change, maybe this or something like
it could be scheduled for a major release of git.

Cheers,
Frans
