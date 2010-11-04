From: Christian Couder <christian.couder@gmail.com>
Subject: Re: cherry-pick fail when a symbolic link has been changed into a
 file or directory
Date: Thu, 4 Nov 2010 18:03:39 +0100
Message-ID: <AANLkTi=cydcB2yRpWbSH7qZGHdjXEPjNvfBCJny7JcwJ@mail.gmail.com>
References: <20101104125641.2ef90853@cortex>
	<AANLkTimq8SP-gxZQiXW3Pxg3-1Z98zyPAoNA8JDn0=6A@mail.gmail.com>
	<20101104151637.076ac021@cortex>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>, Elijah Newren <newren@gmail.com>,
	Nick <oinksocket@letterboxes.org>
To: Camille Moncelier <moncelier@devlife.org>
X-From: git-owner@vger.kernel.org Thu Nov 04 18:03:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PE3E6-0002MO-KU
	for gcvg-git-2@lo.gmane.org; Thu, 04 Nov 2010 18:03:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751984Ab0KDRDo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Nov 2010 13:03:44 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:42747 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752092Ab0KDRDl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Nov 2010 13:03:41 -0400
Received: by gxk23 with SMTP id 23so1583774gxk.19
        for <git@vger.kernel.org>; Thu, 04 Nov 2010 10:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=my3GSv7DoV6FvJoekzLTB/F0kQ7GlHkVuYxKSyVOGGo=;
        b=RBz/f6lCDe5kVJKWXJl0d6z4Ybe699C+48WpomYJokxFXEPX7/zhfHwlyOEhy5LrPC
         o0Yc+aDNsrE6ZjYMCH4XNPQqT5jsnK/xqSbNztemrOrNp6v3Ujmdsc5xuJxilTjhSsaA
         /SYy8ka1ApG9mj3Bh7qdYCMle8KORSMyluxYY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=xKn+0Hgiz7xYE8L0MbPJxkgSyyz0cPbokipxEKQM7smxLfju+4zsJ8dtasTl05pIvf
         dThlBbBs3J0JM6TmMw+4/ZQ7OelLk4xl0v+fHcPsFrpuuLSlIUKjXWIKZMZAMa9ttjJ9
         8ovi6q3yfxe2/UScRO1ETThCd5AntMOsHENh0=
Received: by 10.216.26.138 with SMTP id c10mr98883wea.23.1288890219927; Thu,
 04 Nov 2010 10:03:39 -0700 (PDT)
Received: by 10.216.26.208 with HTTP; Thu, 4 Nov 2010 10:03:39 -0700 (PDT)
In-Reply-To: <20101104151637.076ac021@cortex>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160731>

On Thu, Nov 4, 2010 at 3:16 PM, Camille Moncelier <moncelier@devlife.or=
g> wrote:
> On Thu, 4 Nov 2010 14:55:12 +0100
> Christian Couder <christian.couder@gmail.com> wrote:
>
>> Could you try to cherry-pick with other strategies?
>> For example with:
>>
>> git cherry-pick --strategy resolve test1
>
> ~/repo1$ git --version
> git version 1.7.3.1
>
> ~/repo1$ git cherry-pick --strategy resolve test1
> Trying simple merge.
> Simple merge failed, trying Automatic merge.
> [master da2d5bf] New file in test1
> =A01 files changed, 1 insertions(+),
> =A0create mode 100644 new_file_test1
>
> Seems it is working using the resolve strategy. I may have found a
> message on this list posted a while ago:
>
> "cherry-picking a commit clobbers a file which is a directory in the
> target commit"
>
> Which seems to deal with the same kind of problems maybe something is
> missing in the patch in order to handle this particular case.

Please reply not only to me but also to the list and add relevant
people in Cc: like I did.

Elijah Newren sent a patch series around September the 20th but I did
not check to see if this series was merged into pu, next or master.
And I don't know if it fixes your problem.
Could you have a look?

Thanks,
Christian.
