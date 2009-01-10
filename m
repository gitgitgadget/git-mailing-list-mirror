From: "Nathan W. Panike" <nathan.panike@gmail.com>
Subject: Re: [PATCH] format-patch: avoid generation of empty patches
Date: Sat, 10 Jan 2009 12:07:06 -0600
Message-ID: <d77df1110901101007o1d17142aub6971b72ba55c89e@mail.gmail.com>
References: <1231536787-20685-1-git-send-email-nathan.panike@gmail.com>
	 <7vmye0yohu.fsf@gitster.siamese.dyndns.org>
	 <20090110113642.GA25723@myhost> <20090110113903.GB25723@myhost>
	 <d77df1110901100801s463bb43bt701a95df14f167d8@mail.gmail.com>
	 <20090110161722.GA18859@myhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Alexander Potashev" <aspotashev@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 10 19:08:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LLiGA-0004vv-Jt
	for gcvg-git-2@gmane.org; Sat, 10 Jan 2009 19:08:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752803AbZAJSHK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Jan 2009 13:07:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752680AbZAJSHJ
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Jan 2009 13:07:09 -0500
Received: from rn-out-0910.google.com ([64.233.170.189]:36951 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752235AbZAJSHH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Jan 2009 13:07:07 -0500
Received: by rn-out-0910.google.com with SMTP id j67so8589950rne.21
        for <git@vger.kernel.org>; Sat, 10 Jan 2009 10:07:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=8NOt+TzDEoYoIOWY2tOap6bLvU6XHmCdhmfOosva0Q4=;
        b=T76EbJbS2UCDKp+ttcWePgxjCwqes1SmSagOze7t7dMpba73gYFm828wfqMHbL5v00
         EHLjBHY8Jck6fgoY9rLuQ5Vxf+AqdTygrfY9JaH3MX66NmWqM3mjtCpcD/fZ6HB98wn9
         1kckSVf7ADHhnEKEiuDqrpFZUpp41D1Ckph/8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=PVjwvwmIgM6ttrY+BNN8C9uxuXKvWZeANmd8tXglFD0yVga4+tcWEAam0AH8F4hmYB
         lNlAhtwBuHSKHpoU3HlAjF1DPIUn0HGcm7jpbKMhaNRkK2dTbSv14LxvdW+yua+Oppf/
         6AB62WnfU/XCBkRliJZX+qhZTc1z3blwzKlQA=
Received: by 10.90.53.5 with SMTP id b5mr12789696aga.15.1231610826252;
        Sat, 10 Jan 2009 10:07:06 -0800 (PST)
Received: by 10.90.114.9 with HTTP; Sat, 10 Jan 2009 10:07:06 -0800 (PST)
In-Reply-To: <20090110161722.GA18859@myhost>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105136>

Hi:

On Sat, Jan 10, 2009 at 10:17 AM, Alexander Potashev
<aspotashev@gmail.com> wrote:

...

> AFAIU get_revision stops revision iteration when it appears to stay at
> the root commit. So, if we will replace 'break' with 'continue', the
> 'while' loop will finish right after that 'continue'.

> However, I might be wrong... please, correct me then.

I was thinking of the case where there is more than one root.  Maybe
the code does the right thing then, but I confess I have not looked at
it deeply enough to know.

Nathan Panike
