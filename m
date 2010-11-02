From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH v2] Remove restriction on notes ref base
Date: Wed, 3 Nov 2010 00:03:18 +0100
Message-ID: <AANLkTikxjBCAEFNBy0CYaB1fj7EqTGwSQHyuN1mQ8XoR@mail.gmail.com>
References: <1288718532-11939-1-git-send-email-kroot@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Kenny Root <kroot@google.com>
X-From: git-owner@vger.kernel.org Wed Nov 03 00:03:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDPtI-0004Y7-5W
	for gcvg-git-2@lo.gmane.org; Wed, 03 Nov 2010 00:03:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751336Ab0KBXDk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 2 Nov 2010 19:03:40 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:38393 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750829Ab0KBXDj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Nov 2010 19:03:39 -0400
Received: by yxk8 with SMTP id 8so4194459yxk.19
        for <git@vger.kernel.org>; Tue, 02 Nov 2010 16:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=Zbsek05pADw9WLf1HZx8dYeIE8c3MtXytFiqiHuSRBs=;
        b=iRxTVWivc8agERl/Z9BB6rBZ+ecjKj1gK+fGyQNLQ9/IFKOg6H5V1siqz1NOH8fEsH
         rTSUKDOkmZzYRi/HzPJq0Es8OR5eSmhQb5ydtmgHigWLkMHNVg74qUCXNwME2fsFB2PA
         /y5Pq9BZAXvn2rs3Ypc7PLwIKb1ZmWkjG+NfQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=gNso+EUgLEawWOi+i4wZryfpimvDaNxT/y+Pd7XFjpHfE0JyyFUfZO/wh52NR4dYcO
         iMdl9ww4xBUXVNSf4nQk4IAVLAgQd7S5QunX7iDmwgPdtMyyAIaHfDzxbhP4Qpodv/RE
         +oK4tQ/rZ3k4mF5D9QQAEZsLAzuMALQTIo1K0=
Received: by 10.151.49.5 with SMTP id b5mr260764ybk.84.1288739018358; Tue, 02
 Nov 2010 16:03:38 -0700 (PDT)
Received: by 10.150.58.11 with HTTP; Tue, 2 Nov 2010 16:03:18 -0700 (PDT)
In-Reply-To: <1288718532-11939-1-git-send-email-kroot@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160563>

Heya,

On Tue, Nov 2, 2010 at 18:22, Kenny Root <kroot@google.com> wrote:
> + =C2=A0 =C2=A0 =C2=A0 /* If no notes and >0 non-notes, this is proba=
bly not a notes tree */
> + =C2=A0 =C2=A0 =C2=A0 if (empty_tree && t->first_non_note)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 die("'%s' doesn't =
look like a valid notes tree", t->ref);

Do we want a '-f' like functionality to override this?

--=20
Cheers,

Sverre Rabbelier
