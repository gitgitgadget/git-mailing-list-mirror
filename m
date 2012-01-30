From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 2/3] completion: remove old code
Date: Mon, 30 Jan 2012 15:59:33 +0200
Message-ID: <CAMP44s3vXSJaXiQK4X0kNOECzfLFsTo1YeMCtVZ0NWY-CHJ++A@mail.gmail.com>
References: <1327880479-25275-1-git-send-email-felipe.contreras@gmail.com>
	<1327880479-25275-3-git-send-email-felipe.contreras@gmail.com>
	<20120130023642.GA14986@burratino>
	<CAMP44s1H6Db6Xq_iZseXppaTwpBCeu14ySgPfmoQnpELfywQ-Q@mail.gmail.com>
	<7vd3a1erwf.fsf@alter.siamese.dyndns.org>
	<CAMP44s2j+qotu8Fb-1qq9bqHqt+ZF877YzZFXHiMo7Z_BGzTMA@mail.gmail.com>
	<CAH6sp9Of2rT4ESMYj9kC2NPtapsN58X3A0FpHTTZO-kSqpb-2Q@mail.gmail.com>
	<CAMP44s3a05dZqOqpDFDnWQ_C03EODgeP1eRhko-Mc8OjGXj6FQ@mail.gmail.com>
	<CAH6sp9PfVTTNL218syf-MS465M+sP4E8eVxuVCHZC0geE3ezfg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Frans Klaver <fransklaver@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 30 14:59:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rrrlk-0005H1-Lp
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jan 2012 14:59:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753002Ab2A3N7g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jan 2012 08:59:36 -0500
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:58550 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752974Ab2A3N7f (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Jan 2012 08:59:35 -0500
Received: by lagu2 with SMTP id u2so2204741lag.19
        for <git@vger.kernel.org>; Mon, 30 Jan 2012 05:59:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=W09VjjvAy6VZBGPCgbakp6ZhaAd5w9kp4Tdx1rPWJwM=;
        b=iNYJG2w4mOahMul7rSqOwBMZ2bOjo3EzL5+5i1jGsLQ8rO74D4bc5bjFdyTXb0Qvna
         4IxIQ7Vl97UBiCV7HtrB3qGd+qsfcL5c4oj4x1kpJpPYVLI1V2RSUJ+vbG5RlpEBZXWr
         kgg9aeGc3c0ZDWJUlQJarlF6mdcrHmsdBtqnA=
Received: by 10.112.99.202 with SMTP id es10mr654152lbb.89.1327931973884; Mon,
 30 Jan 2012 05:59:33 -0800 (PST)
Received: by 10.112.40.202 with HTTP; Mon, 30 Jan 2012 05:59:33 -0800 (PST)
In-Reply-To: <CAH6sp9PfVTTNL218syf-MS465M+sP4E8eVxuVCHZC0geE3ezfg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189361>

On Mon, Jan 30, 2012 at 2:21 PM, Frans Klaver <fransklaver@gmail.com> wrote:
> On Mon, Jan 30, 2012 at 12:55 PM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>
>> We are not talking about backwards compatibility; we are talking about
>> compatibility of remotes completion of the bash completion script of
>> repositories more than 3 years old with remotes that haven't been
>> migrated.
>
> What's not backward about that?

Not all backwards compatibility issues are the same.

>> This barely resembles the git-foo -> 'git foo', which truly broke
>> backwards compatibility, and at the time I proposed many different
>> approaches to deal with these type of problems, which seem to be
>> followed now (although probably not because of my recommendations).
>>
>> But this has nothing to do with _attitude_; I am merely stating fact.
>> I have never expressed any opinion or attitude with respect to how
>> backwards compatibility should be handled in this thread, have I?
>
> As far as I know you haven't explicitly said anything about that.
> There may still be a possibility that the sentence Junio quoted in his
> reply could have implied a certain attitude.

I already asked, but I ask again; what would be that attitude? Not
caring about backwards compatibility? Then that implication would have
been wrong.

If you look a few lines below, you would see a change that doesn't
break backwards compatibility, which proves the previous implication
wrong... Not to mention previous discussions.

>>> Maybe numbers for this could be generated from the next git user
>>> survey. If numbers justify this change, maybe this or something like
>>> it could be scheduled for a major release of git.
>>
>> Maybe, but I doubt this issue hardly deserves much discussion.
>
> I wouldn't know about that. Apparently not everybody is happy with
> applying it without further discussion.

Jonathan Nieder is happy with the 'ls -1 "$d/remotes"' change, and I
haven't seen anybody object it.

Either way. I'm not going to discuss in this thread any more. I'll
resend the patches, feel free to comment there.

-- 
Felipe Contreras
