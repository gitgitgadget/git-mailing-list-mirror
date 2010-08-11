From: Petr Onderka <gsvick@gmail.com>
Subject: Re: [PATCH/RFC] Add global and system-wide gitattributes
Date: Wed, 11 Aug 2010 12:50:45 +0200
Message-ID: <AANLkTi=q-tdtaWp8O3AHyvynL97LJuy7e9HUFwfkmX3O@mail.gmail.com>
References: <1281488646-7108-1-git-send-email-gsvick@gmail.com>
	<Pine.GSO.4.63.1008111059281.1471@shipon.roxen.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: =?ISO-8859-1?Q?Henrik_Grubbstr=F6m?= <grubba@roxen.com>
X-From: git-owner@vger.kernel.org Wed Aug 11 12:50:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oj8tX-0000UE-Hn
	for gcvg-git-2@lo.gmane.org; Wed, 11 Aug 2010 12:50:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751372Ab0HKKuq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Aug 2010 06:50:46 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:49383 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751210Ab0HKKup convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Aug 2010 06:50:45 -0400
Received: by qyk7 with SMTP id 7so4493673qyk.19
        for <git@vger.kernel.org>; Wed, 11 Aug 2010 03:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=47bp9Apq55TszVkqb4qLNs3kqykl8ivGve1pCHn/rZE=;
        b=V8xICwlNgUSvjn0zf3QndG+sNzOlvRPLET4rPAQl6W3TDxaq/Bx5amAl19tP9KH841
         P5bBzQ1qCupHqxRwIzyPfrgETMDDLSg7NeuywncIrajt+mdbvKijrnGiPtjZZPOAAG+u
         sFvHUbag7P9OeIO0IPgSs01RRIrntY8Z7r2Fo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=rOqCcu0mxhYCTDsk2DmlZuh1JhwbucrN3FJgy21WDboutkXXWMfYX0iSWQmPEmaP3i
         qANtxoMfR96zK8oAc/9ji0KUNMAeEc6u7Nb8wsE7iY4+2fP4oQzU6Ei5NpdFS0y0Nw00
         ZeKx1GO/OEUPs2urh0YNWFOnQ815f08bD1VhA=
Received: by 10.229.1.203 with SMTP id 11mr9296170qcg.238.1281523845116; Wed, 
	11 Aug 2010 03:50:45 -0700 (PDT)
Received: by 10.229.28.196 with HTTP; Wed, 11 Aug 2010 03:50:45 -0700 (PDT)
In-Reply-To: <Pine.GSO.4.63.1008111059281.1471@shipon.roxen.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153225>

Hi,

>> Allow gitattributes to be set globally and system wide in ~/.giattri=
butes
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ^^
> I assume you mean "~/.gitattributes" (ie missing a 't').

Yeah.

> I'm not sure if the above priority order is the most desireable order=
, since
> the user may want to set a default attribute, and have it to be overr=
idden
> by the .gitattributes in the repositories.

I wasn't sure either. I'm assuming info/gitattributes was made with
higher priority, so that that users could override .gitattributes
without polluting their repository, so I made the new ones behave the
same way. But now that I think of it, you probably want to do that
only for a specific repository, and have defaults for all repositories
that could be overriden by local .gitattributes. I'm going to rewrite
it this way.

Petr Onderka
