From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [PATCH] Teach 'git-apply --whitespace=strip' to remove empty lines at the end of file
Date: Sun, 20 May 2007 12:34:06 +0200
Message-ID: <e5bfff550705200334pef694cn1a7842c23e2672f5@mail.gmail.com>
References: <e5bfff550705200251j3dd9b377je7ae5bafac988060@mail.gmail.com>
	 <7vabvzq0bb.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun May 20 12:34:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hpijs-0006rE-Bv
	for gcvg-git@gmane.org; Sun, 20 May 2007 12:34:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755864AbXETKeI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 May 2007 06:34:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755865AbXETKeI
	(ORCPT <rfc822;git-outgoing>); Sun, 20 May 2007 06:34:08 -0400
Received: from nz-out-0506.google.com ([64.233.162.228]:5625 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755864AbXETKeH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 May 2007 06:34:07 -0400
Received: by nz-out-0506.google.com with SMTP id z3so29290nzf
        for <git@vger.kernel.org>; Sun, 20 May 2007 03:34:06 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=e/QGUxJRj5tUt0MlktnJv11cAoEpHtPOCEqNVmdfB0KggavcXPvqglthoswAosrwZ29Oj7UtQ5VXFiZhP0tIv6Nx9RZrSoseWPaTTHUy2hI464Gp5vDNYRvlClzRhN1pdwQ/pVXJpQq5uXocd/WAukPOdQ9CsaHBnON12v14HZk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gGvFtHrcoev0Loo0A67B7dhltel2Be1D58jrPNK644MbD3KNkqL7FCQYZwX8PbAdYzE4JPZEeMXkY3iBaGkHmHb2m8pu7cQXRTKRXogoV8agsGrsWAzJz3dkl5gWt1MchKVF5nvdAaYtf6wNWZLKTep+S4peK9ybGTCwr6vPvPs=
Received: by 10.115.18.1 with SMTP id v1mr1972654wai.1179657246287;
        Sun, 20 May 2007 03:34:06 -0700 (PDT)
Received: by 10.114.61.9 with HTTP; Sun, 20 May 2007 03:34:06 -0700 (PDT)
In-Reply-To: <7vabvzq0bb.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47822>

On 5/20/07, Junio C Hamano <junkio@cox.net> wrote:
> "Marco Costalba" <mcostalba@gmail.com> writes:
>
> > Signed-off-by: Marco Costalba <mcostalba@gmail.com>
> > ---
> >
> > This one seems to pass all the tests.
>
> I think this happens to work because you are not feeding -u0
> patch; if you have more than one context, then a hunk that ends
> with + line is guaranteed to apply only at the end,  With a
> diff prepared with -u0, that is not true anymore, is it?
>

I don't know much about this -u0 thing, could you please point me to
an example so I can try to fix also this case?

Thanks
Marco
