From: Phil Hord <phil.hord@gmail.com>
Subject: Re: [PATCH] git-difftool: allow skipping file by typing 'n' at prompt
Date: Tue, 4 Oct 2011 14:02:54 -0400
Message-ID: <CABURp0qmYWRJzHZZwZreKnj0ymFyM_AYXWXqwy=vTZspoPvvvg@mail.gmail.com>
References: <20111004105333.GA24331@atcmail.atc.tcs.com> <7vbotwdbjg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sitaram Chamarty <sitaram@atc.tcs.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 04 20:03:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RB9Kq-0006rh-TU
	for gcvg-git-2@lo.gmane.org; Tue, 04 Oct 2011 20:03:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933298Ab1JDSDQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 4 Oct 2011 14:03:16 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:57715 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754644Ab1JDSDP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Oct 2011 14:03:15 -0400
Received: by wwf22 with SMTP id 22so1213550wwf.1
        for <git@vger.kernel.org>; Tue, 04 Oct 2011 11:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=1CDP0FUEaOG4F1lh04hsN3OcBe/2HYEXhMputH3juPQ=;
        b=ZS4S5xELP4NZgdUSyovPzAGihe8FcaYi3pmQhKvDVKSVBSTekDjftP3QHPGkxqAn/X
         cGm79hIbHX0AsduO8mP1Lihp6mYa4goO5CZfkNiISOQweXz7l0YWSZR4S50JlmABfgY7
         lWR7yblpfrEJphXR9BiFSPhDeknO+tYLWrxWM=
Received: by 10.216.80.69 with SMTP id j47mr5402425wee.102.1317751394130; Tue,
 04 Oct 2011 11:03:14 -0700 (PDT)
Received: by 10.216.88.72 with HTTP; Tue, 4 Oct 2011 11:02:54 -0700 (PDT)
In-Reply-To: <7vbotwdbjg.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182784>

On Tue, Oct 4, 2011 at 11:25 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Sitaram Chamarty <sitaram@atc.tcs.com> writes:
>
>> Signed-off-by: Sitaram Chamarty <sitaram@atc.tcs.com>
>> ---
>>
>> I'm using what is pretty much a universal convention to
>> signify that the default choice is "y"; I hope documentation
>> for something so small is not needed but if it is, let me
>> know and I'll do that also.
>>
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printf "Hit return to laun=
ch '%s': " \
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printf "Launch '%s' [y]/n:=
 " \
>
> I think I've seen this done as: "do this? [Y/n]" elsewhere.
>
> Not telling you what to do, but trying to feel what others may think.

I think so, too.  The [y]/n syntax is not clear enough for me to
confidently know what the default value will be.

Phil
