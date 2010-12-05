From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: What's cooking in git.git (Dec 2010, #01; Sat, 4)
Date: Sun, 5 Dec 2010 14:00:43 +0100
Message-ID: <AANLkTimX215CNAG_mosqzOh-EPBoSimK0s-n4YmKm1rb@mail.gmail.com>
References: <7voc90wx36.fsf@alter.siamese.dyndns.org>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Dec 05 14:01:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PPEDI-00040l-NT
	for gcvg-git-2@lo.gmane.org; Sun, 05 Dec 2010 14:01:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755684Ab0LENBG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 5 Dec 2010 08:01:06 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:58718 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755589Ab0LENBF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Dec 2010 08:01:05 -0500
Received: by fxm20 with SMTP id 20so3490236fxm.19
        for <git@vger.kernel.org>; Sun, 05 Dec 2010 05:01:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:reply-to
         :in-reply-to:references:from:date:message-id:subject:to:cc
         :content-type:content-transfer-encoding;
        bh=RaA/Ellkj7sfUdBKOMY3jl9i/n6TWo6DiAAqNzJUo1I=;
        b=XTksLCkBfCTu9LTgTL+/eT4vgGibaouaMrHtG7yolr6PY6Mhgrk7DrAbtaHmZWF6rj
         ggJHO3JuBy4aMSQgdcGJiH6y8Q7PMEQn0rVBn669H13nPHAe0Tf7yHONLPAzAm8C9KAK
         t8u19nI7jUJkKD2Kd2OBUCokr7mt7YgOg0h90=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=ibhyaJZoZgjiRz7g4GFy9vhqyLSoclsRW7lMzE3d6EM2cVRPlzH/Jjwl/DumkeLECJ
         KwHLCkMdWJx0p8TZtIyqQlrdszNQz5pBte3UBe5Hi1TXUYPH+b/Z/NyxPXpuuHIDIbae
         ZPoSUmJNbwjJW7u93nIe+aobweA9C9TKJ3jMI=
Received: by 10.223.83.11 with SMTP id d11mr4383587fal.37.1291554063810; Sun,
 05 Dec 2010 05:01:03 -0800 (PST)
Received: by 10.223.95.202 with HTTP; Sun, 5 Dec 2010 05:00:43 -0800 (PST)
In-Reply-To: <7voc90wx36.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162948>

On Sun, Dec 5, 2010 at 7:30 AM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Here are the topics that have been cooking. =A0Commits prefixed with =
'-' are
> only in 'pu' while commits prefixed with '+' are in 'next'. =A0The on=
es
> marked with '.' do not appear in any of the integration branches, but=
 I am
> still holding onto them.
>
> --------------------------------------------------
> [New Topics]
>
> * aa/status-hilite-branch (2010-11-18) 1 commit
> =A0- status: show branchname with a configurable color
>
> I am indifferent/uninterested; I don't see anything wrong with it, bu=
t I
> do not find coloring the field particularly useful myself.
>
> * ef/help-cmd-prefix (2010-11-26) 2 commits
> =A0- (jc) review comments
> =A0- help: always suggest common-cmds if prefix of cmd
>
> Reroll, or squash?

I was planning on re-rolling, but looking at it with fresh eyes it
doesn't seem like there's much useful I can do. So feel free to just
squash it. I think the original commit message still makes sense.
