From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: Re: [PATCH v2] Documentation/git-pull: clarify configuration
Date: Wed, 10 Nov 2010 20:43:29 -0500
Message-ID: <AANLkTikT4N5JAxRxPCbx=xAokRKOvvxDQ4pAC9CcpObB@mail.gmail.com>
References: <1289373188-32543-1-git-send-email-martin.von.zweigbergk@gmail.com>
	<7voc9xhyfx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 11 02:43:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGMCP-0004HU-Qr
	for gcvg-git-2@lo.gmane.org; Thu, 11 Nov 2010 02:43:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932159Ab0KKBnb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Nov 2010 20:43:31 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:45203 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932078Ab0KKBna convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Nov 2010 20:43:30 -0500
Received: by qwi4 with SMTP id 4so1128102qwi.19
        for <git@vger.kernel.org>; Wed, 10 Nov 2010 17:43:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=zhpCVHeKvy2FCKbsrTU2pcpG91PHSqyOcn25i+P1L5w=;
        b=SXNPylXQfa3RL3qhXvhk5KnH4l18N4bE7aS2SIRNWq0AcRv4oTcQof0rJU+dT6f3lI
         NTSWlvAized2tTc/VNu8E+H6D9WxGf4xwGhUp8BUXmq8Usk6I9qK4NqRv4z5u53OgYFe
         9XrrerAIvTmnOrxASlN0Ua+/L+q09/ogdF3Bk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=H4TDrQ3SxAwSWfKv6G/9JQdDW1MCmcTRowBVcG7rhEj5LG//wRPQJbp5ngq+QbEh01
         0ZCFpRzWV7mcH4o4YaMqoyNJjIi4utGYm9JpvPphWNb0ISlgKnq5sWIJsulYo5ebzNZ0
         tsGHOm4DpK8EKqJDHpmbFsl211iUipX7LRlCo=
Received: by 10.224.191.196 with SMTP id dn4mr272873qab.225.1289439809228;
 Wed, 10 Nov 2010 17:43:29 -0800 (PST)
Received: by 10.224.138.5 with HTTP; Wed, 10 Nov 2010 17:43:29 -0800 (PST)
In-Reply-To: <7voc9xhyfx.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161202>

On Wed, Nov 10, 2010 at 12:37 PM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> Martin von Zweigbergk <martin.von.zweigbergk@gmail.com> writes:
>
>> diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
>> index c50f7dc..055126e 100644
>> --- a/Documentation/git-pull.txt
>> +++ b/Documentation/git-pull.txt
>> @@ -92,12 +92,15 @@ include::merge-options.txt[]
>> =A0:git-pull: 1
>>
>> =A0--rebase::
>> - =A0 =A0 Instead of a merge, perform a rebase after fetching. =A0If
>> - =A0 =A0 there is a remote ref for the upstream branch, and this br=
anch
>> - =A0 =A0 was rebased since last fetched, the rebase uses that infor=
mation
>> - =A0 =A0 to avoid rebasing non-local changes. To make this the defa=
ult
>> - =A0 =A0 for branch `<name>`, set configuration `branch.<name>.reba=
se`
>> - =A0 =A0 to `true`.
>> + =A0 =A0 Instead of merging, rebase the current branch on top of th=
e
>> + =A0 =A0 upstream branch after fetching. =A0If there is a remote-tr=
acking
>> + =A0 =A0 branch corresponding to the upstream branch and the upstre=
am
>> + =A0 =A0 branch was rebased since last fetched, the rebase uses tha=
t
>> + =A0 =A0 information to avoid rebasing non-local changes.
>> +
>> + =A0 =A0 The default behavior is to merge rather than rebasing, but=
 it
>> + =A0 =A0 can be overridden per branch with the `branch.<name>.rebas=
e`
>> + =A0 =A0 configuration item (see git-config(1)).
>
> The explanation looks correct in the sense that it does not say anyth=
ing
> incorrect, and the description of non-local change exclusion in the f=
irst
> paragraph is more readable, I think.
>
> But I am not sure if we want a separate paragraph here only to repeat=
 a
> half of what the second paragraph in the DESCRIPTION section already =
said.
> The "default is merge" is implied by "Instead of merging" at the begi=
nnig
> of this part anyway.
>
> Also have you tried to actually format this and checked the result be=
fore
> submitting the patch?
>
> Perhaps doing it like this may be better (no I didn't run AsciiDoc on=
 it).
>
>
> --rebase::
> =A0 =A0 =A0 =A0Rebase the current branch on top of the upstream branc=
h after
> =A0 =A0 =A0 =A0fetching. =A0If there is a remote-tracking branch corr=
esponding to
> =A0 =A0 =A0 =A0the upstream branch and the upstream branch was rebase=
d since last
> =A0 =A0 =A0 =A0fetched, the rebase uses that information to avoid reb=
asing
> =A0 =A0 =A0 =A0non-local changes.
> +
> See `branch.<name>.rebase` in linkgit:git-config[1] if you want to ma=
ke
> `git pull` always use `{litdd}rebase` instead of merging.

I'm happy with either your suggestion or Jonathan's. Do you want me to
send an updated patch to the list or will you make the change directly?

While writing a reply to another message, I happened to spot a similar
problem in the documentation for 'git rebase -s'. It currently says "Us=
e
the given merge strategy. If there is no -s option git merge-recursive
is used instead. This implies --merge." and I assume the last sentence
refers to the first one in this case too. Same question here: Should I
send a patch?
