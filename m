From: "Mike Ralphson" <mike.ralphson@gmail.com>
Subject: Re: [PATCH] Makefile: update the default build options for AIX
Date: Wed, 7 May 2008 14:05:25 +0100
Message-ID: <e2b179460805070605t71bed59eq8dc64e204623fd18@mail.gmail.com>
References: <1210149355875-git-send-email-mike@abacus.co.uk>
	 <4821992F.4060201@viscovery.net>
	 <e2b179460805070551x7a0072e0w4d406ef4112849ce@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org,
	"Brandon Casey" <casey@nrlssc.navy.mil>
To: "Johannes Sixt" <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed May 07 15:07:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JtjLd-00073G-23
	for gcvg-git-2@gmane.org; Wed, 07 May 2008 15:06:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752132AbYEGNF1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2008 09:05:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752138AbYEGNF1
	(ORCPT <rfc822;git-outgoing>); Wed, 7 May 2008 09:05:27 -0400
Received: from rv-out-0506.google.com ([209.85.198.236]:30759 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752126AbYEGNFZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2008 09:05:25 -0400
Received: by rv-out-0506.google.com with SMTP id l9so355970rvb.1
        for <git@vger.kernel.org>; Wed, 07 May 2008 06:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=ve1SiKPU/+uozheWa/+cCI11flIQu9v6g65phEv04uU=;
        b=vU3/1retK+klCDYcVH6kbue6j0DfCKTfVcNMEUYGokfDKEasSld71DHikpAv27Xswi0T/r33Wx1FU8RhaR1xh32q1vPO5n3B5kmHlA2hMHfqyJxQardsiPQnfn2S8p1VOhbO4qCfmbhyf87CWohxTiY+kT8ALXgP/grg+WNLaWc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FJHaxOrittQFUudta7U1rjngRo3VJ6+E6EcMAORl3hVQk+EfdoHckwexdQua24yEPyzZv+KDBQk9jXGsweQrzO9XBpp+fJD1bSCl4+uTL3iuE2ShwtIZwy2o0Qad4q5trRB7QNuAW/tQ83ssWgoJIcHoZtVDnktfAcHrGQG7Tx0=
Received: by 10.141.96.21 with SMTP id y21mr946627rvl.132.1210165525040;
        Wed, 07 May 2008 06:05:25 -0700 (PDT)
Received: by 10.140.142.5 with HTTP; Wed, 7 May 2008 06:05:25 -0700 (PDT)
In-Reply-To: <e2b179460805070551x7a0072e0w4d406ef4112849ce@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81434>

2008/5/7 Mike Ralphson <mike.ralphson@gmail.com>:
> 2008/5/7 Johannes Sixt <j.sixt@viscovery.net>:
>  >
>  >  Did you also get this warning? Is _LARGE_FILES support solved in a
>  >  different way on 5.3?
>
>  I don't believe it's anything to do with _LARGE_FILES. Could you try
>  building first with one commented out, then the other? I don't think I
>  have access to a 4.3.3 box any more.

I'm full of it (and I didn't try my own suggestion). It does appear to
be related to defining _LARGE_FILES.

I'm afraid I can't see how the current #undef is working, let alone
suggest how to fix it when fopen is already redefined. 8-(

Mike
