From: "Mike Ralphson" <mike.ralphson@gmail.com>
Subject: Re: [PATCH/RFC 01/10] Teach rebase interactive the mark command
Date: Thu, 10 Apr 2008 10:33:01 +0100
Message-ID: <e2b179460804100233v7b8a2feare353cb4e5f718e7@mail.gmail.com>
References: <7vabkoufzq.fsf@gitster.siamese.dyndns.org>
	 <1207785521-27742-1-git-send-email-joerg@alea.gnuu.de>
	 <1207785521-27742-2-git-send-email-joerg@alea.gnuu.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com, Johannes.Schindelin@gmx.de
To: "=?ISO-8859-1?Q?J=F6rg_Sommer?=" <joerg@alea.gnuu.de>
X-From: git-owner@vger.kernel.org Thu Apr 10 11:34:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JjtAH-0003Pf-94
	for gcvg-git-2@gmane.org; Thu, 10 Apr 2008 11:33:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752918AbYDJJdH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 Apr 2008 05:33:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752240AbYDJJdG
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Apr 2008 05:33:06 -0400
Received: from rv-out-0708.google.com ([209.85.198.245]:12487 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752171AbYDJJdE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Apr 2008 05:33:04 -0400
Received: by rv-out-0506.google.com with SMTP id k29so68938rvb.1
        for <git@vger.kernel.org>; Thu, 10 Apr 2008 02:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=p3s36Q1USAR0qO7GoI0qr8ZUxOfYphx7yVEu2CyE3aE=;
        b=YDDeN/209YdQkEjY1pxo/7UY5hBkGXVB4RmsIoz0eL9anLKuRa4LhPBUOiz+YtjXNifRP+nAAihKFnEqOekbRXKcCFzQaA6zZeW0lypMYZOiZtNu9u69z1TTAsrofFPnHi0xcY0p47fsjOSNIthtGQQLn8U4uLa0AyRABNjtrXU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=TKsE90FatF/S9VB9igTWhQoaKvs4s5N0oZE43Zu4SlXcqAfD6ZF47S9WC0u3pie3wsbawBhb8mvnJFm6G2t+xy2LjRIFOcjFpwX/hRJeLPEMxMev3ZLDbU78rfBcQ4WVLmGaXNirNBA4Rcyd/UTc98ai3pY7F5eJcdEIOy9SHZc=
Received: by 10.140.142.4 with SMTP id p4mr611598rvd.261.1207819981568;
        Thu, 10 Apr 2008 02:33:01 -0700 (PDT)
Received: by 10.140.142.5 with HTTP; Thu, 10 Apr 2008 02:33:01 -0700 (PDT)
In-Reply-To: <1207785521-27742-2-git-send-email-joerg@alea.gnuu.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79202>

On 10/04/2008, J=F6rg Sommer <joerg@alea.gnuu.de> wrote:
> This new command can be used to set symbolic marks for an commit whil=
e
>  doing a rebase. This symbolic name can later be used for merges or
>  resets.

What would be wrong with using the existing tag machinery for this inst=
ead?

Mike

PS: Apologies to anyone who got an html version of this mail.
