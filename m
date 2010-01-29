From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: master^ is not a local branch -- huh?!?
Date: Fri, 29 Jan 2010 22:28:57 +0100
Message-ID: <fabb9a1e1001291328s1df443d6jdf0501cda17072de@mail.gmail.com>
References: <ron1-2E17EF.12204629012010@news.gmane.org> <hjvgs1$rep$1@ger.gmane.org> 
	<ron1-953427.13240429012010@news.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Ron Garret <ron1@flownet.com>
X-From: git-owner@vger.kernel.org Fri Jan 29 22:29:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NayP5-0007Gl-PW
	for gcvg-git-2@lo.gmane.org; Fri, 29 Jan 2010 22:29:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754479Ab0A2V3S convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 Jan 2010 16:29:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754171Ab0A2V3S
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jan 2010 16:29:18 -0500
Received: from mail-px0-f182.google.com ([209.85.216.182]:45118 "EHLO
	mail-px0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751857Ab0A2V3R convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Jan 2010 16:29:17 -0500
Received: by pxi12 with SMTP id 12so1994159pxi.33
        for <git@vger.kernel.org>; Fri, 29 Jan 2010 13:29:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=qfea8DxLmyhrbLaR59c0pdnA8HtM8qRfHH++2j/I4sM=;
        b=kOyGN55MlvD+zblKxr6oCj22abLrcln0WeU3GIVmLnP1uBlNooX7E/bo2uqcvb8jDR
         M+7h8D1FyBVfPYn+UbXXTLHWcAVutQcN739OucFcbJ++RTg5qctj0p3NWU2jWC1+GRC9
         p9O4EPT7YnNTIs+Gbm2u/+Aacxoscxyi2e8XQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=Cr+EzPFSuMECiefJYqnuXzNd6gu4tZ5xMbvtPfrfd0kBz8MNynHptjjQlew+WXQ6m/
         lsIdwQYJgZ3gj/J9d00gbbdd8JiCj1K45sJhFqKroUSq+pThxr9AVwEZWzmVXz+avI85
         Txkg/8S9v/aEaxaMde8nz8hIkMFhfa6BCV2Lo=
Received: by 10.142.151.31 with SMTP id y31mr934821wfd.107.1264800557090; Fri, 
	29 Jan 2010 13:29:17 -0800 (PST)
In-Reply-To: <ron1-953427.13240429012010@news.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138365>

Heya,

On Fri, Jan 29, 2010 at 22:24, Ron Garret <ron1@flownet.com> wrote:
> Yes, I read that. =A0But what I'm trying to do is not just *look* at =
the
> history, I want to restore my working tree to a previous version. =A0=
The
> "Exploring History" section of the docs doesn't say how to do that.

Do you want to restore your working tree only, or also throw away the
history? If the former, you could look at 'git revert', if the latter,
'git reset --hard' could be what you need (warning: the latter is a
destructive command that will let you _throw away history_).

--=20
Cheers,

Sverre Rabbelier
