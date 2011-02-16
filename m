From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: My Git Patch
Date: Wed, 16 Feb 2011 11:33:08 +0100
Message-ID: <AANLkTi=u6Ff88f1A6Hs58Qr4EXAFVaAktFehn2YdodyE@mail.gmail.com>
References: <4D5BA40A.4020009@io.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: rkitover@io.com
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Feb 16 11:33:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PpehT-00016E-3J
	for gcvg-git-2@lo.gmane.org; Wed, 16 Feb 2011 11:33:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755570Ab1BPKdb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Feb 2011 05:33:31 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:41894 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755126Ab1BPKd3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Feb 2011 05:33:29 -0500
Received: by fxm20 with SMTP id 20so1187197fxm.19
        for <git@vger.kernel.org>; Wed, 16 Feb 2011 02:33:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=LAlMRLD1kkDFlIFWzq3cO90nz8cBldPhZGOiMePLWko=;
        b=PgOmmQyNKB6XETVnN8voxorsWEoDIvQBo0OBwcbjRC6UxJAIvuwpe/lz42OBF0h4nx
         NuSMh7g4sz8nKhZoBf12s24D+jEpEQHqKC1rCJIlITB1k+gIsWrLyuT2hu7J+/4gawHF
         oSklNL1Odi469jU9lb5jZLx0vCYfuInw0U4Hk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        b=TCpcMBp7siMmDRTs8aPv8zWMzgy+U33WiD1QHSgdqWzVUt6ZeouPuaikRLK0wJ6p/q
         IfklGKKLj60UwX+5f9X7gxgU9GhmchVLgPq665AkuqOH/YsvvpgYhcpIvfAqH8JQtnR1
         +mqwTmEh6Vlr78YHxr39wG4FrAeVO6m/RwgN0=
Received: by 10.223.103.4 with SMTP id i4mr511627fao.123.1297852408367; Wed,
 16 Feb 2011 02:33:28 -0800 (PST)
Received: by 10.223.95.206 with HTTP; Wed, 16 Feb 2011 02:33:08 -0800 (PST)
In-Reply-To: <4D5BA40A.4020009@io.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166952>

On Wed, Feb 16, 2011 at 11:16 AM, Rafael Kitover <rkitover@io.com> wrote:
> Hi Erik,
>
> I resent my patch to the list with the parts you objected to removed.
>
> What are the next steps to get my patch included in Git?
>

The next step is to wait. The interested parties should be allowed to
take notice of the patch and comment.

Every couple-ish of days, Junio C Hamano (the Git maintainer) sends
out a "What's cooking in git.git"-mail, where he informs what patches
he has picked up, and what his plan for them (if any) are.

If nothing more happens within a couple of days, you could consider
re-sending with Junio as a CC (and possibly also Petr Baudis, the main
author of Git.pm, where the biggest amount of changes in your patch
were).

Oh and In the future, please send mails like this to the Git mailing
list instead of directly to some of the interested parties. But feel
free to CC me.
