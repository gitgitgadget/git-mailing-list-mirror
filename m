From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] grep: --full-tree
Date: Wed, 25 Nov 2009 21:46:01 +0100
Message-ID: <fabb9a1e0911251246l4684f357pb5f379b191aaa64a@mail.gmail.com>
References: <7vk4xggv27.fsf@alter.siamese.dyndns.org> <fabb9a1e0911250656k31229c42jd79fb94c1a619e59@mail.gmail.com> 
	<7vr5rmwgbn.fsf@alter.siamese.dyndns.org> <fabb9a1e0911251219t3ad0dacen67d8615ef6eefa02@mail.gmail.com> 
	<7vd436uzet.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 25 21:46:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDOkv-0003aq-2a
	for gcvg-git-2@lo.gmane.org; Wed, 25 Nov 2009 21:46:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759371AbZKYUqR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2009 15:46:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759108AbZKYUqQ
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Nov 2009 15:46:16 -0500
Received: from mail-vw0-f192.google.com ([209.85.212.192]:58101 "EHLO
	mail-vw0-f192.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752309AbZKYUqQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2009 15:46:16 -0500
Received: by vws30 with SMTP id 30so23940vws.33
        for <git@vger.kernel.org>; Wed, 25 Nov 2009 12:46:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=svjAhCK1dZsoRsthSlNav0GZCQGuDtLfPF6W7wYX/Gg=;
        b=cYKACIgL54S7pdGXpA0+dwlwkm2wQII1urLazMufJA7skJyrjlVZtbvCKrwRRDjLSp
         h38Q2wTqruqSPlGKZ4bV1cnKnw/QFK5tXU7laWsUA4Y5nQ7SwpBFDVw6cO769K2LiXLX
         eFF9NKZ7x0fvRjaPJSUbi9p6Ijq6Qw+TSHbUo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=gpfd/lS48OODTubIlx1/Gk0elO+LjumXu02+4wCwy5Fz9J1W8eIsyIkFhTuCNtl5FB
         Zrmizj4kpu3cvjT8uxcd0XF4sIfvt8O3G4oUH3JB1Uo+gFvcZAQ5lIwOJkYMAMwX+26E
         aRKRN/325aywDq4/74XnDT/PyFLWipnsNjzU0=
Received: by 10.220.123.2 with SMTP id n2mr466027vcr.71.1259181982084; Wed, 25 
	Nov 2009 12:46:22 -0800 (PST)
In-Reply-To: <7vd436uzet.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133670>

Heya,

On Wed, Nov 25, 2009 at 21:23, Junio C Hamano <gitster@pobox.com> wrote:
> But then you can alias "gr 'grep --full-tree'" with the same ease and
> there is no reason to change the default.

I agree, but then again I'm somewhat biased, as I want the current behavior :P.

-- 
Cheers,

Sverre Rabbelier
