From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] checkout: warn about 'branch name' rather than 'local 
	branch'
Date: Fri, 29 Jan 2010 22:45:04 +0100
Message-ID: <fabb9a1e1001291345w2723f803sbffb513174445b45@mail.gmail.com>
References: <fabb9a1e1001291256j71e2c95cic21cb5a6a0cc1fe8@mail.gmail.com> 
	<1264799342-11093-1-git-send-email-srabbelier@gmail.com> <7vvdekh9kb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Ron1 <ron1@flownet.com>,
	Jacob Helwig <jacob.helwig@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 29 22:46:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nayfq-0000iw-VP
	for gcvg-git-2@lo.gmane.org; Fri, 29 Jan 2010 22:46:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755735Ab0A2VqZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 Jan 2010 16:46:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755731Ab0A2VqY
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jan 2010 16:46:24 -0500
Received: from mail-pz0-f190.google.com ([209.85.222.190]:47524 "EHLO
	mail-pz0-f190.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754873Ab0A2Vp0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Jan 2010 16:45:26 -0500
Received: by pzk28 with SMTP id 28so1895793pzk.4
        for <git@vger.kernel.org>; Fri, 29 Jan 2010 13:45:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=kDEY8a7wBSa1pb3qe3zVcL0OZUd9dxGbNN3Po85lAX8=;
        b=xRPJPpFUjgYT/iaW7DVBGPhwb3fm9GUuteiWTlojqsb/20IIZclmnp3MnDTZahMwtS
         TrIpGDUUCGTESg6f5DiER4N8tvPBEIf3U3RORZGBmW60mu6/5DV/j6gWZ43jFoQ/b3H0
         pRavhUeNosDU6n9VQF/+oMqGhdd1m0E5mmaRE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=wPy+bAa/cvJLjObTqhNVxOR92kqI/pyXEzCwUgldbW+RcVtLGTcJcDJWMT/+WqYC2R
         8rCaZNJHGNO9pEIoZ+QOIc3rOmpe1US54JwMCtXn31uYIFmrKWCUXRMiGYOBzWZ1P3rM
         LR+AwTV0NeLRtpl6WwP5e847sYJCKv5KGJZmU=
Received: by 10.142.117.25 with SMTP id p25mr905790wfc.301.1264801524158; Fri, 
	29 Jan 2010 13:45:24 -0800 (PST)
In-Reply-To: <7vvdekh9kb.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138374>

Heya,

On Fri, Jan 29, 2010 at 22:42, Junio C Hamano <gitster@pobox.com> wrote=
:
> I explained why I think that is not solving the real problem. =A0To a=
 user
> faced with an unexpected detached HEAD situation, it is not very impo=
rtant
> to explain how we were forced to detach (i.e. because you didn't tell=
 me
> to switch to a branch).

I agree your patch is better :).

--=20
Cheers,

Sverre Rabbelier
