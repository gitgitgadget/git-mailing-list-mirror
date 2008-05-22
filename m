From: "Sverre Rabbelier" <alturin@gmail.com>
Subject: Re: [PATCH resend] perl/Makefile.PL: teach makefiles about possible old Error.pm files
Date: Thu, 22 May 2008 23:56:00 +0200
Message-ID: <bd6139dc0805221456u5fc6d9ar5e69f8318b92924@mail.gmail.com>
References: <20080517011614.GA11029@foursquare.net>
	 <20080521222150.GA29696@foursquare.net>
	 <7vzlqjz2wz.fsf@gitster.siamese.dyndns.org>
	 <20080521235647.GA21340@foursquare.net>
	 <alpine.DEB.1.00.0805221245240.30431@racer>
	 <20080522164300.GA19765@foursquare.net>
	 <7vd4new8qx.fsf@gitster.siamese.dyndns.org>
Reply-To: sverre@rabbelier.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Chris Frey" <cdfrey@foursquare.net>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 22 23:57:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JzImY-00041f-PE
	for gcvg-git-2@gmane.org; Thu, 22 May 2008 23:57:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761568AbYEVV4F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 May 2008 17:56:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760379AbYEVV4F
	(ORCPT <rfc822;git-outgoing>); Thu, 22 May 2008 17:56:05 -0400
Received: from wf-out-1314.google.com ([209.85.200.171]:5132 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760940AbYEVV4B (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 May 2008 17:56:01 -0400
Received: by wf-out-1314.google.com with SMTP id 27so234939wfd.4
        for <git@vger.kernel.org>; Thu, 22 May 2008 14:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=FXYv8w97nks8vxgTGbBrbTb3UI6+WFoEnfFsUWpsiTo=;
        b=pbIKchVPZBm/WK7sMT4yh8xJHKd2mjApySg0RJXD+UwJjk6nxX5MiwJzpAsqTj+cWoKiyDWKtesTOT8GwDey2qPuLzveKb8zCgVpkU/ECwy/ZHCStAoJeEFR1Qd7FE6eo7O9YPmpysrWF5D1ydGrvf3nzB9BGKspfnUXWEqcWAM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Y36p9C2tg3NkzK+TpBZsqkgxZtbE5HUpS7tu9cZnQgI2fqz3EYce8Iv5+Qc5NYlAm1VGMDwZUKlRymFrgeeLKxqsC6K36v72HbOWoS2C2RIcO9reO9otZ61pqDjc0R5hnANO2Sm6aTJSZp14bi/f2rTvu+H7HFfeBuEd8/q8b3s=
Received: by 10.142.214.5 with SMTP id m5mr246386wfg.342.1211493361013;
        Thu, 22 May 2008 14:56:01 -0700 (PDT)
Received: by 10.143.33.6 with HTTP; Thu, 22 May 2008 14:56:00 -0700 (PDT)
In-Reply-To: <7vd4new8qx.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82656>

On Thu, May 22, 2008 at 7:26 PM, Junio C Hamano <gitster@pobox.com> wrote:
> True, as we do not give "uninstall" target.  That's what distros are for.

Why is this though? I think there are a few distro's out there (call
them the hardcore/diehard ones) that don't use packages, instead they
rely on keeping the install dir around so that you can 'make
uninstall' later.

-- 
Cheers,

Sverre Rabbelier
