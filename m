From: "Bert Wesarg" <bert.wesarg@googlemail.com>
Subject: Re: format-patch --cc and send-mail --s-o-b-cc don't play nice together
Date: Wed, 30 Apr 2008 00:11:18 +0200
Message-ID: <36ca99e90804291511m619c8373j5e79edab2e57f644@mail.gmail.com>
References: <36ca99e90804290657k88710eer630898d837659f37@mail.gmail.com>
	 <7v8wyw7349.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>,
	"Daniel Barkalow" <barkalow@iabervon.org>,
	"Ryan Anderson" <ryan@michonline.com>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 30 00:12:42 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jqy41-00053a-3r
	for gcvg-git-2@gmane.org; Wed, 30 Apr 2008 00:12:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760683AbYD2WLY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2008 18:11:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760673AbYD2WLX
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Apr 2008 18:11:23 -0400
Received: from wx-out-0506.google.com ([66.249.82.226]:64019 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760635AbYD2WLW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2008 18:11:22 -0400
Received: by wx-out-0506.google.com with SMTP id h31so209901wxd.4
        for <git@vger.kernel.org>; Tue, 29 Apr 2008 15:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=n+3WtSSbV5lSjRo4i3HV2QRklQaTItAh41rDqiDTnZo=;
        b=XOKmcoy1PCgCqXOTSTTfB50zoGDnjYxMpsl18X2HxLcS8heZUp3Vu4mdgzqVQtz01vMO656tTi57epYAWKopznX6lw8eUGHVNlidUEMqYxwKz0deMd130/nGSvgHQdYrWY/OhWddzFXxpo5F1Jz8/aKLrA3Ggjr+z+0/g+LLWWQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=CkZSMAm+wR7gfVfaG7I0wwAHEPuQJmYTaxsrxi6kDr/54Gs5rh0g8qFZTiVoUYTULiv6mXirJ4lgpccCX1WMXxHUOa4zht9goCV6Pl1iqlU8Ci8uHqMRV/2e7XwKfTdOEJS8ykcqeM5EM2gPAITjmzGaKXTwJogLwR01fy9gh18=
Received: by 10.70.118.4 with SMTP id q4mr12234106wxc.9.1209507078708;
        Tue, 29 Apr 2008 15:11:18 -0700 (PDT)
Received: by 10.70.31.15 with HTTP; Tue, 29 Apr 2008 15:11:18 -0700 (PDT)
In-Reply-To: <7v8wyw7349.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80756>

On Tue, Apr 29, 2008 at 11:39 PM, Junio C Hamano <gitster@pobox.com> wrote:
> "Bert Wesarg" <bert.wesarg@googlemail.com> writes:
>
>  > the --cc option from format-patch adds a Cc: header to the mail where
>  > multiple recipients are put into a new line, separated by commas.
>
>  I am not sure if --cc ever made sense to be given to format-patch.  It is
>  not a tool to send e-mails, which send-email is.
AFAIK, this option is not in the master branch.

>
>  > Unfortunately send-mail with the --signed-off-by-cc option can't parse
>  > these lines.
>
>  Isn't --signed-off-by-cc a completely unrelated feature, where it gives
>  carbon copies to people who signed off the patch?  Why does the option
>  need to read from existing CC: header of the material the command is told
>  to send out?
No, it scans Cc: lines (header and body) too and add these to the cc
list (in the body since abec100c3382f7d7b759f915a86e9773277263b6).

Bert
