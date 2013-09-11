From: John Szakmeister <john@szakmeister.net>
Subject: Re: [RFC] Disabling status hints in COMMIT_EDITMSG
Date: Wed, 11 Sep 2013 05:14:08 -0400
Message-ID: <CAEBDL5VVxMSPnfwBL4PiQAjAHDX1FkfaG3SOFZ1oqEh8d6S1YQ@mail.gmail.com>
References: <vpq4n9tghk5.fsf@anie.imag.fr>
	<xmqqeh8wzl0h.fsf@gitster.dls.corp.google.com>
	<vpq61u7akin.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Sep 11 11:14:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJgV5-0001Ds-0K
	for gcvg-git-2@plane.gmane.org; Wed, 11 Sep 2013 11:14:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753219Ab3IKJOL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Sep 2013 05:14:11 -0400
Received: from mail-wg0-f43.google.com ([74.125.82.43]:63611 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753095Ab3IKJOJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Sep 2013 05:14:09 -0400
Received: by mail-wg0-f43.google.com with SMTP id z12so7713312wgg.10
        for <git@vger.kernel.org>; Wed, 11 Sep 2013 02:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=jy3oNYgk0/ZJ8JR9p3PD9zLN2i5mIk79EDtbqyl4SwY=;
        b=cL3tcxAVxaOrI00jf8NdxggRfls24EBRElyOOUUl2zU2J5JnJ4pfKJ47ly87Y1znBH
         WzhX18hjbpPZ5qSh4fJlQA02FNBlXxc8aH1LG94IEAJ0kVdM0wNRz6Bf694oVoBDd1Y/
         7KHFwGIOeQLwh+aRMF0Jm2gtdvMK5PKl+6pUwu/Diz1XwMokgFwIV6Ccm+D0Txg3uqU4
         /1GE71sDMEEmUltWYXzV1VsUZx/Muk+zCppmcnYqXvlSvjuRYQWapc9fQ+4da2V7UjuX
         C/7ORkmJVn96DfZNYEV0lIBHKj8UiIrLemVxeQLPQwIexWA+gIFoxxiiCn7LzskSZZzu
         OWFg==
X-Received: by 10.181.12.104 with SMTP id ep8mr16365444wid.54.1378890848498;
 Wed, 11 Sep 2013 02:14:08 -0700 (PDT)
Received: by 10.180.79.133 with HTTP; Wed, 11 Sep 2013 02:14:08 -0700 (PDT)
In-Reply-To: <vpq61u7akin.fsf@anie.imag.fr>
X-Google-Sender-Auth: 0OVdzzjCRh6674df_LzBCDLkW1s
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234555>

On Wed, Sep 11, 2013 at 3:24 AM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> But at the same time, I feel that these redundant lines, especially
>> the latter one, would give the users a stronger cue than just saying
>> that "bar is Untracked"; "do X to include" reminds that bar will not
>> be included if nothing is done.
>
> The one which draw my attention was "(use "git commit" to conclude
> merge)" which is particularly counter-productive when you are already
> doing a "git commit". The advice for untracked files is less
> counter-productive, but while we're removing the non-sensical ones, I
> think it makes sense to remove the essentially-useless ones too.

FWIW, I think it makes sense to remove the extra advice too.

-John
