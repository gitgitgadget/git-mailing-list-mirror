From: Allan Caffee <allan.caffee@gmail.com>
Subject: Re: Unusual behavior from git describe
Date: Sat, 30 Jul 2011 09:29:58 -0400
Message-ID: <CA+jCPNfwwhM8R-bB_VnwpaijSMf3BNydH35SqZt3dRb-P1AOmg@mail.gmail.com>
References: <CA+jCPNcOe_dd6fsHDvWtoXEQE+xyd=aaSbfjpjQ8UfyFnvXTfg@mail.gmail.com>
	<CAGdFq_hYiBoqNmNtBKBqNN4XLLKwxDMHJfAUwdHB_iCcya=DOQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 30 15:30:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qn9cJ-0000IF-39
	for gcvg-git-2@lo.gmane.org; Sat, 30 Jul 2011 15:30:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751433Ab1G3NaA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Jul 2011 09:30:00 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:58513 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751142Ab1G3N37 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jul 2011 09:29:59 -0400
Received: by vws1 with SMTP id 1so3545532vws.19
        for <git@vger.kernel.org>; Sat, 30 Jul 2011 06:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=q7I6D/C4uX02ak+k3dNmMsf+gBpxWuIosdy80Udtre0=;
        b=aaemP0+D1sh8F9y02F7iIMlpF8VgJZUlVL16K3EdCrIOr/2zDPwuWODB4kZCYBhQC5
         OjT/jxDH7RQAZJq2moeykt0dldD2De9vWuxYBBTu4ycUqI4pTsqnG3X6yLoS6hLaIloX
         C1nV+IXFkApzN1ZRO1bgv2BxmtV9WhboHxlnc=
Received: by 10.52.173.169 with SMTP id bl9mr2418088vdc.281.1312032598326;
 Sat, 30 Jul 2011 06:29:58 -0700 (PDT)
Received: by 10.52.155.74 with HTTP; Sat, 30 Jul 2011 06:29:58 -0700 (PDT)
In-Reply-To: <CAGdFq_hYiBoqNmNtBKBqNN4XLLKwxDMHJfAUwdHB_iCcya=DOQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178193>

Hey,

On Fri, Jul 29, 2011 at 5:55 PM, Sverre Rabbelier <srabbelier@gmail.com> wrote:
> Heya,
>
> On Fri, Jul 29, 2011 at 23:46, Allan Caffee <allan.caffee@gmail.com> wrote:
>> % git describe --tags --dirty
>> v0.0.3-dirty
>>
>> % git status
>> # On branch master
>> nothing to commit (working directory clean)
>>
>> % git describe --tags --dirty
>> v0.0.3
>
> Perhaps git describe does not update the index (properly?), which 'git
> status' then does, correcting it?

I suppose that makes sense.  But what about building a package, which
doesn't change any tracked files or add any (non-ignored) untracked
files, would cause the index to appear dirty in the first place?

--
Allan
