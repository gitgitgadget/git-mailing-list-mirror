From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: Showing whitespace on minus lines of diff ouput
Date: Thu, 4 Feb 2010 21:08:34 -0500
Message-ID: <76718491002041808r6fcbf88egd1e9ce4927eb36c0@mail.gmail.com>
References: <76718491002041747t327bf2f5l85e095244f6ee1ed@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Feb 05 03:13:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NdDgp-0002CD-9k
	for gcvg-git-2@lo.gmane.org; Fri, 05 Feb 2010 03:12:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756526Ab0BECIg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Feb 2010 21:08:36 -0500
Received: from mail-iw0-f189.google.com ([209.85.223.189]:40683 "EHLO
	mail-iw0-f189.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754839Ab0BECIf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2010 21:08:35 -0500
Received: by iwn27 with SMTP id 27so446755iwn.5
        for <git@vger.kernel.org>; Thu, 04 Feb 2010 18:08:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type;
        bh=4a7e3klEqiCpgzCZJDnUfEviJj7raZKFNqi1Q2mFUrI=;
        b=BTJB1JQKrOBsu+iCVR7HZfAPc9p4siSgPGjHPmuHFq75Dzu3D8hw1lz26W9RRLsBO/
         fUZOiZL2CxC9gCsY5MVyvQjMl/8fz6KVb/vVjk+DpcIBkBT9/kNq3FsqRZe5q4APgpee
         xK4FSQ1fF3jETjjQdbb/axNO5fyQYpTuQycrY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        b=U6PcNsceD8aIxK5TMOzajlZbmY4Jo5TRI3tQqU2CriV1V45gyhmi5eZh/6mChKs94l
         hsv5yHz7PRVRvOYF/6S++qSCSQMJeQ7ZbIr0tPrbxTQPW/Hu31qUzvPVbM0MqluHneZh
         aEMXIjU6zU6hgQX0QItFBOdgEi3AuOy12Q2zs=
Received: by 10.231.146.8 with SMTP id f8mr1572562ibv.58.1265335714573; Thu, 
	04 Feb 2010 18:08:34 -0800 (PST)
In-Reply-To: <76718491002041747t327bf2f5l85e095244f6ee1ed@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139021>

On Thu, Feb 4, 2010 at 8:47 PM, Jay Soffian <jaysoffian@gmail.com> wrote:
> I'm looking at diff.c, but wow. Can someone more familiar with this
> file point me toward how I'd make a patch to colorize whitespace on
> '-' lines as well?

Ah, got it. I think. Patch shortly. :-)

j.
