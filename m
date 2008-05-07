From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <sbejar@gmail.com>
Subject: Re: [PATCHv4 4/4] user.warnautomatic: add config to control if the committer ident is shown
Date: Wed, 7 May 2008 18:32:24 +0200
Message-ID: <8aa486160805070932w44edf4b0j3b712ec22c10fe7d@mail.gmail.com>
References: <1209917092-12146-1-git-send-email-sbejar@gmail.com>
	 <1209917092-12146-5-git-send-email-sbejar@gmail.com>
	 <7v8wymdred.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Junio C Hamano" <junio@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 07 18:33:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jtma3-000212-1p
	for gcvg-git-2@gmane.org; Wed, 07 May 2008 18:33:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752632AbYEGQcc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 7 May 2008 12:32:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752691AbYEGQcc
	(ORCPT <rfc822;git-outgoing>); Wed, 7 May 2008 12:32:32 -0400
Received: from yw-out-2324.google.com ([74.125.46.30]:23095 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752632AbYEGQc3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 May 2008 12:32:29 -0400
Received: by yw-out-2324.google.com with SMTP id 9so199185ywe.1
        for <git@vger.kernel.org>; Wed, 07 May 2008 09:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=jIMiOkiSswU0rMQfZqeyloe6XKeyoAsaAUCxzBm9UMI=;
        b=UgQTGYM1lmNnfwjYBKH20nMzs6eT+JtdI6yWR7UkStHQhELBwJ6pXfQln01njnCMdjMJt/VdzqoFqbkL7IwqGENNlRYGD4hRKX+cOCGMZAtSMIIQK+OG3XDjvfrpWIMTUQzloGzc+Jwfg1cRRh12fUV2YfxWhuMfc1Jg4UhEmSg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=AisJu/ibEBsX8x1+9ycfESN8GCKM6omNOZo3f6KmNAO5pcI4UXpD+GVXWHHgCX820baFLEFw2hdWTA/hVOHTAVtffLkxN4/9DdlrqjkRCHo/fZSmz4hJcCkL0eibvw5uHmIf7YEN98nPxH4Vw66Z00jBpMPKTO7oxG1teZPmELw=
Received: by 10.150.204.8 with SMTP id b8mr2247027ybg.75.1210177944335;
        Wed, 07 May 2008 09:32:24 -0700 (PDT)
Received: by 10.150.152.19 with HTTP; Wed, 7 May 2008 09:32:24 -0700 (PDT)
In-Reply-To: <7v8wymdred.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81463>

On Wed, May 7, 2008 at 6:12 PM, Junio C Hamano <junio@pobox.com> wrote:
> Santi B=E9jar <sbejar@gmail.com> writes:
>
>  > Signed-off-by: Santi B=E9jar <sbejar@gmail.com>
>
>  By setting this new variable the user can squelch undesired noise th=
e
>  previous change introduces, but the user can just set user.name and
>  user.email to desired values to squelch it anyway.

Or the user prefers the automatic ident.

>
>  So either this new variable is superfluous, or the previous change i=
s too
>  susceptible to produce false positives that need squelching with suc=
h a
>  variable, or both.  In any case, not a very good sign.

=46or me it is superfluous, as I prefer to see what is the committer
ident when it is generated.
I even said I prefer just showing the automatic ident. I sent it in
case it was decided it was worth.

Santi
