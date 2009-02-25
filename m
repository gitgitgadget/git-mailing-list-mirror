From: Feanil Patel <feanil@gmail.com>
Subject: Re: Files different for me
Date: Wed, 25 Feb 2009 10:42:52 -0600
Message-ID: <16946e800902250842h3973efdoc902de38ac35562f@mail.gmail.com>
References: <450196A1AAAE4B42A00A8B27A59278E709E047DE@EXCHANGE.trad.tradestation.com>
	 <16946e800902250840o677f8708x7c0bf8980e004b91@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 25 17:44:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcMrv-0002vQ-4S
	for gcvg-git-2@gmane.org; Wed, 25 Feb 2009 17:44:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754170AbZBYQm4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Feb 2009 11:42:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753249AbZBYQmz
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Feb 2009 11:42:55 -0500
Received: from qw-out-2122.google.com ([74.125.92.26]:4418 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751677AbZBYQmy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Feb 2009 11:42:54 -0500
Received: by qw-out-2122.google.com with SMTP id 5so166825qwi.37
        for <git@vger.kernel.org>; Wed, 25 Feb 2009 08:42:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=8h8cD/ok9tHuyjL3yNlutRPBhpg4Lii8d52JmwQZ1uk=;
        b=yB8NEFyqJ4+NxcKZ4j9u3XebBbXRSn2iJg8SRjWlwjyeGqgfJuXeR1BlnG7zMiO9gG
         J5XkHewuuuAxZVpfoCwcmJnUyzmccIy1n87M6iW9euRRfax/N9WQMjL1O8E+R0Ef/2iA
         lCkrhB6Pm+KaoS7gi7LwFtP4Eu+04ykh3BttE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=MEgevQXZpBqSsoFHPeZEPNJaap+HLHPUMnJtWg3wtTTsJtU9mhMQucL2lLcQYwBlNI
         fhV7f1gqBqdQsSyBcKC8fViM2pRe/HeYzdGVxaBSLXXkuTlquiDgQBALBIUUoUvhUSzG
         o6+G4RTVp6EdNwaOR63U6MFDmP0BL++DwnR8Q=
Received: by 10.224.21.169 with SMTP id j41mr627717qab.60.1235580172424; Wed, 
	25 Feb 2009 08:42:52 -0800 (PST)
In-Reply-To: <16946e800902250840o677f8708x7c0bf8980e004b91@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111468>

You could use 'git stash' to stash the changes away for later use.
Then when you want them you can 'git stash apply' them later.

-Feanil

On Wed, Feb 25, 2009 at 10:11 AM, John Dlugosz
<JDlugosz@tradestation.com> wrote:
>
> I'm working with a group, and using git for source code.=C2=A0 I need=
 to change a couple files temporarily and just for me.=C2=A0 I thought,=
 "that's easy", just don't stage them when I check in changes.=C2=A0 Bu=
t, what do I do when I pull changes from others?=C2=A0 I think it will =
complain that I have unsaved changes.
> What's the best way to do this?
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
