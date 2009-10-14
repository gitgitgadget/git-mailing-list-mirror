From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 1/6] Open the pack file and keep a map on it.
Date: Wed, 14 Oct 2009 07:48:51 -0500
Message-ID: <fabb9a1e0910140548g2ad99ec4ia0f4cd4cb6fc409c@mail.gmail.com>
References: <1255516669-26745-1-git-send-email-herve@itaapy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: =?ISO-8859-1?Q?Herv=E9_Cauwelier?= <herve@itaapy.com>
X-From: git-owner@vger.kernel.org Wed Oct 14 14:50:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1My3JI-0000yT-7L
	for gcvg-git-2@lo.gmane.org; Wed, 14 Oct 2009 14:50:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759575AbZJNMtu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Oct 2009 08:49:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755123AbZJNMtu
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Oct 2009 08:49:50 -0400
Received: from mail-ew0-f208.google.com ([209.85.219.208]:57346 "EHLO
	mail-ew0-f208.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754860AbZJNMtt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Oct 2009 08:49:49 -0400
Received: by ewy4 with SMTP id 4so4373151ewy.37
        for <git@vger.kernel.org>; Wed, 14 Oct 2009 05:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=w2CP7Iv7c/Z3pa+yPAcWZniHz8XML+tRL7TSTxnJw/k=;
        b=XQvTP+S4NZUUyoY+4Ad7minm6U0BPUIYmXhQeYsoAZyBIaVMNAlSjLTISSKY6BkxXY
         ap+yKM+o5p2dCWZomuPZESObHZo0MujxRqdFmX97gSW5x3L+o2nhJ+emupCZZzPmm7Cw
         a00sV3JsUkFBPWBtMMq+MhlnuQOdfPmi/aV4Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=d5RmMt6R48wS/hcEiXN9N33G8cG8XgUTLm6Lc7V43xAFa9or8XfYK97fAT4dOptywR
         cZyIjqQFQjj3at0P2zYkpskJ4J5XotdStAyNDeyJ3zp2uuewOA2SCXgmTfTbgLXaUAts
         Cp3dxx0/wCtcUQnBM6epVkkzisUEVPqT2MDLo=
Received: by 10.216.86.72 with SMTP id v50mr2759831wee.184.1255524551279; Wed, 
	14 Oct 2009 05:49:11 -0700 (PDT)
In-Reply-To: <1255516669-26745-1-git-send-email-herve@itaapy.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130286>

Heya,

2009/10/14 Herv=E9 Cauwelier <herve@itaapy.com>:

Please include a cover letter for series as long as these (anything
larger than 4 should have a cover letter IMHO). Doing so makes it
easier for those that follow the series to see what changed (assuming
you write down what changed in the cover letter). Also, it makes it
easier for those that were not following the series to drop in at the
current version (assuming you provide a short summary of what the
series is about in the cover letter).

--=20
Cheers,

Sverre Rabbelier
