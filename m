From: "Carlos Rica" <jasampler@gmail.com>
Subject: Re: [PATCH 2/2] tweak manpage formatting
Date: Fri, 10 Aug 2007 21:16:14 +0200
Message-ID: <1b46aba20708101216s7660741ds5ef4c4c0fd13b45c@mail.gmail.com>
References: <7vbqdfvng9.fsf@assigned-by-dhcp.cox.net>
	 <0F764326-63E8-447D-A2D4-E56E999775D7@silverinsanity.com>
	 <7v3ayrtil5.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Brian Gernhardt" <benji@silverinsanity.com>, git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 10 21:16:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJZyH-000550-Fh
	for gcvg-git@gmane.org; Fri, 10 Aug 2007 21:16:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936178AbXHJTQR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Aug 2007 15:16:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756531AbXHJTQQ
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Aug 2007 15:16:16 -0400
Received: from wa-out-1112.google.com ([209.85.146.180]:44461 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932345AbXHJTQP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Aug 2007 15:16:15 -0400
Received: by wa-out-1112.google.com with SMTP id v27so994332wah
        for <git@vger.kernel.org>; Fri, 10 Aug 2007 12:16:14 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=nLaPkW0xcb8dCBWS9WBahp+BZiRw+czkZbaSkCW34LnnMKcT8A+TsAXUAdzAMEbxP0Ubot+ZCAtKQ3uRZos8EgbbX1hF9FUhVJyVgCLhqUhe7eICT8gXNGbEytfutYM1x/pPhSFHtipRurIV/gA+DwuBaGorWobj3H1knrB7ZRE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FCQ97ozM1H0dLADAAcB8bZaRv5JxMLDCGAXQfd9RgFKjOC+yhQ9xa5DjGS4IDCcx1Le54OeWUJ4SSN2fHpkdumvGoPjXPjA4m7JJANx3QKfQwXY37vfIcrKgHVLzAai0H5D8AIRwkFKz8eVShAOyNaUq5FHz3tD9P7uo4ctKG0I=
Received: by 10.114.67.2 with SMTP id p2mr849905waa.1186773374407;
        Fri, 10 Aug 2007 12:16:14 -0700 (PDT)
Received: by 10.114.57.10 with HTTP; Fri, 10 Aug 2007 12:16:14 -0700 (PDT)
In-Reply-To: <7v3ayrtil5.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55564>

I think this was because the end-of-line backslash "\" in the ASCII
art diagram in the Documentation/git-rev-parse.txt.

I think it should be an interesting feature for asciidoc to have long \
lines broken in text version, if only would be a way to disable it.

Tried someone to escape that backslash with another backslash before
(as in "\\")?

2007/8/10, Junio C Hamano <gitster@pobox.com>:
> Thanks, I'll revert that one.
>
>
