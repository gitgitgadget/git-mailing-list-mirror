From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] filter-branch: remove multi-line headers in msg filter
Date: Fri, 09 Oct 2015 10:53:28 -0700
Message-ID: <xmqqpp0oormv.fsf@gitster.mtv.corp.google.com>
References: <20151009002113.GA329@freya.jamessan.com>
	<561767AC.6060503@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: James McCoy <vega.james@gmail.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Oct 09 19:53:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZkbrP-0005jA-DE
	for gcvg-git-2@plane.gmane.org; Fri, 09 Oct 2015 19:53:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755734AbbJIRxd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 Oct 2015 13:53:33 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:35078 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756657AbbJIRxb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Oct 2015 13:53:31 -0400
Received: by pabve7 with SMTP id ve7so34058329pab.2
        for <git@vger.kernel.org>; Fri, 09 Oct 2015 10:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=2ghCqCA2zg4Zb0ARG3w47Jly3Rf7NmBCY6O9/P5sKWg=;
        b=dJBy9cSGWVAve2yvMbsoCVMX3Ih8aDeiyWywq61kX4+m3HJSE/9wIFNz0zppRHM9r6
         lpqovLQtsW8eJUoKOmzsyL68EdXpIGeyA/56e7WIazyGbnsjGmJB5T5K/av5k3mRPog8
         afiV9jl+RqvUZiTxCWM+4EipCl/+QcsxBJJc/XaWZyw4AoWBTGhF1vtTfFpCH78RE25q
         WBCisNYQ21gEAKsOD7VxpM1FMTOXoux0lUCPzdtYhqjNtEYJ+mcav9girZHxM5JZ+YlC
         0+F+xwiinN3iVTxJgbtR6GEh7VrNTU1tVfwVjPkAdaG6vnr2sq3xQRl8BUFwob19PfD5
         VBEg==
X-Received: by 10.66.102.7 with SMTP id fk7mr16613682pab.119.1444413210575;
        Fri, 09 Oct 2015 10:53:30 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:6d9f:e45b:5c65:e644])
        by smtp.gmail.com with ESMTPSA id bh4sm3622005pbb.62.2015.10.09.10.53.29
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Fri, 09 Oct 2015 10:53:29 -0700 (PDT)
In-Reply-To: <561767AC.6060503@drmicha.warpmail.net> (Michael J. Gruber's
	message of "Fri, 9 Oct 2015 09:07:24 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279310>

Michael J Gruber <git@drmicha.warpmail.net> writes:

>> Set IFS to an empty string for the =E2=80=9Cread=E2=80=9D call, thus=
 disabling the word
>> splitting, which causes $header_line to be set to the non-empty valu=
e '
>> '.  This allows the loop to fully consume the header lines before
>> emitting the original, intact commit message.
>>=20
>> Signed-off-by: James McCoy <vega.james@gmail.com>
>> ---
>
> Thanks for hanging in :)
>
> Reviewed-by: Michael J Gruber <git@drmicha.warpmail.net>

As long as you are fine with giving authorship to James, I am fine
with that.  I'll amend what is queued with your reviewed-by above
and will merge to 'next'.

Thanks.
