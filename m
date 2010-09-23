From: Ramana Kumar <ramana.kumar@gmail.com>
Subject: Re: get-upstream
Date: Thu, 23 Sep 2010 14:16:43 +1000
Message-ID: <AANLkTi=QnP0CUCU=6fR50UzphnVMVvmfe9mkqpf1NHLt@mail.gmail.com>
References: <AANLkTikqJmsUo53dRngXcWsoEfcFzLQ-J1V5oZOGUL03@mail.gmail.com>
 <AANLkTikQ8sHrp+sSZ8e8u7L+6=NHVY3cD9DwChAzLEk0@mail.gmail.com> <AANLkTikYnj_00Pdsm+QM1=kvqMpeKDCeOOqOS0XEwMXg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Pat Notz <patnotz@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 23 06:17:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OydFA-0006nO-Q3
	for gcvg-git-2@lo.gmane.org; Thu, 23 Sep 2010 06:17:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751835Ab0IWERH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Sep 2010 00:17:07 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:50280 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750709Ab0IWERF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Sep 2010 00:17:05 -0400
Received: by qyk36 with SMTP id 36so6268539qyk.19
        for <git@vger.kernel.org>; Wed, 22 Sep 2010 21:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=TKuzIMNxtkN+jN15WdTMWOZyAs8HxXzpxR1yXqhHDuo=;
        b=CRpZEXAmaECQyNOdk78rBAp31DR+yLGxBfoGLyZx1y1BfwSCDRr3HZHTlmZ6jCzdwE
         ZUZDD6RIFSn6r98xMEYiZnwGmTBMMEvJDVQ8Yn6HpGs9l8XETTtdwhOMcvqCdoLEUuAR
         iiFRQs/Vd1d4yBz/GcPELfhRDP9REhs/pYPyA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=iTZQLgkk2XIEwvmiJXw5zBfzR0PAAJGRUxk5ZTwELSfchZatw6Drf/0HrWhHvcsgwl
         lsdgISdX8PDZ0iV72ujDeC5tsjiqtdp3wu4AdaNLTFe5+11LW6Y+b8mslglr6VZxa5nm
         QJyoPzfq50qumxlhEVf+c2LDLsxG+ljERQdpk=
Received: by 10.220.30.139 with SMTP id u11mr564333vcc.77.1285215423412; Wed,
 22 Sep 2010 21:17:03 -0700 (PDT)
Received: by 10.220.181.65 with HTTP; Wed, 22 Sep 2010 21:16:43 -0700 (PDT)
In-Reply-To: <AANLkTikYnj_00Pdsm+QM1=kvqMpeKDCeOOqOS0XEwMXg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156847>

Thanks Pat - that's awesome.
Is there a git shortcut for removing the refs/remotes or refs/heads
prefix? (I know I can just use other progs for that too)

On Thu, Sep 23, 2010 at 2:15 PM, Pat Notz <patnotz@gmail.com> wrote:
> On Wed, Sep 22, 2010 at 10:05 PM, Pat Notz <patnotz@gmail.com> wrote:
>> $ git rev-parse --symbolic-full-name @{upstream}
>
> In all fairness, the @{upstream} syntax requires git >= 1.7.0
>
> http://www.kernel.org/pub/software/scm/git/docs/RelNotes-1.7.0.txt
>
