From: Patrick Doyle <wpdster@gmail.com>
Subject: Re: How to do a fast-forward merge without a checkout?
Date: Mon, 18 Jul 2011 11:25:46 -0400
Message-ID: <CAF_dkJBWzOR76RUrB9P2UkLfR8_vhU-ExGROu73dAg=JJN-p_Q@mail.gmail.com>
References: <CAF_dkJCvtVqoDmRXMy23ZnZL6iUAVX0nNA9Ev6e4zvBp9mfTpg@mail.gmail.com>
 <4E244C75.6060407@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Jul 18 17:26:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qipi9-0005GN-SE
	for gcvg-git-2@lo.gmane.org; Mon, 18 Jul 2011 17:26:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753050Ab1GRP0K convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 18 Jul 2011 11:26:10 -0400
Received: from mail-fx0-f52.google.com ([209.85.161.52]:51923 "EHLO
	mail-fx0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753007Ab1GRP0I convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Jul 2011 11:26:08 -0400
Received: by fxd18 with SMTP id 18so6838994fxd.11
        for <git@vger.kernel.org>; Mon, 18 Jul 2011 08:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=dJyOJB/yTHGHhbxwy4dYvM49fNhAlq8Culh99e88SYE=;
        b=OcnPfPq3BYfFc8yFIES+lE95KPcKjQxTM5ZYuRfoUV92HqMIyoQ40IHj+4L+sXGeGo
         LuAPm/8cdsR2XeiwUyiy29REGT5nSpU8oXYRYhClwNNBg2NHBBn/J4OVq5Cc/4nUZ1Qo
         tGMa7kPTNQpTCl13MSQKt0gLUqFQhg1toRWsg=
Received: by 10.223.145.7 with SMTP id b7mr6159235fav.56.1311002766095; Mon,
 18 Jul 2011 08:26:06 -0700 (PDT)
Received: by 10.223.144.203 with HTTP; Mon, 18 Jul 2011 08:25:46 -0700 (PDT)
In-Reply-To: <4E244C75.6060407@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177376>

On Mon, Jul 18, 2011 at 11:08 AM, Johannes Sixt <j.sixt@viscovery.net> =
wrote:
> Am 7/18/2011 16:18, schrieb Patrick Doyle:
>> $ git push
> ...
>> To somehost:path/to/repo
>> =A0 =A0e1004df..bad8767 =A0wpd -> wpd
>> =A0! [rejected] =A0 =A0 =A0 =A0master -> master (non-fast-forward)
>
> [Context: Patrick works on the topic branch, but can't push it anymor=
e
> because the unrelated branch master was moved forward by someone else=
=2E]
>
> After the obligatory 'git fetch', there are at least two ways to do t=
his:
>
> (1) The quick and unsafe way:
>
> =A0 =A0$ git branch -f master origin/master
>
> (2) The safer way:
>
> =A0 =A0$ git push . origin/master:master
>
> The second command is safer because it checks that origin/master is i=
ndeed
> a direct descendent of master.

I like it!  (#2) It's obscure as all get-out, as UNIX commands were
intended to be, does the job you need it to do in a manner that is
intuitive, provided you understand what it's doing, and if you miss
the dot (perhaps, hypothetically speaking of course, because you
thought it was a dust spec on your screen when you tried out the
command), you get a very obscure error message (errr, hypothetically
speaking of course).

Seriously... Thanks for the quick answers.  I'll tuck #2 into my bag
o' tricks.  In the mean time, I need to decide whether I really care
about my master branch or not.  I do care about origin/master, but I
do all my work on wpd and merge in changes from origin/master at
random points in time.

Thanks again.

--wpd
