From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [RFC PATCH 0/8] Git remote helpers to implement smart transports.
Date: Tue, 1 Dec 2009 17:12:16 +0100
Message-ID: <fabb9a1e0912010812t4de8027dj1faf828051d1adc2@mail.gmail.com>
References: <1259675838-14692-1-git-send-email-ilari.liusvaara@elisanet.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Tue Dec 01 17:14:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFVLJ-0001km-Jp
	for gcvg-git-2@lo.gmane.org; Tue, 01 Dec 2009 17:12:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754177AbZLAQMd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Dec 2009 11:12:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754173AbZLAQMd
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Dec 2009 11:12:33 -0500
Received: from mail-vw0-f197.google.com ([209.85.212.197]:59537 "EHLO
	mail-vw0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754112AbZLAQMb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Dec 2009 11:12:31 -0500
Received: by vws35 with SMTP id 35so1572254vws.4
        for <git@vger.kernel.org>; Tue, 01 Dec 2009 08:12:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=JuwhrJYSPM9E0Uy1TPSRyE2v9h/eov9WQGWnZZhVMNk=;
        b=xWp3miFWdUaNKcXmKK3nQNwZCWP+aSZTUfS+3KdmM9YDn2pKFi6Xb+kZwLekw0ZZ0J
         tu0ZZd0owYGaqeLq5wdXdhNd/pbv0YzWUzkKae3aWWscQiekycFFbzno1ZJ4y+R4nqAD
         9GUNFKjwKhhDqMJpg24tp9FscyK7XaogcnNYI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=e1EUBeS7Z2A2QCdhaww/80klXqw8XLWNBRFTLQThLFNBuMWBZ+o+emjp5UVE7sVs8n
         TZId0/bgLhQUmLlAo1/eSkitU0cDtE2wcMcCzazFxdgdiraDPSPm5LnFH1CzsHVRm9xm
         xFBWKgg16fskagvdXAK5XKpEFUgLO66/YpjLg=
Received: by 10.220.125.106 with SMTP id x42mr7235125vcr.44.1259683956099; 
	Tue, 01 Dec 2009 08:12:36 -0800 (PST)
In-Reply-To: <1259675838-14692-1-git-send-email-ilari.liusvaara@elisanet.fi>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134219>

Heya,

On Tue, Dec 1, 2009 at 14:57, Ilari Liusvaara
<ilari.liusvaara@elisanet.fi> wrote:
> This series implements extensions to remote helpers for carrying smary
> transports. It is against next, because master doesn't contain necressary
> patches (the allow specifying remote helper in url one).

Could you please explain how this relates to Shawn's smart http series
and the sr/vcs-helper series?

-- 
Cheers,

Sverre Rabbelier
