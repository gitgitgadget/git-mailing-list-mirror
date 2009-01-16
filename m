From: Ping Yin <pkufranky@gmail.com>
Subject: Re: How to exclude some files when using git-archive?
Date: Fri, 16 Jan 2009 13:26:46 +0800
Message-ID: <46dff0320901152126u2bb9ff55qce9a22c69276bc6a@mail.gmail.com>
References: <46dff0320901151840l18257501x62a3fa1fe9701dc@mail.gmail.com>
	 <7v4p00otpb.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 16 06:29:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNhGk-0001Dy-Ke
	for gcvg-git-2@gmane.org; Fri, 16 Jan 2009 06:29:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751180AbZAPF0t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Jan 2009 00:26:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751299AbZAPF0s
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Jan 2009 00:26:48 -0500
Received: from rv-out-0506.google.com ([209.85.198.237]:49582 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750921AbZAPF0r (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Jan 2009 00:26:47 -0500
Received: by rv-out-0506.google.com with SMTP id k40so1416715rvb.1
        for <git@vger.kernel.org>; Thu, 15 Jan 2009 21:26:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=HrjdhJGaUiliZjMqM0SVXX77CW6lE3r1br65hiY9e4A=;
        b=DDKrHA2uDOmUlGsCpebskihAgKks6sLyr2Zkl1I/vMEdLVeST4a7Wge/6hfNcc1Fqt
         0aD8Bp1xPMITfhxewaxvNUtyATxslQaQf6dj7jzJ8powR/7bn+tF9AWMNotuc/ShqH3y
         cSfbyba0NHaqSHBIN38Nl6YuFO1mLXLNUneZM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=YwohJMxpL8JPTBHVTm7rG/sOJ0CEB9RQS75Oh8TK4KgSWZOqqY3SPC+oEdYyY6yRPc
         DSJQYRt3tQq+PgWBuymg0hSK5QnsVL60XCxUy9hmapq0LUQEGj+xtzbZWV5fdGk23TaE
         +JA522eUn/L5TWzQr7HLQkfwNLlNx27WhqlMs=
Received: by 10.115.89.18 with SMTP id r18mr1474955wal.111.1232083606564; Thu, 
	15 Jan 2009 21:26:46 -0800 (PST)
In-Reply-To: <7v4p00otpb.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105923>

On Fri, Jan 16, 2009 at 10:44 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Ping Yin <pkufranky@gmail.com> writes:
>
>> I want to exclude .gitignore from the archive, but hasn't find a easy way
>>
>> Ping Yin
>
> "man gitattributes", then look for export-ignore?
>
>

Thanks. That's exactly what i want.

One question: It seems the .gitattributes doesn't take effect when
using following command

GIT_DIR=A/.git git archive HEAD > A.tar

where the files with attribute export-ignore are still exported.

Instead, i have to run

cd A && git archive HEAD > A.tar

Ping Yin
