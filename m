From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: [PATCH] Added --export option to git-send-email.
Date: Sun, 13 Jul 2008 17:32:57 -0400
Message-ID: <32541b130807131432j78e5100dyea20893268321466@mail.gmail.com>
References: <20080710170735.4c5b237a@linux360.ro>
	 <7vskudr11m.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Eduard - Gabriel Munteanu" <eduard.munteanu@linux360.ro>,
	ryan@michonline.com, git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 13 23:34:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KI9Cn-0002t7-FT
	for gcvg-git-2@gmane.org; Sun, 13 Jul 2008 23:34:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752909AbYGMVdF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jul 2008 17:33:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755496AbYGMVdE
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Jul 2008 17:33:04 -0400
Received: from yw-out-2324.google.com ([74.125.46.31]:3133 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755814AbYGMVdB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jul 2008 17:33:01 -0400
Received: by yw-out-2324.google.com with SMTP id 9so2275080ywe.1
        for <git@vger.kernel.org>; Sun, 13 Jul 2008 14:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=CSrCZDZD7xv0pmwQqZGnbEoRTjGlMSSnlrlGICqvLTI=;
        b=O9YAz9k0NUSbvX9guliuNFdDzsJt5AWXhjufdv9EsokXHRKo0Tl0GCEs2QkbgbIT6g
         wv1gPvrK/6kHvybeLUNuBtNTdfM5cEWh3QvzNrejLYeqskwZXgl/BeWqrujlFIjUPh9H
         Sh7l8ePTOQuY+M2raIWhCyArCuPC9EWTwLF2Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=rh7jI80rX/aAhXAGPM8Mqdv98t/Mgz8aNWQsLdYI9hPy+UP/q6C4x5GkH5qR+/BY3V
         6E9v9QsmD3nPu+sEe9wuBo5JkDqylNOat3oEpBKaDfOffH3Yw0k1sKweDM/oOMKb0eiR
         npbdOJrtSJltnk8LFuR9oBUaIrcvX+sXSdJc4=
Received: by 10.150.95.5 with SMTP id s5mr19137767ybb.246.1215984777063;
        Sun, 13 Jul 2008 14:32:57 -0700 (PDT)
Received: by 10.150.98.19 with HTTP; Sun, 13 Jul 2008 14:32:57 -0700 (PDT)
In-Reply-To: <7vskudr11m.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88340>

On 7/13/08, Junio C Hamano <gitster@pobox.com> wrote:
> Eduard - Gabriel Munteanu <eduard.munteanu@linux360.ro> writes:
>  > +     } elsif (defined $export_file) {
>  > +             my $mbox_from = "From $raw_from $date";
>  > +             $message =~ s/^(>{0,})From/>$1From/m;
>  > +             print $out "$mbox_from\n$header\n$message";
>
> Sorry, but I am scratching my head here.  Shouldn't this "bare From
>  munging" be like this instead?
>
>                 $message =~ s/^From />From /m;

That wouldn't be a reversible operation.

Have fun,

Avery
