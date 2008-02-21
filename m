From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: msgmft segfaulting on tiger
Date: Fri, 22 Feb 2008 12:59:38 +1300
Message-ID: <46a038f90802211559w457c5460k7447ba8b38352713@mail.gmail.com>
References: <46a038f90802211553g735215c6q260ddc49ac149bb5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>,
	"=?WINDOWS-1252?Q?Basilio_Brice=96=F1o_H.?=" <bbh@tampico.org.mx>,
	gsaldana@gmail.com
X-From: git-owner@vger.kernel.org Fri Feb 22 01:00:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSLKr-0007Rw-Gx
	for gcvg-git-2@gmane.org; Fri, 22 Feb 2008 01:00:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753139AbYBUX7l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Feb 2008 18:59:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752857AbYBUX7l
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Feb 2008 18:59:41 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:62361 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751190AbYBUX7k (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Feb 2008 18:59:40 -0500
Received: by ug-out-1314.google.com with SMTP id z38so1146054ugc.16
        for <git@vger.kernel.org>; Thu, 21 Feb 2008 15:59:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=+PYrMqJ9dyXnv4U+rvxqKAb25I9NRDz3D3F6uq+6Vl4=;
        b=mPbKFZGOwJ3FsC5bBpLynpKnfhkLsKeehLDNOsipAfpITbQjmY29drY//VpXa1h5PkAq8c71skBalwVSIMzULsz+u7CaSMTT0xpUgMPzWBo+LcEUeV8OPuvobhrVR5PS7JUN0S/WaegY0L/Y4Uo7iL0Fem16XXSGu3+ppubWfe4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JQi4r2izz8wdIQ4TgQT6pqm1GdLC22ji/lpZRHYrEOG6dbyBsHWAwzLPRFwkne985Qb3PPerHRA5jm3eL301gTWBK0l32/q4vKRRx9xCIaCi2Zneak+EdcbfFChSAkOrvZWUVs/AgYcohLTtXQ6fis2m9qWMfGigV2ivlzn8IQY=
Received: by 10.66.255.7 with SMTP id c7mr1605176ugi.43.1203638378690;
        Thu, 21 Feb 2008 15:59:38 -0800 (PST)
Received: by 10.66.252.6 with HTTP; Thu, 21 Feb 2008 15:59:38 -0800 (PST)
In-Reply-To: <46a038f90802211553g735215c6q260ddc49ac149bb5@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74683>

On Fri, Feb 22, 2008 at 12:53 PM, Martin Langhoff
<martin.langhoff@gmail.com> wrote:
> Today I've debugged a compile of git 1.5.4.2 failing on OSX Tiger (on
>  Basilio's machine). The problem is during the git-gui build, in the PO
>  file handling. Apparently fmtmsg (from fink) segfaults on de.po so the
>  fix is to say

Grumble. It seems like msgfmt that fink provides actually does not
support the --tcl flag. So perhaps the right thing is to always say
NO_MSGFMT on OSX?

cheers,


m
