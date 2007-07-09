From: "Matt McCutchen" <hashproduct@gmail.com>
Subject: Re: [PATCH] gitweb: snapshot cleanups & support for offering multiple formats
Date: Mon, 9 Jul 2007 18:52:56 -0400
Message-ID: <3bbc18d20707091552l29fb81b6v34da9cef3ec0df58@mail.gmail.com>
References: <1183053733.6108.0.camel@mattlaptop2>
	 <7v1wfi1rz6.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 10 00:53:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I826H-0005mk-IJ
	for gcvg-git@gmane.org; Tue, 10 Jul 2007 00:53:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754478AbXGIWw6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Jul 2007 18:52:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756551AbXGIWw6
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jul 2007 18:52:58 -0400
Received: from nz-out-0506.google.com ([64.233.162.231]:62496 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754375AbXGIWw5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jul 2007 18:52:57 -0400
Received: by nz-out-0506.google.com with SMTP id s18so826551nze
        for <git@vger.kernel.org>; Mon, 09 Jul 2007 15:52:56 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LPptScOyIx9yvoJHvrY3ip+rQSmdHF5wYspbhh5sGhe3VzL14sKVaXQuR2AvOR7znWGno/GmVZNMHTjqYiZi68B0CYDHMtxdVMmZJFe5WKPunU7kqImmXnPgZ8CZMjorFa91pi3RpPxupY6Bo+XYgkQZ887zZ9+7nPz3giTuQcA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Y8BOCczhww+mjP3XKx/MPon06uKZAJ7fe2D7j+f+/qsECJcsRLW+ghr3fUwMyiU169MWw3hjtNNQFgq4qGFeWWZbn18kf04sVTsyMxqBb2+7UBObhpChUdMo1glduUz/TrosfdwhnDWpDemhNSLzbD6b3q7vu6XWrqM6bSOom6I=
Received: by 10.142.106.18 with SMTP id e18mr266907wfc.1184021576217;
        Mon, 09 Jul 2007 15:52:56 -0700 (PDT)
Received: by 10.143.30.9 with HTTP; Mon, 9 Jul 2007 15:52:56 -0700 (PDT)
In-Reply-To: <7v1wfi1rz6.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52023>

On 7/8/07, Junio C Hamano <gitster@pobox.com> wrote:
> Matt McCutchen <hashproduct@gmail.com> writes:
>
> > -sub gitweb_have_snapshot {
> > -     my ($ctype, $suffix, $command) = gitweb_check_feature('snapshot');
> > -     my $have_snapshot = (defined $ctype && defined $suffix);
> > -
> > -     return $have_snapshot;
>
> Although you are removing this function, you still have a couple
> of callers left in the code.

OK, I will revise the patch, submit it and see if I can get it to
appear as a reply to this thread.  Incidentally, when only one format
is offered, would you prefer the snapshot link to appear as
"_snapshot_" (the same as before) or "_snapshot (tgz)_" instead of the
"snapshot (_tgz_)" that the current patch does?

Matt
