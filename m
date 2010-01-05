From: "H.J. Lu" <hjl.tools@gmail.com>
Subject: Re: How to exclude files from "git diff"
Date: Tue, 5 Jan 2010 10:15:19 -0800
Message-ID: <6dc9ffc81001051015x3bebc994r3d475bdb59e12d39@mail.gmail.com>
References: <6dc9ffc80912180909q2e9cbe30r7c802a2152c5954@mail.gmail.com>
	 <20100105064509.GC19025@coredump.intra.peff.net>
	 <6dc9ffc81001050620q55c23072p93f58c8685d77f9d@mail.gmail.com>
	 <37fcd2781001050954y778ba661n7cee6cda699968c2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 05 19:15:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NSDwF-0004r3-Ir
	for gcvg-git-2@lo.gmane.org; Tue, 05 Jan 2010 19:15:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754840Ab0AESPW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jan 2010 13:15:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754836Ab0AESPW
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jan 2010 13:15:22 -0500
Received: from mail-ew0-f219.google.com ([209.85.219.219]:51515 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754818Ab0AESPV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jan 2010 13:15:21 -0500
Received: by ewy19 with SMTP id 19so8731131ewy.21
        for <git@vger.kernel.org>; Tue, 05 Jan 2010 10:15:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=cWu1eoNmB9nmvbv9x68G65nqdQcLCpB1Zoc4l/rZBkQ=;
        b=hccXZgUuw7Rw50GN7QTT4o1jTOv4Lyvlq3zFp0ZjUgYhfQ9hzDwkWZmLpOaQeD9zEA
         x6FMETnAALoqY3BtgkJwlFhYIlhEIu1/xxdwp0svrafwIlXsGjpVcDvG7KIGrnAyFXCq
         yaj0ZbyUUd1a3sLYLf+AFPEsC/5Tts3lfVyts=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=frYT4yhjBuFzjwZ9c21g1UaeGyikOhCO34sB5r2USIpYDrWLFBJeH2u2NO31zxU40A
         XfBaTC8Sz2aBWoFJEMTHP9hb0tHxQ1vNI6k9zNg3hG5GBLTuvZ++1GRWbGRLekBQCFw7
         +0y52vcTPNFhUTR4DVnFuOiQW3p1AEBg48I9g=
Received: by 10.216.86.3 with SMTP id v3mr2185754wee.165.1262715319776; Tue, 
	05 Jan 2010 10:15:19 -0800 (PST)
In-Reply-To: <37fcd2781001050954y778ba661n7cee6cda699968c2@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136197>

On Tue, Jan 5, 2010 at 9:54 AM, Dmitry Potapov <dpotapov@gmail.com> wrote:
> On Tue, Jan 5, 2010 at 5:20 PM, H.J. Lu <hjl.tools@gmail.com> wrote:
>>
>> Yes, I want those files in repository. They are for my personal use only.
>
> If you modified some file locally and do not want to see and commit
> those modifications, you may want to use:
>
> git update-index --assume-unchanged foo
>

I added those files into my repository for bookkeeping purpose. It
shouldn't go out at all.


-- 
H.J.
