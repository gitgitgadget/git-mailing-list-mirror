From: David Aguilar <davvid@gmail.com>
Subject: Re: CRLF, LF ... CR ?
Date: Wed, 26 Sep 2012 01:42:02 -0700
Message-ID: <CAJDDKr7Y5iXVxDHPJ+HQ86T43YBccnsEsebFje9pZzEBgh3=9A@mail.gmail.com>
References: <20120913170943725232.01d717ef@gpio.dk>
	<CAJDDKr5-ze2bhTkT+jzcS1iZipJO6kEr2qAf73GRn4QQ-rS1dQ@mail.gmail.com>
	<7vtxv18ax2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jens Bauer <jens-lists@gpio.dk>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 26 10:42:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TGnCD-0006OG-NS
	for gcvg-git-2@plane.gmane.org; Wed, 26 Sep 2012 10:42:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753611Ab2IZImH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Sep 2012 04:42:07 -0400
Received: from mail-vb0-f46.google.com ([209.85.212.46]:61270 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752910Ab2IZImE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Sep 2012 04:42:04 -0400
Received: by vbbff1 with SMTP id ff1so333072vbb.19
        for <git@vger.kernel.org>; Wed, 26 Sep 2012 01:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=MkWbxodTfcyKdwsoWmllhw7g/WU0OTXY8XpW09fr6dA=;
        b=CnipKp7LFFSvF6e7YFWKPlxWkm58GwYqY3BRA7942Sto+4JyisZ6xk0qFeYhrXVdyk
         23dTn/5jbFYDFRe3Owbmpw1fE4KT9mlVJJOCHuvLsntRL2J/d7bw+82joSlWDIBZ6YPc
         KeOo2EQEtP15YgNS4ViaFQQOTzQVd97wnfM5enqLlPpgn33sGQERRiBxiooTNSdAgKLd
         ygBX7ZJYwYQWiAxP8fbu0soSemqZ2MYgy7ZnHKR5q+mfWpi+dAvKn4jmZDJ+9xBXEF7l
         8AjVA31dVBraPC7iMK42BBIvUSMnnuVsjop0cfP04i9QJQrhPivdmJMiAdBfZGgqMYls
         BVNQ==
Received: by 10.58.69.38 with SMTP id b6mr10970209veu.30.1348648923051; Wed,
 26 Sep 2012 01:42:03 -0700 (PDT)
Received: by 10.58.180.39 with HTTP; Wed, 26 Sep 2012 01:42:02 -0700 (PDT)
In-Reply-To: <7vtxv18ax2.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206399>

On Thu, Sep 13, 2012 at 9:51 PM, Junio C Hamano <gitster@pobox.com> wrote:
> David Aguilar <davvid@gmail.com> writes:
>
>> git doesn't really even support LF.
>
> At the storage level that is correct, but the above is a bit of
> stretch.  It may not be "support", but git _does_ rely on LF when
> running many text oriented operations (a rough rule of thumb is
> "does 'a line' in a file matter to the operation?").  Think about
> "git diff" and "git blame".

Thanks for the thorough explanation.  You're 100% correct, as always.

I'll be honest: I had a small bias when responding.
I didn't want anyone to think a "autocr" feature would be useful,
so I played the "git is really simple" angle hoping it would
put a kabosh on the idea.  That was a little silly of me.

That said, perhaps the "autocrlf" code is simple enough that it
could be easily tweaked to also handle this special case, but
I am not familiar with the code enough to say.  My gut feeling
was that it was too narrow a use case.  I guess if someone[*]
wanted to whip up a patch then it would be a different story,
but it doesn't seem to be the itch of anyone around here so far.

[*] Jens, that could be you ;-)

cheers,
-- 
David
