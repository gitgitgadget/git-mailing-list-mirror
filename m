From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [RFD] git glossary: define pathspec
Date: Mon, 29 Nov 2010 17:21:30 +0700
Message-ID: <AANLkTi=e5ugMb0fs05Nd5J82=Ua5sg9UrGXztN6rH4=C@mail.gmail.com>
References: <1291025622-15335-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 29 11:22:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PN0s5-0004Un-Hy
	for gcvg-git-2@lo.gmane.org; Mon, 29 Nov 2010 11:22:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752997Ab0K2KWD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 29 Nov 2010 05:22:03 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:63518 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752566Ab0K2KWC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 Nov 2010 05:22:02 -0500
Received: by wwa36 with SMTP id 36so4516079wwa.1
        for <git@vger.kernel.org>; Mon, 29 Nov 2010 02:22:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:content-type
         :content-transfer-encoding;
        bh=WOQ6rA2EWtO6Y3JkulNLUQ9ZTUuvlDEHLJkhz7Z7wpk=;
        b=OhLjoeQls/UlB+gBVo7wk0F5Xx5FdWxEOEob3laHUl+W4A7KFQ14gfcmUoOuEEiV9e
         Wll9y0lmpdj/wxP2Ei1X4SYbpOoGa3o/UYmyWL5FLnmO6XlK884DjpmX+J000bz7TTJb
         c1W8zRrgpq8pxCjfqHHvpL5Iwwhnkb/aV+LLs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type:content-transfer-encoding;
        b=SfLXk0hihgl1f5qhPMhufLJMVzCilMYq+UqFJIggBPVcJpL5cn3Waer1Nn5oOU2+0n
         T8LHaK2QQ55bFAw9dYF5h8DUbHF/NR6WFfZs++wkx4XVwEJv7RsaMhL3WbVGc3T+WQof
         ic8fffOtqrD1eu5tJ6YOXMtxClGca+WVKfJ5A=
Received: by 10.216.179.193 with SMTP id h43mr139474wem.49.1291026120754; Mon,
 29 Nov 2010 02:22:00 -0800 (PST)
Received: by 10.216.167.193 with HTTP; Mon, 29 Nov 2010 02:21:30 -0800 (PST)
In-Reply-To: <1291025622-15335-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162380>

2010/11/29 Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com=
>:
> sure if #3 can do the same.
> ...
> index to tree-based structure.

Words disappear mysteriously. That part says

#1 can match a wildcard pattern literally (say "a*" will match the
file named "a*"). This is new to me. I don't know if #3 can do the
same.

#2 can't match wildcards, which is known for some time.

#1 and #3 can match index. The famous index does not have directories,
so "Documentation" matches that directory well in #2, but won't in #1
and #3. "Documentation/" works in all three. [1] in the previous mail
can be used to recreate directories, or we can just move the index to
a tree-based structure.
--=20
Duy
