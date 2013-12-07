From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v2 09/10] builtin/replace: unset read_replace_refs
Date: Sat, 7 Dec 2013 20:37:34 +0100
Message-ID: <CAP8UFD2XbxYDEevYGOwWJrqg6k=UYoCWn6gPONizrKuKOWf=qw@mail.gmail.com>
References: <20131207160514.21478.72966.chriscool@tuxfamily.org>
	<20131207162106.21478.98950.chriscool@tuxfamily.org>
	<loom.20131207T200130-598@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git <git@vger.kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 07 20:37:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VpNh6-0006YD-7U
	for gcvg-git-2@plane.gmane.org; Sat, 07 Dec 2013 20:37:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758698Ab3LGThg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Dec 2013 14:37:36 -0500
Received: from mail-vc0-f175.google.com ([209.85.220.175]:64741 "EHLO
	mail-vc0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755738Ab3LGThf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Dec 2013 14:37:35 -0500
Received: by mail-vc0-f175.google.com with SMTP id ld13so2080520vcb.20
        for <git@vger.kernel.org>; Sat, 07 Dec 2013 11:37:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=EzQWE3664HxjNg8u3bZ5bHR3R1ehy7mfJFg6xfw061c=;
        b=Hw2mmwbxPH1hQsu+Agb5MDc6DfCLQf2CZb7VNM79U6DJlpPfW/aD/wRgS15HQ2mkI1
         ealINsgdozdAViwpWRaoy4YkkIzLqC0vOsvZsUPWkAC2J4Fgh+kfRCqwXyZMPP/eSp4A
         a3jruhf9dtVtVrYyu3h2MLf83pOIVwWmhCc6nW98qCE88P6vFnHyjJNYoRAqzthxxK9U
         iIv3GDn+s8+9gTrjMpkgfC++70fzdj4mW3dxesLNSbiOnAhQZ1vqMFIAO8TkKj4ODhLJ
         NmnJvEQ7YMWcZ6K/gGsYof+pa1M2W9aGwkKGIkMEYwsn76q1GKaQlXmiQp4TH6WbVLng
         T2bA==
X-Received: by 10.52.98.99 with SMTP id eh3mr5345311vdb.29.1386445054791; Sat,
 07 Dec 2013 11:37:34 -0800 (PST)
Received: by 10.58.253.136 with HTTP; Sat, 7 Dec 2013 11:37:34 -0800 (PST)
In-Reply-To: <loom.20131207T200130-598@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239015>

On Sat, Dec 7, 2013 at 8:02 PM, Jakub Narebski <jnareb@gmail.com> wrote:
>
> Wasn't replace mechanism tightened, so that replacing object
> must be the same type as replaced object?

Yes, but if --force is used or if the replace ref is created with git
update-ref, then it is not enforced.

> Is there a situation where you might want replace object
> with different type of object?

This was discussed:

http://thread.gmane.org/gmane.comp.version-control.git/233157/

Thanks,
Christian.
