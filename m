From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] bash-completion: don't add quoted space for ZSH (fix regression)
Date: Tue, 17 Jan 2012 22:03:08 +0200
Message-ID: <CAMP44s0T15idhwb6Eae5vdMxf25KK9MhY57mBf+BFN=OSC6Lhg@mail.gmail.com>
References: <20120114152030.GX30469@goldbirke>
	<1326567336-2173-1-git-send-email-Matthieu.Moy@imag.fr>
	<CAMP44s2nYMmfC36+pGaYfOZUQy3fLMYDuaSriPYjHBeApmsRVg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, gitster@pobox.com
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Tue Jan 17 21:03:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RnFFT-0005mv-VR
	for gcvg-git-2@lo.gmane.org; Tue, 17 Jan 2012 21:03:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755672Ab2AQUDK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jan 2012 15:03:10 -0500
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:50426 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755662Ab2AQUDJ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Jan 2012 15:03:09 -0500
Received: by lahc1 with SMTP id c1so1770202lah.19
        for <git@vger.kernel.org>; Tue, 17 Jan 2012 12:03:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=O1x6mKiIDVak3XvyQEJVzmxDSSUk0ENv4PQOoL/PkZA=;
        b=u7D1efBl93MnZY4P5l8YOmsWUm0FLRVoSZCOVMraliGhkkeGVk8mLIQkccmTk1X7qm
         S/etuOcxkDGEPHtoNwqtQJqHpD7E8QmsxKH8SRrjncxpmOeRVuoDaa86clwRolxmMFm2
         4FtTYcSuuLxzvMLjQI+XTb0eQ2iBxWRtHoM6Y=
Received: by 10.152.103.169 with SMTP id fx9mr4343790lab.10.1326830588145;
 Tue, 17 Jan 2012 12:03:08 -0800 (PST)
Received: by 10.112.86.7 with HTTP; Tue, 17 Jan 2012 12:03:08 -0800 (PST)
In-Reply-To: <CAMP44s2nYMmfC36+pGaYfOZUQy3fLMYDuaSriPYjHBeApmsRVg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188716>

On Tue, Jan 17, 2012 at 9:18 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> On Sat, Jan 14, 2012 at 8:55 PM, Matthieu Moy <Matthieu.Moy@imag.fr> wrote:
>> Commit a31e626 (completion: optimize refs completion) introduced a
>> regression for ZSH users: ref names were completed with a quoted trailing
>> space (i.e. "git checkout ma" completes to "git checkout master\ "). The
>> space is convenient for bash users since we use "-o nospace", but a
>> quoted space is worse than nothing. The absence of trailing space for ZSH
>> is a long-standing issue, that this patch is not fixing. We just fix the
>> regression by not appending a space when the shell is ZSH.
>
> I have this issue with the script from v1.7.8.3, and I think it
> started with a zsh update.

Yeah, works fine with zsh 4.3.11, not 4.3.14 or 15.

-- 
Felipe Contreras
