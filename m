From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 16/18] revert: Remove sequencer state when no commits are pending
Date: Wed, 27 Jul 2011 15:12:23 +0530
Message-ID: <CALkWK0noPtLgr_t=DC_XFdLrWUNCLhUd00Mw1HbmWRJjeT4jew@mail.gmail.com>
References: <1311736755-24205-1-git-send-email-artagnon@gmail.com>
 <1311736755-24205-17-git-send-email-artagnon@gmail.com> <20110727051755.GK18470@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 27 11:42:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qm0de-0003UE-EO
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jul 2011 11:42:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752766Ab1G0Jmq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Jul 2011 05:42:46 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:46415 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751615Ab1G0Jmp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Jul 2011 05:42:45 -0400
Received: by wyg8 with SMTP id 8so847349wyg.19
        for <git@vger.kernel.org>; Wed, 27 Jul 2011 02:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=toV9EN5g46rNx1qpyD9xAzufqvARHKC535EqCPKe7Hk=;
        b=Mg2G2u8ebvKp/PI1HDBFksjJGwFZLNKrbDNK3JurRxF9oHmCYxa5id++7m7RAu2XwE
         6KNBUFy/Kf9C2UYAxHV5UJGRSIZnTOSv/IzBSeUYlXntnOHrEC/JISVoz+6uS3X7hxl6
         Grdg1phMxy6NNNsqwlhy5r37NOxFXbqa/o2FY=
Received: by 10.216.155.134 with SMTP id j6mr6188365wek.81.1311759764063; Wed,
 27 Jul 2011 02:42:44 -0700 (PDT)
Received: by 10.216.70.16 with HTTP; Wed, 27 Jul 2011 02:42:23 -0700 (PDT)
In-Reply-To: <20110727051755.GK18470@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177953>

Hi again,

Jonathan Nieder writes:
> Ramkumar Ramachandra wrote:
>> Change this so that the sequencer state is cleared when a conflict i=
s
>> encountered in the last commit.
>
> This defeats the point of keeping a ".git/sequencer/head" file. =C2=A0=
Why
> not remove the cherry-pick state when it is known no longer to be nee=
ded,
> namely after the conflict resolution is commited?

Sounds nice in theory, but how do we do it?  Remove the state at "git
commit" time?  I've already thought about the problem and presented my
arguments here [1].

[1]: http://article.gmane.org/gmane.comp.version-control.git/177465

-- Ram
