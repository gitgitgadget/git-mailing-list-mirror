From: Lars Hjemli <hjemli@gmail.com>
Subject: Re: [PATCH 0/2] Add submodule-support to git archive
Date: Mon, 26 Jan 2009 00:12:25 +0100
Message-ID: <8c5c35580901251512q5058dde3rdfae81979c46c36a@mail.gmail.com>
References: <1232844726-14902-1-git-send-email-hjemli@gmail.com>
	 <20090125135340.6117@nanako3.lavabit.com>
	 <8c5c35580901250018x6827291cj36e6bcb10afa9b27@mail.gmail.com>
	 <7veiyrdszf.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Nanako Shiraishi <nanako3@lavabit.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 26 00:14:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LREAp-0005lM-Dc
	for gcvg-git-2@gmane.org; Mon, 26 Jan 2009 00:13:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750877AbZAYXM1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Jan 2009 18:12:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750781AbZAYXM0
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Jan 2009 18:12:26 -0500
Received: from rv-out-0506.google.com ([209.85.198.232]:17704 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750775AbZAYXM0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jan 2009 18:12:26 -0500
Received: by rv-out-0506.google.com with SMTP id k40so5595716rvb.1
        for <git@vger.kernel.org>; Sun, 25 Jan 2009 15:12:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=/0SUOTRsEQyqSoDP8+Z6uZY8Zf/SFViJVSxIfaRh2zk=;
        b=aTneLckjRLPHSewbi8JPr3Qbn6KK56DaEDuygnrm0V9G5qmrKS42pQOWLvUDo6+7iA
         gVSrG9cJFskhO7K7fx/cHhr1Exbj62xgbCvdhbdC05+Zep60bem3odU57ZFEwR+JY5A9
         sOm5XkVqcD7xLjNFhqv8qe31eEpw3zNKkaHDY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=X3ZZPH4KdIp+Qb9uK3FqfIdQOENJSAqfATG+RQoONxO9AHZ497erqOIggKxnjElsTb
         iKvKV1kr0Ef/IGT0LE1JQVeKz69sMQTTEpnePgTRNFBhKMMecjzvTaxXfQfri6RtVwHw
         LPKRVSczQ2nXPHppfX2hNzzN3UexMEtvjJ7fg=
Received: by 10.114.57.1 with SMTP id f1mr699437waa.145.1232925145546; Sun, 25 
	Jan 2009 15:12:25 -0800 (PST)
In-Reply-To: <7veiyrdszf.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107120>

On Sun, Jan 25, 2009 at 21:35, Junio C Hamano <gitster@pobox.com> wrote:
> Lars Hjemli <hjemli@gmail.com> writes:
>
>> On Sun, Jan 25, 2009 at 05:53, Nanako Shiraishi <nanako3@lavabit.com> wrote:
>>> What would I do to try this new series? Fork a branch from Junio's master branch,
>>> apply your new patches, and merge the result to Junio's next?
>>
>> Yes, that sounds right (btw: the series is buildt on top of 5dc1308562
>> (Merge branch 'js/patience-diff') and can be pulled from
>> git://hjemli.net/pub/git/git lh/traverse-gitlinks).
>>
>> But before merging with 'next', you'll need to `git revert -m 1 bdf31cbc00`.
>
> Yuck, that is too much to ask for regular testers and users.

Sorry about that.


> Could we switch to incremental refinements once a series hits next, pretty
> please?

The problem in this particular case is that the design has changed so
much since the first iteration that we're not really talking about
incremental refinements but rather a different approach to the same
problem.

If you want me to build on top of the series in next anyways, would it
be acceptable if the first patch on top of ee306d2d59 reverts the
previous attempt? I think the rest of the series will be easier to
review that way.

--
larsh
