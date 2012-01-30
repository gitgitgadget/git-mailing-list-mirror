From: Frans Klaver <fransklaver@gmail.com>
Subject: Re: [PATCH 2/3] completion: remove old code
Date: Mon, 30 Jan 2012 13:21:13 +0100
Message-ID: <CAH6sp9PfVTTNL218syf-MS465M+sP4E8eVxuVCHZC0geE3ezfg@mail.gmail.com>
References: <1327880479-25275-1-git-send-email-felipe.contreras@gmail.com>
	<1327880479-25275-3-git-send-email-felipe.contreras@gmail.com>
	<20120130023642.GA14986@burratino>
	<CAMP44s1H6Db6Xq_iZseXppaTwpBCeu14ySgPfmoQnpELfywQ-Q@mail.gmail.com>
	<7vd3a1erwf.fsf@alter.siamese.dyndns.org>
	<CAMP44s2j+qotu8Fb-1qq9bqHqt+ZF877YzZFXHiMo7Z_BGzTMA@mail.gmail.com>
	<CAH6sp9Of2rT4ESMYj9kC2NPtapsN58X3A0FpHTTZO-kSqpb-2Q@mail.gmail.com>
	<CAMP44s3a05dZqOqpDFDnWQ_C03EODgeP1eRhko-Mc8OjGXj6FQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 30 13:21:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RrqEZ-0007dH-5b
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jan 2012 13:21:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752694Ab2A3MVP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jan 2012 07:21:15 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:55792 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752606Ab2A3MVO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jan 2012 07:21:14 -0500
Received: by qcsg15 with SMTP id g15so2165729qcs.19
        for <git@vger.kernel.org>; Mon, 30 Jan 2012 04:21:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=XRoscUyhInFiOQHXJF4ySuuOY+ihM4AADlA07R7iO7c=;
        b=h53OotA+pQHpRrnM6UXopDL+Q0PV05IMVJfz5nxwNgpNATUKdhvWjluSuRtTwRs6N7
         A/oP1gj3OwbMyrOZY7umSJ7YBPri/VEX7P7NM1uHWQ8K+d8YY2X+qd5HrSGsygS7b1x9
         DJkZw4dD6GbTCUD3OBnZqNxzN41slD8svU5R8=
Received: by 10.229.77.31 with SMTP id e31mr6284560qck.63.1327926073719; Mon,
 30 Jan 2012 04:21:13 -0800 (PST)
Received: by 10.224.105.143 with HTTP; Mon, 30 Jan 2012 04:21:13 -0800 (PST)
In-Reply-To: <CAMP44s3a05dZqOqpDFDnWQ_C03EODgeP1eRhko-Mc8OjGXj6FQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189356>

On Mon, Jan 30, 2012 at 12:55 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:

> We are not talking about backwards compatibility; we are talking about
> compatibility of remotes completion of the bash completion script of
> repositories more than 3 years old with remotes that haven't been
> migrated.

What's not backward about that?


> This barely resembles the git-foo -> 'git foo', which truly broke
> backwards compatibility, and at the time I proposed many different
> approaches to deal with these type of problems, which seem to be
> followed now (although probably not because of my recommendations).
>
> But this has nothing to do with _attitude_; I am merely stating fact.
> I have never expressed any opinion or attitude with respect to how
> backwards compatibility should be handled in this thread, have I?

As far as I know you haven't explicitly said anything about that.
There may still be a possibility that the sentence Junio quoted in his
reply could have implied a certain attitude.

>> Maybe numbers for this could be generated from the next git user
>> survey. If numbers justify this change, maybe this or something like
>> it could be scheduled for a major release of git.
>
> Maybe, but I doubt this issue hardly deserves much discussion.

I wouldn't know about that. Apparently not everybody is happy with
applying it without further discussion.

Cheers,
Frans
