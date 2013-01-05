From: Manlio Perillo <manlio.perillo@gmail.com>
Subject: Re: [PATCH v4] git-completion.bash: add support for path completion
Date: Sat, 05 Jan 2013 22:27:38 +0100
Message-ID: <50E89ACA.706@gmail.com>
References: <1356108872-5881-1-git-send-email-manlio.perillo@gmail.com> <E59706EF8DB1D147B15BECA3322E4BDC0672D1@eusaamb103.ericsson.se> <7vobh4sffw.fsf@alter.siamese.dyndns.org>,<7vehi0qh4x.fsf@alter.siamese.dyndns.org> <E59706EF8DB1D147B15BECA3322E4BDC0681FA@eusaamb103.ericsson.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	"szeder@ira.uka.de" <szeder@ira.uka.de>,
	"felipe.contreras@gmail.com" <felipe.contreras@gmail.com>
To: Marc Khouzam <marc.khouzam@ericsson.com>
X-From: git-owner@vger.kernel.org Sat Jan 05 22:28:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TrbHl-0000x3-Cs
	for gcvg-git-2@plane.gmane.org; Sat, 05 Jan 2013 22:28:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755941Ab3AEV1o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jan 2013 16:27:44 -0500
Received: from mail-we0-f173.google.com ([74.125.82.173]:55700 "EHLO
	mail-we0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755917Ab3AEV1m (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jan 2013 16:27:42 -0500
Received: by mail-we0-f173.google.com with SMTP id z2so8597383wey.18
        for <git@vger.kernel.org>; Sat, 05 Jan 2013 13:27:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        bh=1bABqtH41dc+MJ5cCIcoPwBzN2EHcpgFlC4JiEqaZtU=;
        b=xsAB/4+SnM3REFtcUmEczAIJnxh0HxYfrvWAMvdTkeuqFw5kN3oCoqVaMBkXoOMFAD
         SPfqRy8/4ygPf5DadDdzX46EWPf3Ku0XjDLCBXrROOoiFLpyNwfQBfghb9IDUfCRBsFt
         VpZ0/pi0O4p6bLNTYkI7KuSy4zSGSsDuoiLeqHCpUQS04wATSvq/ZGRZC6NOp2vPp1lb
         T/6U+oL/W8bOThxK22sflu266MY0E0fCxikW6PDTzuaSE7ieEAA7Rr12zpkvRegmLqsc
         7uIG1ZrJlxlpPIcHR6i3iITo98Laxj3IEIybd2uh70uJQEj0QhP1ZZAjMfXNc4ilqfuH
         ohdA==
X-Received: by 10.180.78.226 with SMTP id e2mr3202761wix.1.1357421261559;
        Sat, 05 Jan 2013 13:27:41 -0800 (PST)
Received: from [192.168.0.3] ([151.70.204.244])
        by mx.google.com with ESMTPS id l5sm5619251wia.10.2013.01.05.13.27.39
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 05 Jan 2013 13:27:40 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.16) Gecko/20121216 Icedove/3.0.11
In-Reply-To: <E59706EF8DB1D147B15BECA3322E4BDC0681FA@eusaamb103.ericsson.se>
X-Enigmail-Version: 1.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212728>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Il 05/01/2013 21:23, Marc Khouzam ha scritto:
> [...]
> I did further testing with your patch and found some less obvious
> issues.  I didn't debug the script myself as I'm not that familiar with
> it either, but I think the testcases below should help Manlio or
> someone else look into some regressions.
> 
> 1- Using .. or . breaks completion when after the '/':
> [...] 
> 2- Maybe related to problem 1.  Using .. breaks completion in other ways:
> [...]
> 3- Also probably related to problems 1 and 2.  Using absolute paths behaves wierdly and 
> worse than before:

Thanks for this.

I begin to suspect that this is the reason why path completion has not
been implemented by the original author of the bash completion script.

These issues seems hard to fix.

Tomorrow I will take some time to try to fix all the reported issues.

> [...]


Regards  Manlio
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlDomskACgkQscQJ24LbaUQJdwCfX0bMq3V88soqtf+xlypZ5D4f
qwAAn3bK7UlcOK+hm+u06jmT05l1aJVf
=IWap
-----END PGP SIGNATURE-----
