From: "Felipe Balbi" <felipebalbi@users.sourceforge.net>
Subject: Re: [REGRESSION ?] git-remote "--mirror" option is not integrated in 1.5.3.7
Date: Mon, 3 Dec 2007 14:19:32 -0400
Message-ID: <31e679430712031019x75d8e180se74f09cead5bb016@mail.gmail.com>
References: <31e679430712030532p12e1f0f5x7e10bd0a1fdf9ef9@mail.gmail.com>
	 <Pine.LNX.4.64.0712031622470.27959@racer.site>
	 <7vprxnir9t.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 03 19:20:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzFtb-0008MF-6b
	for gcvg-git-2@gmane.org; Mon, 03 Dec 2007 19:19:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751380AbXLCSTf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Dec 2007 13:19:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751248AbXLCSTe
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Dec 2007 13:19:34 -0500
Received: from wa-out-1112.google.com ([209.85.146.179]:44885 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751143AbXLCSTe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Dec 2007 13:19:34 -0500
Received: by wa-out-1112.google.com with SMTP id v27so5380124wah
        for <git@vger.kernel.org>; Mon, 03 Dec 2007 10:19:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        bh=RRrXKtQ2I7Q3UBgPFaLU5OYJfgnZqI6OLS162YhJ5kY=;
        b=r1gan3ZGZyQoquh9x2K6o71HJk1K85BXzHqoDyT3VVoeNktROzVoIrEMfCN3GV+dRAl53SDfsI+kKDfg/Cp3LA2qVpVN4zqVWkauG+2MojOX/mTAIY1/DqKchN7V1U5LxFPnqna4UiTY/oFJhuaaC8sHEOLxauMhwu1+Ajt3VKw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=u4uLF+QmOqoX3FxCyUiLc5BI02Xy379HVwu8FoRLfm2BjuM1cvmcYrS2K3u59+KZizT4QaNmaGJ1fYFkojovdwXbykIF/+lpsPBYvRCWTmUojsFnNJ6nTMbN3WfM50cDPDcuaMJCQ96RIR+lmcDQVA7pjc4SrgY5XABL8tymJCI=
Received: by 10.115.111.1 with SMTP id o1mr1501157wam.1196705973019;
        Mon, 03 Dec 2007 10:19:33 -0800 (PST)
Received: by 10.114.57.4 with HTTP; Mon, 3 Dec 2007 10:19:32 -0800 (PST)
In-Reply-To: <7vprxnir9t.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
X-Google-Sender-Auth: 31cb3e85fcaf526e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66942>

On Dec 3, 2007 2:09 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> > On Mon, 3 Dec 2007, Felipe Balbi wrote:
> >
> >> I've using git-remote --mirror mode for while right now but I saw it's
> >> not integrated in v.1.5.3.7, is this on purpose? I can still get it if I
> >> compile recent git's head "36863af16e91aebc87696209f4f4780cf4c4059f".
> >
> > AFAICT there are problems with --prune.  That might be a reason that it is
> > not in 1.5.3.7 (haven't checked if that's even the case, though).
>
> That is a _NEW_ feature.  Maintenance series won't get any new features.

so it'll be only in 1.5.4 ?
ok, thanks Junio

> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>



-- 
Best Regards,

Felipe Balbi
felipebalbi@users.sourceforge.net
