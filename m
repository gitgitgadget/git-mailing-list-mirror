From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: What's cooking in git.git (Nov 2010, #03; Wed, 24)
Date: Thu, 25 Nov 2010 11:35:50 +0100
Message-ID: <AANLkTinWtG8dp_CvoH+EWYz4d=D-N0QUiBSrCNwamROo@mail.gmail.com>
References: <7vk4k2rt2m.fsf@alter.siamese.dyndns.org> <AANLkTi=U=Km28W-xUM0vmRhhYCuhjSxxk5Fk_yhvjz8K@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 25 11:36:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PLZBc-0002LU-FG
	for gcvg-git-2@lo.gmane.org; Thu, 25 Nov 2010 11:36:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752125Ab0KYKgO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 25 Nov 2010 05:36:14 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:41389 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751834Ab0KYKgN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Nov 2010 05:36:13 -0500
Received: by fxm13 with SMTP id 13so631282fxm.19
        for <git@vger.kernel.org>; Thu, 25 Nov 2010 02:36:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:reply-to
         :in-reply-to:references:from:date:message-id:subject:to:cc
         :content-type:content-transfer-encoding;
        bh=6wI430MJWGpXQUNrwakuNUhCgDB+miIKL8zaxLtLytc=;
        b=U+C6xiIawYjFhEwsfOqU8vhxU3KwKklaYxgemD/QYnS7x2aXAGg4rXfnBWLlw8JJwU
         I9tMIwU8R7YIXefGCBch745JJsXAtxW1D64t+joAjmxx9phxPKuDsxc4lv7iJDw/kOJo
         BglKYisKV51Fil17YwyWV1nWfGhT8LhQttms0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=RGxIvArWSkTh7kohNaN91Npj5odO1N2Nvd7YtDq7FTks2Nps/REw+Jhks48ucXr5GT
         eyLl4E0eKb3yv6VjBMMadsBLDnwAk1b8+KFwVa0a7TbuxxUMDUslk+WY05GnYqEqZrFN
         Bb4TIktmg1CBAkCLuAmKwY26n4aEHJNHvWt6Q=
Received: by 10.223.79.72 with SMTP id o8mr533002fak.83.1290681371168; Thu, 25
 Nov 2010 02:36:11 -0800 (PST)
Received: by 10.223.72.206 with HTTP; Thu, 25 Nov 2010 02:35:50 -0800 (PST)
In-Reply-To: <AANLkTi=U=Km28W-xUM0vmRhhYCuhjSxxk5Fk_yhvjz8K@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162122>

On Thu, Nov 25, 2010 at 10:45 AM, =C6var Arnfj=F6r=F0 Bjarmason
<avarab@gmail.com> wrote:
> On Thu, Nov 25, 2010 at 04:16, Junio C Hamano <gitster@pobox.com> wro=
te:
>
>> It is getting ridiculously painful to keep re-resolving the conflict=
s with
>> other topics in flight, even with the help with rerere.
>>
>> Needs a bit more minor work to get the basic code structure right.
>
> Still waiting on input about what exactly needs to be fixed. See
> <AANLkTikw0+FGJmj7C0B9J_3ZVXrbqCw+UzyP3sqfyVdm@mail.gmail.com.
>
> Is there anything else than that (the builtin.h includes) that you
> think needs work?

There was an issue where setting NO_GETTEXT wasn't enough to disable
internationalization. Has this been fixed?
