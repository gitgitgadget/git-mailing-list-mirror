From: Stephen Kelly <steveire@gmail.com>
Subject: Re: [PATCH v2] Introduce new configuation option to override
 committer information
Date: Thu, 20 Jan 2011 16:24:09 +0100
Message-ID: <AANLkTin-zUbVmJ3gUsDE5+AkECoAzN2Oim4=45JrcT6o@mail.gmail.com>
References: <igadki$4tb$2@dough.gmane.org>
	<1294568989-5848-1-git-send-email-artagnon@gmail.com>
	<ih95il$62b$2@dough.gmane.org>
	<201101201352.01874.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Jan 20 16:24:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PfwN4-0004pE-3k
	for gcvg-git-2@lo.gmane.org; Thu, 20 Jan 2011 16:24:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755897Ab1ATPYL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Jan 2011 10:24:11 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:61945 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755760Ab1ATPYK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Jan 2011 10:24:10 -0500
Received: by qwa26 with SMTP id 26so735199qwa.19
        for <git@vger.kernel.org>; Thu, 20 Jan 2011 07:24:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=kH/SOduD+xN9u0cxMaY7a1Rkw3psZLPG3VYthv1150s=;
        b=VU6p0KRNBvV9YGDj0zrKahVVHaw+BpoPMlpfMFJjhpiCPEyupONhE6CvoY6egyWx+n
         mTPduOvyXLFiwWfV0AFOvvGW4S5SYvMz7+WIwxpfN8d8IqA3ujxXjpIhzauNqpXWVvNh
         UDJ1oXan7cYloz1UJ15mSmv2NLkoxi7OKfaWE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=wM2tkAC/TxWkABDoqrnLnvukBE4cLJ33h/0fOpYySviRN9ZTxdl3s5+92dHNoVrt6k
         RqMh44+fxlOXvJK2zNkuQ0ee4uOV2zOLONRaR561qKB/XJT9skjGFdBk1FgUeGMh6zk7
         5pr0LPYoJLa9YkxDYBpwUbgVfeqQ4Opl1e+Uo=
Received: by 10.229.226.72 with SMTP id iv8mr1882217qcb.204.1295537049471;
 Thu, 20 Jan 2011 07:24:09 -0800 (PST)
Received: by 10.229.80.84 with HTTP; Thu, 20 Jan 2011 07:24:09 -0800 (PST)
In-Reply-To: <201101201352.01874.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165316>

On Thu, Jan 20, 2011 at 1:52 PM, Thomas Rast <trast@student.ethz.ch> wrote:
> Stephen Kelly wrote:
>>
>> Is this patch going to become part of git, or is it in already?
>>
>> If not it will probably just get lost because there is no issue tracker.
>
> Discussion stalled without an agreement that any patch proposed is
> "good", so if it ends here it will be dropped.
>
> You could probably help getting closer to a solution by:
>
> * Not dropping Cc's all the time.  I saw this email just by chance.

Sorry. I've never used a mailing list where you have to keep everyone
in the CC. I use KNode for reading and writing to mailing lists. I
don't see why you can get involved in a thread from the initial mail
presumably because you read the title and decide it's interesting and
then miss the replies even though they have the same title.

How does it work in this case:

Title - Stephen
* Re: Title - Alice
* * Re Title - Bob
* Re Title - Charlie

If you reply to Bob, do you also add Charlie to the CC? Do you search
through everyone in long threads and make sure they're all CC'd?

I'm just trying to understand the mindset/process that everyone else
on this list seems to use.

FWIW there's no need to CC me on replies. I'll see it anyway :)

>
> * Stating *why* this cannot be solved in any other way on the KDE
>  end.  So far you only said
>
>  > > Is it impossible to fix this on the KDE side?  I would think a
>  > > many-to-one mapping from committer identities to bugzilla account
>  > > names could be a useful thing to have in any case.
>  >
>  > I asked that before coming here, and apparently that is not possible.

I filed a bug with the KDE sysadmins asking if there was a way of
configuring multiple email addresses in bugzilla. I didn't think of
adding some custom keywords to the template as you suggest below.

>
>  My gut feeling is that a footer line in the commit along the lines
>  of
>
>    Bugzilla-Id: Registered Name <registered.email@example.com>
>
>  would work.  I suspect others have a similar feeling.  A good case
>  why this is not a feasible solution for (presumably) border cases
>  like you would help get rid of it.

Yes, my case is a border case. This solution seems to duplicate the
committer email address in concept. It also requires more work for the
KDE sysadmins.

I think the better solution is to maintain a patched version of git
externally. Silly as that sounds.

>
> * Replying to e.g.
>
>    http://mid.gmane.org/201101111542.15185.trast@student.ethz.ch
>
>  with (ideally better) ideas of what the semantics should be.  My
>  assessment is that it either conflicts with user expectations or
>  with established git-config mechanisms of how the various files
>  override each other.

Yes, I see what you mean in you example. If git config doesn't have
any cases like this already then there's no prior art and two ways
forward. I don't want to bikeshed it, so if you want just pick a
solution and run with it. Otherwise I'll just continue using my
patched version and drop the issue here.

Thanks,

Steve.
