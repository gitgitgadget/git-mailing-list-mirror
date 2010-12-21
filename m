From: Thiago Farina <tfransosi@gmail.com>
Subject: Re: [PATCH] trace.c: mark file-local function static
Date: Tue, 21 Dec 2010 13:59:31 -0200
Message-ID: <AANLkTimZ=xBCewESqQmOfOggkAOvqnZfavU2suLT6ATJ@mail.gmail.com>
References: <AANLkTinxJdASW6mQVU50grA2mUz6gt+gUND30VRK=BCN@mail.gmail.com>
	<AANLkTimBtpOx_GBzC=g4V6jW2aiF7Hg8uALWt2NQFFZG@mail.gmail.com>
	<1292846433.19322.1.camel@drew-northup.unet.maine.edu>
	<AANLkTimkxJHvTAvra+B-0bAQopd8s21ZrFCPG_ALbZZ9@mail.gmail.com>
	<1292863989.19322.27.camel@drew-northup.unet.maine.edu>
	<AANLkTin2QuMF93RqrRcScxvkzhU4OFJ9Nt42tV+FOjxS@mail.gmail.com>
	<1292934581.26698.14.camel@drew-northup.unet.maine.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "Vasyl'" <vvavrychuk@gmail.com>, git@vger.kernel.org
To: Drew Northup <drew.northup@maine.edu>
X-From: git-owner@vger.kernel.org Tue Dec 21 16:59:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PV4cm-0005xv-LM
	for gcvg-git-2@lo.gmane.org; Tue, 21 Dec 2010 16:59:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750943Ab0LUP7e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Dec 2010 10:59:34 -0500
Received: from mail-bw0-f45.google.com ([209.85.214.45]:48814 "EHLO
	mail-bw0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750907Ab0LUP7d (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Dec 2010 10:59:33 -0500
Received: by bwz16 with SMTP id 16so4714594bwz.4
        for <git@vger.kernel.org>; Tue, 21 Dec 2010 07:59:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=IwC75spDMqPGPNjFGOcGr8Bk1LGTkQzVuTUyT/Ieh3o=;
        b=x2lZIYBf7Jhsluhjgmdybnkw0CcUGVGBri7M0y5Lk0f9AwxDEqKGCSfdpru3kknwNH
         dzOgWx1oN5nP/1NY3JNdO2e23KiCIw7ZM9xDl8+10ChN0R02SDmuoU7upEaqPYzjahX7
         iNHcfIfXYFeqlFAU3It3ORH7+9wLWzYY/nRT8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=MBOKskD43MGlg7Gh/XFeo3Ee++/Qf5USizG5QmmvhRly2XXYAcMe3ZFE3vWT01IAPB
         +wDST1cYDc+Y4W4sqObWlmU4awHIXay8pAGa0zH8F9F7CoWAYYwiMBqVTgGnKs4T895r
         D5iwXHG6zk6y+XuVy/ap1UHjAmUrt00/R5+WM=
Received: by 10.204.99.69 with SMTP id t5mr4899155bkn.124.1292947171970; Tue,
 21 Dec 2010 07:59:31 -0800 (PST)
Received: by 10.204.141.82 with HTTP; Tue, 21 Dec 2010 07:59:31 -0800 (PST)
In-Reply-To: <1292934581.26698.14.camel@drew-northup.unet.maine.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164038>

On Tue, Dec 21, 2010 at 10:29 AM, Drew Northup <drew.northup@maine.edu> wrote:
> While I think the code change is fairly clear, as I said earlier: without a commit message we don't have
> a good reason for not making it non-static again later on, flip-flopping
> ad-infinitum.
>

Why you are complain about a one word change at all? Are you the
maintainer? Are you going to make a change that uses do_nothing in
future? If for some reason someone needs to use this function in other
place, the problem is of this person not you, he you will have to
argue and defend his change for whatever reasons he has, and will be a
problem for the maintainer not for you.


> Commit messages for isolated changes such as this build up a story, if
> you will, providing future contributors with insight as to why the group
> made a change when it did--even when the change is minor (in fact often
> most importantly when the change is minor)--by putting it in context.
>
We all know that, and Junio is doing a good job enforcing GOOD commit
messages. But in this case this is STUPID in my pov (others can and
probably will disagree with me, but I don't care).

>> > Alas the best way to avoid such a situation is to explain why a change
>> > was made to begin with.
>> >
>>
>> So, you are welcome to contribute and suggest such description for
>> this trivial (that may break non-trivial things) patch. So we can
>> please you and others in the future.
>
> As I am complaining that I don't know what the submitter was thinking
> that sounds particularly odd to me. How I am supposed to describe for
> the group what the commit's author was thinking in a commit message that
> I would like to see added to a patch when in fact the whole problem is
> that I don't know specifically what he was thinking?

Well, what the hell we are talking about so? If you are arguing for a
commit message, I would expect that you would have a suggestion, at
least to show why you are so interested in this particular patch.

And many contributors here, besides suggesting BETTER commit messages,
they help others with how the patch could be written, and you are not
helping in either way.
