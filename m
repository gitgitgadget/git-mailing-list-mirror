From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH 5/5] remote: use exact HEAD lookup if it is available
Date: Sun, 15 Feb 2009 10:22:02 -0500
Message-ID: <76718490902150722p3cd4f98ay192df5136300d2d3@mail.gmail.com>
References: <20090215060815.GA7473@coredump.intra.peff.net>
	 <20090215061818.GE30414@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Daniel Barkalow <barkalow@iabervon.org>
To: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 15 16:23:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYiqD-0005yR-Ra
	for gcvg-git-2@gmane.org; Sun, 15 Feb 2009 16:23:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752449AbZBOPWH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Feb 2009 10:22:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751372AbZBOPWF
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Feb 2009 10:22:05 -0500
Received: from rv-out-0506.google.com ([209.85.198.226]:60367 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751229AbZBOPWD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Feb 2009 10:22:03 -0500
Received: by rv-out-0506.google.com with SMTP id g37so1233725rvb.1
        for <git@vger.kernel.org>; Sun, 15 Feb 2009 07:22:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=1FkRhuE3sOAy/R/1/uC+LBUVAREuMQhvOair6aadD7A=;
        b=Bv3dbaD1FwE9fEhuG6GGfbdwkcmW1brzV34hYAGDsPE3qSGAEfSHIJ6f5Qx4lOh8fc
         f3AOCSm7VfkXj8JiWK1cOIuzQU0fjKTQxsuz/fBFG4HA4qlBPAEed+jGUE2cuvmvFWJB
         Zpu2OAhMbuAGiJVabUX7p7MPf5+Y1YO7EtPwg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=WIdldGbanj4NrO8AdoAeUyr7U1ZNtkZreAQdTUgMGxqyc1gYQGkYvF7SomT7kYDM8l
         lPqov9ObXRSm/xvs5zLvICw0z6I2SxyyNeMh4fgxNElv1ju1MqiPA8mLyAeH56YdXXr2
         2tj7gAlbqjnpsn1RXnG+OM4RmxudtGX44f1D8=
Received: by 10.140.136.5 with SMTP id j5mr2185390rvd.167.1234711322807; Sun, 
	15 Feb 2009 07:22:02 -0800 (PST)
In-Reply-To: <20090215061818.GE30414@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110017>

On Sun, Feb 15, 2009 at 1:18 AM, Jeff King <peff@peff.net> wrote:
> A possible 6/5 would be to do something similar for local repos (or
> resurrecting the HEAD proposal).

http://thread.gmane.org/gmane.comp.version-control.git/102039

I read that thread, and it wasn't clear to me why it died. Was there a
v3 patch round that I cannot find?  The only unaddressed reply I see
is from Jeff:

http://thread.gmane.org/gmane.comp.version-control.git/102039

But that seems tangential to the proposal.

j.
