From: Mark Lodato <lodatom@gmail.com>
Subject: Re: [PATCH 2/8] docs: use `...' instead of `*' for multiplicity
Date: Sat, 18 Dec 2010 11:32:02 -0500
Message-ID: <AANLkTikKFSNC0MiZ0be6mUZFqR3atZspD9JfgKVyrrek@mail.gmail.com>
References: <1292650725-21149-1-git-send-email-lodatom@gmail.com>
 <1292650725-21149-3-git-send-email-lodatom@gmail.com> <m3hbebl7tv.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 18 17:32:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PTzhs-0003Wm-AA
	for gcvg-git-2@lo.gmane.org; Sat, 18 Dec 2010 17:32:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755952Ab0LRQcX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 18 Dec 2010 11:32:23 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:61109 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752677Ab0LRQcX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 18 Dec 2010 11:32:23 -0500
Received: by iwn9 with SMTP id 9so1774650iwn.19
        for <git@vger.kernel.org>; Sat, 18 Dec 2010 08:32:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=guiIeDbVAREPf6nYuNoGAR043Uh5xyERwKO+YCHaBq0=;
        b=fhcOPDRhPlPnvXS1hXxIt6mspPZZpFtifaAVWmqxCK+bdT0u21rcSTe3j1mbPgQ4xR
         lRZQAtewZJ9u2cSr0bQ3l5ejT6C8fO8ElVLbMX9q9Ee+RfxR/Af75axWAWkQC+t4FYa+
         1bD4emrECQ8XX7/0Uht2Cu2/CERtdRi2WTiZs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=obZAF4c7zAECxDgir9dW4B5XJAAmIEwWNhs7mLG5E1DSfImZZpuq86FXrehgOqUD6g
         XtG9DqvCkaUpNIypnDe8jkBmpzwENwfqAeu9rNxOZhyEcOJ9AGkgPnF0kGU9TRt2qYt6
         FcAsyOEKW4K1yijBCxI98W/ntNIfaR6UPdBoQ=
Received: by 10.42.165.6 with SMTP id i6mr2144143icy.388.1292689942379; Sat,
 18 Dec 2010 08:32:22 -0800 (PST)
Received: by 10.42.167.201 with HTTP; Sat, 18 Dec 2010 08:32:02 -0800 (PST)
In-Reply-To: <m3hbebl7tv.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163922>

On Sat, Dec 18, 2010 at 5:00 AM, Jakub Narebski <jnareb@gmail.com> wrot=
e:
> Mark Lodato <lodatom@gmail.com> writes:
>
>> Finish the work of 0adda93 (Use parentheses and `...' where appropri=
ate)
>> to follow the rules set forth in Documentation/CodingGuidelines.
>>
>> Signed-off-by: Mark Lodato <lodatom@gmail.com>
>
> [...]
>
>> - =C2=A0 =C2=A0 "git describe [options] <committish>*",
>> + =C2=A0 =C2=A0 "git describe [options] <committish>...",
>
> Isn't <sth>... one or more, while <sth>* is zero or more, i.e. should=
n't
> <sth>* be replaced by [<sth>...]?

Yes, I was confused by the * notation - one more reason to get rid of i=
t!

> Hmmm... I see that <sth>* was actively wrong if it was to mean zero o=
r
> more, so your change doesn't only make documentation more consistent,
> but fixes errorneous use of convention.

I think zero or more is correct, which is why I submitted patch 8/8 to
change from <commit>... to [<commit>...].  Now I understand that all
8/8 was doing was fixing a mistake I introduced in this patch.  I'll
correct it in the next version.
