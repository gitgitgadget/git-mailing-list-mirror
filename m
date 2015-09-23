From: Luke Diamand <luke@diamand.org>
Subject: Re: git-p4: t9819 failing
Date: Wed, 23 Sep 2015 12:11:05 +0100
Message-ID: <CAE5ih78x+jnW3+4d5q5dJidt4LXWV=hMgJTEfsC2dUBLout1Aw@mail.gmail.com>
References: <CAE5ih79t+62XUKsj9cnkJCCv4WPhUgQZQ6hF39Nx0ky+WFi-sw@mail.gmail.com>
	<954B65C2-1CF8-4F63-B2DE-F15200553046@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Users <git@vger.kernel.org>
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 23 13:11:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZehxA-0002dB-Vk
	for gcvg-git-2@plane.gmane.org; Wed, 23 Sep 2015 13:11:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753494AbbIWLLI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Sep 2015 07:11:08 -0400
Received: from mail-ob0-f169.google.com ([209.85.214.169]:35125 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752638AbbIWLLH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Sep 2015 07:11:07 -0400
Received: by obbzf10 with SMTP id zf10so30038584obb.2
        for <git@vger.kernel.org>; Wed, 23 Sep 2015 04:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=EOi55XQB/y5DRpMKcn3RI9QVGXTlj831hkzlpet3TQE=;
        b=MVIGMXXTK0w3nxsDa/FgbHkrzdPJHu9EuJ0b+EoKv8zpe9UQexBj5h018cE9kP9/5z
         5+6mKEh9bGfZr1NnflVMFIzwNYazhix5mlblkRwzXpyI85gd6ElG4yriRNB8oZP8EwJM
         nIYLTm4MuO39YDLTAcyZYsbSaA5Q6qxCWcaKo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=EOi55XQB/y5DRpMKcn3RI9QVGXTlj831hkzlpet3TQE=;
        b=OBJ74jL6Nx/NwP6bJk13dXNKXDCFFzktp79VWkMsbDV8C0ucVHUMSxP+WpCtHrPRFY
         Xe4dOhVcODWsJWt0Rq4HVfQVyyqQm8w4h6fypBv5DNNdKyLFjtKNPzDABUUuO5a+/4EJ
         ugsil4o3IqR8uqrcrcrVNtYVrK3kx3OK/h+ihYK8WGqGdt9lA0o8UU7Mv/cU7HnLK4LC
         D7Io7oHQiq4uSTzWG7R1SG5CFzCO88PlKnV0NS0iuleYacv9icrXXE7ZKLY/QCVqoDV1
         6D4VDqRjpxuVzLI7f9Z2kjhf6+o5ujbZo7hqxo77Wn7/EWt5b6a/Ex6SICEj3VWiPCx3
         OegQ==
X-Gm-Message-State: ALoCoQmkbvmLiQUqu04i+FBw+qogiSSE36/BitM/UmFgp0VQLvupl5yu2j9QCKBt8s4Ga3OOn+fB
X-Received: by 10.60.67.105 with SMTP id m9mr19421266oet.68.1443006665894;
 Wed, 23 Sep 2015 04:11:05 -0700 (PDT)
Received: by 10.60.46.38 with HTTP; Wed, 23 Sep 2015 04:11:05 -0700 (PDT)
In-Reply-To: <954B65C2-1CF8-4F63-B2DE-F15200553046@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278482>

On 23 September 2015 at 11:27, Lars Schneider <larsxschneider@gmail.com> wrote:
>
> On 23 Sep 2015, at 11:27, Luke Diamand <luke@diamand.org> wrote:
>
>> Lars,
>>
>> I just noticed that your change "git-p4: honor core.ignorecase when
>> using P4 client specs" seems to break t9819.
>>
>> I suspect that the problem is just that t9819 needs to be updated to
>> reflect your change - do you have any thoughts on that?
>>
>> Thanks!
>> Luke
>
> What OS and what commit do you use for testing? Here is what I got on my machine:
>
> Ubuntu, next (c07a1e8) -> OK
> Ubuntu, maint (ee6ad5f) -> OK
>
> OS X, next (c07a1e8) -> broken
> OS X, maint (ee6ad5f) -> broken

The next branch is good:
c07a1e8 Merge branch 'bb/remote-get-url' into next

The pu branch isn't:
f44e3df Merge branch 'jk/notes-dwim-doc' into pu

This is on Debian.

Actually I think the problem may be in calcDiskFree().

Here's the last bit of the crash dump from git-p4 I get:

  File "/home/ldiamand/git/git/git-p4", line 2580, in streamP4FilesCbSelf
    self.streamP4FilesCb(entry)
  File "/home/ldiamand/git/git/git-p4", line 2497, in streamP4FilesCb
    required_bytes = int((4 * int(self.stream_file["fileSize"])) -
calcDiskFree(self.cloneDestination))
  File "/home/ldiamand/git/git/git-p4", line 116, in calcDiskFree
    st = os.statvfs(dirname)
OSError: [Errno 2] No such file or directory: 'lc'

Luke
