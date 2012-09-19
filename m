From: Dave Borowitz <dborowitz@google.com>
Subject: Re: [PATCH] Documentation/Makefile: Allow custom XMLTO binary
Date: Wed, 19 Sep 2012 13:49:19 -0700
Message-ID: <CAD0k6qTMm7MKLYOOMaB72cWc=Z8nJfe8qseWfyM6x_NzCorgZg@mail.gmail.com>
References: <1348074397-29978-1-git-send-email-dborowitz@google.com> <7vehlxhp0v.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 19 22:49:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TERDT-0004y1-Ea
	for gcvg-git-2@plane.gmane.org; Wed, 19 Sep 2012 22:49:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751843Ab2ISUtn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Sep 2012 16:49:43 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:47297 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751697Ab2ISUtl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Sep 2012 16:49:41 -0400
Received: by ieak13 with SMTP id k13so2239483iea.19
        for <git@vger.kernel.org>; Wed, 19 Sep 2012 13:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:x-system-of-record;
        bh=uGBJITEmVSpLNRHqkgwh6MCvxnmNmI6jahCLJy0ZM6Y=;
        b=TeGVGKAadN3NpFyaaYlFWLkWoeQfKt80+jNBm5JdB4sM8oNWvcd426shRQVgEab8QV
         WmOO+/zTjKEC2qK12WDSBeg+UhoeCFsb7QcZUpwdoG7SGAubSnkSdCzuoMKTmi/MrwUp
         J9t9fACyLgENUNjcHCwz1xaCgVVffSFr4aAtu4gw7ESLntieQ1k9cKz7iK9A3XVPgs1P
         Z5Z5XhPbWNMn4isOTL8J2piwSRUrKhnXbelR1ewXJSQKt4LXKQSVAab4kwSswCMGKKTW
         8+tW1rNE4BOcH1Ars1qdJdxPJZwf+Vd0gNMt3NeQ0+OdNOflFPDc173DVEpeOeamwh2e
         VICQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:x-system-of-record:x-gm-message-state;
        bh=uGBJITEmVSpLNRHqkgwh6MCvxnmNmI6jahCLJy0ZM6Y=;
        b=k3xptDw3y5ebwOzTHCRyQn2Di4K4QvYLYmGND+qmyYSQ+5607PAWCC1+LAhfkFwfGY
         HRoLhVOZeR4fCl9p4abOkoWuO++dZ3bUcXz5u0EXPB5px6e7AFMfRUZjplnBqg3j86tF
         vczNS1ByPK9he/qwnUTeMXuwmTZRbjtG5GplV4KQ7lt7NHK4JRnF3faMbOFNH2uzs/hl
         JW1R7pB/zqqoGs9Wkq25OsHDOpd6teaK797XTzgTnwabIo8laPW2NEGTiPGbnlUflS8Z
         uci0Hky6a7SxoJaDv9YnO8MqGOVrN9WbVZOyzm6P5XFxOl4LIKlCbVGGYawBSVrv87MP
         OdxQ==
Received: by 10.50.168.66 with SMTP id zu2mr97549igb.34.1348087781344;
        Wed, 19 Sep 2012 13:49:41 -0700 (PDT)
Received: by 10.50.168.66 with SMTP id zu2mr97539igb.34.1348087781101; Wed, 19
 Sep 2012 13:49:41 -0700 (PDT)
Received: by 10.231.135.1 with HTTP; Wed, 19 Sep 2012 13:49:19 -0700 (PDT)
In-Reply-To: <7vehlxhp0v.fsf@alter.siamese.dyndns.org>
X-System-Of-Record: true
X-Gm-Message-State: ALoCoQnq3zfgYu2PX0uqmHaj/KrRl+Vt1MkuODLyG+ntm4YQvBf3H7LhAL9Co603ue0Ge0+dhGItF4INfhkLeRu7XHk5FxJSn/ZIsOb7yhU+s3ddYG7SJobvz4BFh9VrthWhQX8aWNOY3pNTpz8aqtbY3Nv4az5tOVmMMIs7W23HgLa3yfw27qA+QpsHtSPMwsXs0R/YZcxZ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206000>

On Wed, Sep 19, 2012 at 10:59 AM, Junio C Hamano <gitster@pobox.com> wrote:
> dborowitz@google.com writes:
>
>> From: Dave Borowitz <dborowitz@google.com>
>>
>> Signed-off-by: Dave Borowitz <dborowitz@google.com>
>> ---
>
> Thanks; the patch sort-of makes sense but makes me wonder what your
> use case is.  Do you have xmlto2 program you want to use in place of
> xmlto or you have xmlto but not on your $PATH?

The latter; I can easily symlink it into my $PATH of course. But since
I was already specifying ASCIIDOC on the make command line for the
same reason, I was surprised to find I couldn't also specify XMLTO,
hence the patch.

>>  Documentation/Makefile | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/Makefile b/Documentation/Makefile
>> index cf5916f..b045628 100644
>> --- a/Documentation/Makefile
>> +++ b/Documentation/Makefile
>> @@ -47,6 +47,7 @@ man7dir=$(mandir)/man7
>>  ASCIIDOC=asciidoc
>>  ASCIIDOC_EXTRA =
>>  MANPAGE_XSL = manpage-normal.xsl
>> +XMLTO=xmlto
>>  XMLTO_EXTRA =
>>  INSTALL?=install
>>  RM ?= rm -f
>> @@ -245,7 +246,7 @@ manpage-base-url.xsl: manpage-base-url.xsl.in
>>
>>  %.1 %.5 %.7 : %.xml manpage-base-url.xsl
>>       $(QUIET_XMLTO)$(RM) $@ && \
>> -     xmlto -m $(MANPAGE_XSL) $(XMLTO_EXTRA) man $<
>> +     $(XMLTO) -m $(MANPAGE_XSL) $(XMLTO_EXTRA) man $<
>>
>>  %.xml : %.txt
>>       $(QUIET_ASCIIDOC)$(RM) $@+ $@ && \
