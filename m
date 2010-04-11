From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [RFC/PATCH v2 0/4] A new library for plumbing output
Date: Mon, 12 Apr 2010 01:35:26 +0200
Message-ID: <l2jfabb9a1e1004111635v16e4dc86g405883ca12d316b9@mail.gmail.com>
References: <20100411231824.67460.24844.julian@quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jakub Narebsk <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Raymond <esr@thyrsus.com>
To: Julian Phillips <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Mon Apr 12 01:36:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O16h8-0002o3-1v
	for gcvg-git-2@lo.gmane.org; Mon, 12 Apr 2010 01:36:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753221Ab0DKXfr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 11 Apr 2010 19:35:47 -0400
Received: from qw-out-2122.google.com ([74.125.92.27]:8100 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753092Ab0DKXfq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Apr 2010 19:35:46 -0400
Received: by qw-out-2122.google.com with SMTP id 8so1823111qwh.37
        for <git@vger.kernel.org>; Sun, 11 Apr 2010 16:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=ODynlDTsywC8xqMvBAD2SiBBDAz3WhgsjDVMCvdEH/Q=;
        b=J21pa6NxX58IL/lioU77Y6MiqwPZooMuyXnlobMkjbhf2vR4KujjRTTE/HJtgDKy8R
         M4J1VBMSTQWAzwXVwI43/0KjQUGlv+ttmfnNTBiH3KgCrB+YpE0v23CXwdf1mhrPMMy0
         xD2D5mzZf6P0SdbT0hAAdRr5X7s9a/YPtwE6Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=R5CNz0Wu+4sJoqhEzDY6iNV3a5nFdnYNYMBgK9DMDjSeEavqfv8LQkVQ/7wlIRDz1+
         9uwuSJKTOcT+LBunJJF4DguHiJc+kCLt4cCfe29ri8YK7qXWScjQZ4QbQadxAvm8uy17
         B3fP7JvtpcdH0jbSX/FJEWFOOuxg7/cMF8Rak=
Received: by 10.224.74.3 with HTTP; Sun, 11 Apr 2010 16:35:26 -0700 (PDT)
In-Reply-To: <20100411231824.67460.24844.julian@quantumfyre.co.uk>
Received: by 10.224.50.79 with SMTP id y15mr1168569qaf.7.1271028946125; Sun, 
	11 Apr 2010 16:35:46 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144699>

Heya,

On Mon, Apr 12, 2010 at 01:21, Julian Phillips <julian@quantumfyre.co.u=
k> wrote:
> Probably the biggest change from v1 is an expanded aim. =C2=A0Now the=
 output library
> is aimed at controlling _all_ plubming output. =C2=A0This series incl=
udes a patch for
> ls-tree that has all it's output going through the library, and a pat=
ch for
> status that has all the --porcelain output going through the library.

I like where this is going, a lot, especially since we don't have to
convert everything in one go, but we can do it as desired, similar to
optparsification. I still think more commands than just these two
should be converted to validate the design though, perhaps something
like 'git blame', or 'git for-each-ref'?

--=20
Cheers,

Sverre Rabbelier
