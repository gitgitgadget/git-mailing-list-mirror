From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <sbejar@gmail.com>
Subject: Re: [PATCH] user.default: New config to prevent using the default values for user.*
Date: Wed, 5 Mar 2008 21:41:33 +0100
Message-ID: <8aa486160803051241y33b69938p6eb68784641672a1@mail.gmail.com>
References: <1204744684-2043-1-git-send-email-sbejar@gmail.com>
	 <alpine.LNX.1.00.0803051516300.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Daniel Barkalow" <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Mar 05 21:42:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JX0RM-0008SP-N1
	for gcvg-git-2@gmane.org; Wed, 05 Mar 2008 21:42:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758228AbYCEUli convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 5 Mar 2008 15:41:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757963AbYCEUlh
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Mar 2008 15:41:37 -0500
Received: from ti-out-0910.google.com ([209.85.142.186]:34906 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757358AbYCEUlg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Mar 2008 15:41:36 -0500
Received: by ti-out-0910.google.com with SMTP id 28so2143758tif.23
        for <git@vger.kernel.org>; Wed, 05 Mar 2008 12:41:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=GKYJmaogRCmm6DwmED+Q8Fb2KM48x23aBhQSSXMl64c=;
        b=xySG9m1t1quEt4cAev+6pHwhQy5k2maOF4rryAM4cJrEBYztX+p8zfq+je7xhOINJy79Oq4ZzilMYL7Zwkj3vGDt0bdNllqr5XNh5oHQy8bm+CAH51DXAaEV1WONYWie1LRx3sUCDYl2PvlwOEpMtvgl9/y7POpKpmCd3docgv8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Ob051dFtVoQbS9vAKxFeA2d0KgfZiQefUJx1vcno47bkgbtdEqeLE9T23ugI5MncsFs+T8GPXlAMKv+OucQYCLkiouiWrOtGvXAe1tYt7Qb4b3G4GGr1mq0QDKJbzJstfcA/RAOkbI4xKq+THhTTihQUIygrziXQM+f9vTlFuCg=
Received: by 10.150.152.17 with SMTP id z17mr1458134ybd.37.1204749693317;
        Wed, 05 Mar 2008 12:41:33 -0800 (PST)
Received: by 10.150.199.9 with HTTP; Wed, 5 Mar 2008 12:41:33 -0800 (PST)
In-Reply-To: <alpine.LNX.1.00.0803051516300.19665@iabervon.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76261>

On Wed, Mar 5, 2008 at 9:21 PM, Daniel Barkalow <barkalow@iabervon.org>=
 wrote:
> On Wed, 5 Mar 2008, Santi B=E9jar wrote:
>
>
> > Useful when you want a different email/name for each repository
>
>  I still think it would be more intuitive if you made it so that sett=
ing
>  user.* to nothing was not an error, suppressed picking values up fro=
m the
>  system, and led (if not overridden again) to the message telling you=
 how
>  to set them. Is there some reason you decided not to have that be ho=
w the
>  user triggers this behavior?

I first tried this way, but when I was writing the documentation I
found it more clean and easy if it was a separate config.

Santi
