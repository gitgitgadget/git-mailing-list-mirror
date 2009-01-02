From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: git-difftool
Date: Fri, 2 Jan 2009 09:59:37 +0800
Message-ID: <46dff0320901011759ke7026d9hafe4fdde099e370b@mail.gmail.com>
References: <20081226013021.GA15414@gmail.com> <vpqhc4kz5zh.fsf@bauges.imag.fr>
	 <46dff0320812312338i5a3ee0cem702a6b67ef76e48c@mail.gmail.com>
	 <200901020104.01522.markus.heidelberg@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Matthieu Moy" <Matthieu.Moy@imag.fr>,
	"David Aguilar" <davvid@gmail.com>, git@vger.kernel.org
To: markus.heidelberg@web.de
X-From: git-owner@vger.kernel.org Fri Jan 02 03:02:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LIZMh-0007uN-14
	for gcvg-git-2@gmane.org; Fri, 02 Jan 2009 03:02:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755462AbZABB7k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Jan 2009 20:59:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755411AbZABB7k
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Jan 2009 20:59:40 -0500
Received: from wa-out-1112.google.com ([209.85.146.179]:39085 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754460AbZABB7j (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Jan 2009 20:59:39 -0500
Received: by wa-out-1112.google.com with SMTP id v27so3117660wah.21
        for <git@vger.kernel.org>; Thu, 01 Jan 2009 17:59:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=Ti6u0tYMNOCShFTW1ErRVxDbczRHDe8H65Ld9S2zuYI=;
        b=dLhYuNg7wgJpYKZOpIjAvZSzuJGgLS179O26z+kgv2oYB/zsKu6XMT/Kt12LgGiUUW
         T6pKBR9YKoeoLATfHNglN/efQITCCA2iEDIzC3psa0FV/cu/i1jiVv1uZGfK68pRGalG
         04QvGNZdQpNBX/BePwW1LNDQuCUY5UiW99wgk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=oBEQ3GXuvIO8ieTWkZNGKiWOrQKTodielQKVPm5oUlAiDmNSc89OpLyvaz3v7QwbjD
         l6uhBndAmIsFLqaktHuEGE/H6cszPtk8ACxhbVi8srVZFa7STtZamKaHmk43oX3cNiJN
         1+uqrmTUSpXC7XRngyqFEONYI3goVLV7WxIjY=
Received: by 10.114.122.5 with SMTP id u5mr11490233wac.88.1230861577890;
        Thu, 01 Jan 2009 17:59:37 -0800 (PST)
Received: by 10.115.93.12 with HTTP; Thu, 1 Jan 2009 17:59:37 -0800 (PST)
In-Reply-To: <200901020104.01522.markus.heidelberg@web.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104355>

On Fri, Jan 2, 2009 at 8:04 AM, Markus Heidelberg
<markus.heidelberg@web.de> wrote:
> Ping Yin, 01.01.2009:
>> On Thu, Jan 1, 2009 at 12:04 AM, Matthieu Moy <Matthieu.Moy@imag.fr> wrote:
>> > David Aguilar <davvid@gmail.com> writes:
>> >
>> >> The usual use case for this script is when you have either
>> >> staged or unstaged changes and you'd like to see the changes
>> >> in a side-by-side diff viewer (e.g. xxdiff, tkdiff, etc).
>> >>
>> >>       git difftool [<filename>*]
>> >
>> > Is it not a complex way of saying
>> >
>> >        GIT_EXTERNAL_DIFF=xxdiff git diff
>>
>> $ cat mydiff
>> #!/bin/bash
>> exec vimdiff $2 $5
>>
>> then i run
>>
>> $ GIT_EXTERNAL_DIFF=mydiff  git diff
>>
>> but it gives me the error
>> Vim: Warning: Output is not to a terminal
>
> Just the warning and everything else works? For me the display is
> totally screwed up and the commands don't really work because of the
> pager. I have to add GIT_PAGER="" to get it working.
>

Thanks. With GIT_PAGER="" it works now.
