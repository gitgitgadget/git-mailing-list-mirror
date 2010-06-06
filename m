From: Taylor Hedberg <tmhedberg@gmail.com>
Subject: Re: Moving a branch to a different node
Date: Sun, 6 Jun 2010 18:08:58 -0400
Message-ID: <AANLkTimoPjrDNlGqu8VHGqADiH8zCIMSpMaUr7Et9MvS@mail.gmail.com>
References: <C831D94B.1D9DF%mikesol@ufl.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Mike Solomon <mikesol@ufl.edu>
X-From: git-owner@vger.kernel.org Mon Jun 07 00:09:12 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OLO1m-00046d-7j
	for gcvg-git-2@lo.gmane.org; Mon, 07 Jun 2010 00:09:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755839Ab0FFWJE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 6 Jun 2010 18:09:04 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:34228 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755363Ab0FFWJD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 Jun 2010 18:09:03 -0400
Received: by gwb15 with SMTP id 15so777949gwb.19
        for <git@vger.kernel.org>; Sun, 06 Jun 2010 15:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=/fvUSiMEvUlQAlLr4me2n7XwWs6eBg+COzoA5d5RMlE=;
        b=h/QHMAG2ud8F0i9PIzSpkf4i3StVBZWBwCUEQxFNR0yZUaxfBqKJh9xlSNVeCgDGXq
         NCrxqBpwbMbaZb8BBb7U8UDLpUstwLHk3WXtPC6CfV1WLRfOglvR1mxcHZg1ZalOE79z
         lKS9DVij6DNg8rjOL0QpkxFjouHb5owWiyLvE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=sc97HCr7Q/w1IOC8JMlf2qbvxHRzpe7kHoSWWsGtW7Vz8lzkKqjdrY2WKjDS/E+uxk
         cjIcXTsDOLcvwPzCoLPnAXloja3HWC5xAqAvRJE0P5B28yQ4H5EQCyaPNud0qguMD7G2
         m/FD22MyQkSRIgca9FSvXn4EcHfk1GmqF9AZQ=
Received: by 10.101.156.24 with SMTP id i24mr14252200ano.212.1275862138704; 
	Sun, 06 Jun 2010 15:08:58 -0700 (PDT)
Received: by 10.100.136.20 with HTTP; Sun, 6 Jun 2010 15:08:58 -0700 (PDT)
In-Reply-To: <C831D94B.1D9DF%mikesol@ufl.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148551>

I believe what you want is:

git rebase --onto master foo bar

On Sun, Jun 6, 2010 at 5:01 PM, Mike Solomon <mikesol@ufl.edu> wrote:
>
> Hey git users,
> =A0 =A0I am working on a project where I proceeded by the following s=
teps:
>
> starting from master...
> 1) create branch foo
> 2) work in foo, make some commits, then a patch named Foo
> 3) create a branch bar while in foo
> 4) work in bar, make some commits, then a patch named Bar
>
> git show-branch gives me
>
> ! [master] Hello
> =A0* [foo] Foo
> =A0! [bar] Bar
>
> I would like to make bar split off of master instead of foo so that I=
 can
> format a patch that can be applied to master (Bar) without having to =
first
> apply Foo. =A0Is there a way to do that?
>
> Thank you!
> ~Mike
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
