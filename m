From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH2/2] Libify blame
Date: Mon, 16 Mar 2009 14:49:31 +0100
Message-ID: <fabb9a1e0903160649o6b576976jeb884e18713c154e@mail.gmail.com>
References: <49BE5466.5050202@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com, rene.scharfe@lsrfire.ath.cx
To: pi song <pi.songs@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 16 14:51:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjDDr-0005ze-5w
	for gcvg-git-2@gmane.org; Mon, 16 Mar 2009 14:51:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755529AbZCPNtf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Mar 2009 09:49:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753908AbZCPNtf
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Mar 2009 09:49:35 -0400
Received: from mail-bw0-f175.google.com ([209.85.218.175]:61871 "EHLO
	mail-bw0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752924AbZCPNte (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Mar 2009 09:49:34 -0400
Received: by bwz23 with SMTP id 23so960578bwz.37
        for <git@vger.kernel.org>; Mon, 16 Mar 2009 06:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=j/oAuUtVQsxN5Rnrs3kl5pOIryEvc+bZDKAOTDTz3WI=;
        b=etNokMifLGYojuzDSKovo9DZmR1O1B8C5hSdQ5UL9bHO/DDPNxP8387j3cWlZR8Bzw
         q696ck1cs4PHywQMZ5qgrzzYPgsPYZfcYB8JuqCxSWZu5J1uvQRnXa3eMLRJgiBClF54
         DqgJDfZhcdpbN72v+j56UarU1gKvmXTvV1htY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=fC1p8aghRiXlSo/UipUJz0DHZDQlHEJ1Pvs288aUSqwiA2ReFgZMSNrRj6fGfnHZDg
         PdLRX4lxlCaevRq8sEvsodH3jgQ6Rv8v52pZoVBS26sEtEZhfWDW/UsoeAbwSK3pcFFb
         ZnbTlcnP5jiiS4fBFlMbgOlDOEzNq6/00vSg0=
Received: by 10.103.244.10 with SMTP id w10mr2179567mur.71.1237211371166; Mon, 
	16 Mar 2009 06:49:31 -0700 (PDT)
In-Reply-To: <49BE5466.5050202@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113326>

Heya,

On Mon, Mar 16, 2009 at 14:30, pi song <pi.songs@gmail.com> wrote:
> This looks like a very HUGE patch but it does merely splitting the current builtin-blame.c into smaller blame.c without changing any logic.
> This is still WIP. The next patch will organize functions more appropriately.

It would be nice if you could paste the output of "git diff -M" after
the triple-dash to show that it is indeed only a small change.

-- 
Cheers,

Sverre Rabbelier
