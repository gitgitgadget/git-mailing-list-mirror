From: Hitoshi Mitake <h.mitake@gmail.com>
Subject: Re: [PATCH v0 0/2] git-less: a specialized pager for git-log
Date: Sat, 24 Mar 2012 02:18:36 +0900
Message-ID: <CAMO-S2hZXX-RSN+KQZ=a+dSbkAhziqvF4S_iSH+TqqtcFRiypA@mail.gmail.com>
References: <1332441744-5142-1-git-send-email-h.mitake@gmail.com>
	<7v1uokxxzh.fsf@alter.siamese.dyndns.org>
	<4F6C4B59.8060102@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Fri Mar 23 18:18:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SB88R-00052x-22
	for gcvg-git-2@plane.gmane.org; Fri, 23 Mar 2012 18:18:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753119Ab2CWRSi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 23 Mar 2012 13:18:38 -0400
Received: from mail-qa0-f46.google.com ([209.85.216.46]:53346 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751693Ab2CWRSh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 Mar 2012 13:18:37 -0400
Received: by qaeb19 with SMTP id b19so1074763qae.19
        for <git@vger.kernel.org>; Fri, 23 Mar 2012 10:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=AbkHeBghgqjgR1nxftBD+9ladHvfddvjsJwvWNNKr0E=;
        b=FmdfExsz8JAkvQsHv09Tx/MvU2yPTWPXsTHSJxTsOkt6L3smtlVdeuYXsDnwv4eHz6
         viU9i+ztHVxC/hTKRC0YbMvbl2U9gqjahH6DhX70ospb8cQ8E8w/FSQQUAqYQyaBJK6V
         FQsEmhm1QO8327iGH1K+Ynvkk21rd1i/Jk3ahR85EAjjQjVPxd5M+LJLDoQxks/wJaLH
         PquztfUy8QOM5rGhV1mmc0HXxlcSczfBWqgcHg5Vty2TYe1eUHRbD6ESlJtPiVWxQiBE
         1/wndQLWufuqOT2nqmxjdLQ9iQn8+d2KeUd4QrY99AyYq6IDtbIyrbAPsFEL3Czvfzcp
         2tZA==
Received: by 10.224.168.147 with SMTP id u19mr16766022qay.89.1332523116699;
 Fri, 23 Mar 2012 10:18:36 -0700 (PDT)
Received: by 10.229.169.137 with HTTP; Fri, 23 Mar 2012 10:18:36 -0700 (PDT)
In-Reply-To: <4F6C4B59.8060102@op5.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193774>

On Fri, Mar 23, 2012 at 19:07, Andreas Ericsson <ae@op5.se> wrote:
> On 03/22/2012 08:00 PM, Junio C Hamano wrote:
>> Hitoshi Mitake<h.mitake@gmail.com> =A0writes:
>>
>>> If the pager can recognize the end of each commit, more confortable=
 viewing of
>>> git-log's output will be possible.
>>
>> I think people just use "/^commit .*<RET>" once and then nagivate wi=
th "n"
>> (and to change direction, "?<RET>") for this.
>>
>
> Or capital N.
>
> It's mostly useful when one wants to view the patch as well as the me=
ssage,
> so an alias like
>
> =A0 =A0logp =3D !PAGER=3D'less -p ^commit' git log -p

Yes, moving is not so large problem. But less cannot search regex with
specified limit. Sometime I want to search string e.g. "something" only=
 in
the commit I'm focusing on.

>
> should work well, and also make LISP nerds giggle.
>

p? :)

> --
> Andreas Ericsson =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 andreas.ericsson=
@op5.se
> OP5 AB =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 www.op=
5.se
> Tel: +46 8-230225 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Fax: +46 8-23023=
1
>
> Considering the successes of the wars on alcohol, poverty, drugs and
> terror, I think we should give some serious thought to declaring war
> on peace.



--=20
Hitoshi Mitake
h.mitake@gmail.com
