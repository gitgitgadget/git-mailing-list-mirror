From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [RFC PATCH v2 3/3] Implement unstage --patch and discard --patch
Date: Fri, 24 Jul 2009 20:08:54 +0200
Message-ID: <36ca99e90907241108h78881239o403f50773764bd43@mail.gmail.com>
References: <2d756f643fc7d1b50cf590c95467fa029b49ff46.1248426652.git.trast@student.ethz.ch>
	 <9cad6176fe941bd56bad7fed49cc55a96a7040ae.1248452530.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Pierre Habouzit <madcoder@debian.org>, jnareb@gmail.com
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Fri Jul 24 20:09:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUPCb-0001EH-Jy
	for gcvg-git-2@gmane.org; Fri, 24 Jul 2009 20:09:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753751AbZGXSI4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 24 Jul 2009 14:08:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753734AbZGXSI4
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Jul 2009 14:08:56 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:45836 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753723AbZGXSIz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Jul 2009 14:08:55 -0400
Received: by fxm18 with SMTP id 18so1584085fxm.37
        for <git@vger.kernel.org>; Fri, 24 Jul 2009 11:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=eROwxPzsWH2710FIzhW3a4T/HHvfMd397BN2yEXBdVg=;
        b=Op+4bbZjQ+cDt+VbTXlMx4d7TIMxFjkQc/FJbFelBrFyQD5NmnN58ZAPOoG+AVbLpL
         FYc8EY8wvV8XPuTCqqonTmyWqCTQdNQ84dbQFCGb2SBVQHbquHtdrK9nI2oknWpmWafo
         wVSWZsewFd1oaAyBj1ASUnaNzjBiFX2LotKV8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=jNsxe3zz7Z1fa5F9Qdt9aa+b9JJ1qvSd4UWnJlfEbIL7G6rEvAFZc98s7Sbn74Z59p
         H4fTPbm0ODxM8k4YqCTjKGJpSVihPAondztTaONQbQvoUowdWsTY+IkqiMwbIQXkiYVz
         4WCf36kDA9W3AC+DbCEHf44jwVFvHhX3AKMvc=
Received: by 10.223.113.68 with SMTP id z4mr1881195fap.72.1248458934963; Fri, 
	24 Jul 2009 11:08:54 -0700 (PDT)
In-Reply-To: <9cad6176fe941bd56bad7fed49cc55a96a7040ae.1248452530.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123936>

On Fri, Jul 24, 2009 at 18:24, Thomas Rast<trast@student.ethz.ch> wrote=
:
> 'discard': offer hunks from 'git diff', and discard (i.e., undo the
> =C2=A0edit in the working tree) the ones selected.
Great, I really miss this feature in git-gui, maybe its easy to add
this there too. I may look into this by my self, but not this weekend.

Bert
