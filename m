From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 2/3] completion: remove old code
Date: Mon, 30 Jan 2012 12:51:04 +0200
Message-ID: <CAMP44s2j+qotu8Fb-1qq9bqHqt+ZF877YzZFXHiMo7Z_BGzTMA@mail.gmail.com>
References: <1327880479-25275-1-git-send-email-felipe.contreras@gmail.com>
	<1327880479-25275-3-git-send-email-felipe.contreras@gmail.com>
	<20120130023642.GA14986@burratino>
	<CAMP44s1H6Db6Xq_iZseXppaTwpBCeu14ySgPfmoQnpELfywQ-Q@mail.gmail.com>
	<7vd3a1erwf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 30 11:51:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RropM-0000Mh-Ub
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jan 2012 11:51:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752212Ab2A3KvH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jan 2012 05:51:07 -0500
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:39065 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752031Ab2A3KvF (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Jan 2012 05:51:05 -0500
Received: by mail-lpp01m010-f46.google.com with SMTP id u2so2101292lag.19
        for <git@vger.kernel.org>; Mon, 30 Jan 2012 02:51:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=5X5Gn+qSQZZgm5fMDZwy03+dTHiRIoSB/x/eRNR0TdE=;
        b=ArN3SroKe2/Ij5A4eaIOzLn0i0PCAF2PI+WAxY6c/kgVXbMmJ1/JMtwG/9qNdg4BVy
         0uy7FLTqpm9fdODcEOpOLFGhTk5shquLAvB62j0C8eAmv15BoTK59GSvKidEl4W7qeis
         nrxcsL9T2BN+C9IVcJPmE6XFF7xkmv2hCeEBI=
Received: by 10.152.103.169 with SMTP id fx9mr8849630lab.10.1327920665079;
 Mon, 30 Jan 2012 02:51:05 -0800 (PST)
Received: by 10.112.40.202 with HTTP; Mon, 30 Jan 2012 02:51:04 -0800 (PST)
In-Reply-To: <7vd3a1erwf.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189339>

On Mon, Jan 30, 2012 at 6:27 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> OK, maybe some people use it, but most likely they are using an old
>> version of git, and thus an old version of the completion script.
>
> Please adjust your attitude about backward compatibility to match the
> standard used for other parts of Git.

What attitude? I am simply stating a fact. How much percentage of
people do you think still have .git/remotes around? How many people do
you think have clones more than 3 years old? And how many of these
people would complain if remotes were not properly completed for these
repos?

I doubt anybody would have complained, but I guess we would never
know, because I already proposed a solution that would work for them
and only uses a *single* line of code, unlike the current 40 ones.

I don't see what is the problem with the attitude of sending a patch
to remove code that most likely nobody cares about (neither you or I
have numbers on this), and then finding an alternative when people do
care about it.

Cheers.

-- 
Felipe Contreras
