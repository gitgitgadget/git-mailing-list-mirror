From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: git equivalent to clearcase wink-in
Date: Wed, 20 Jan 2010 23:34:18 +0100
Message-ID: <fabb9a1e1001201434n1036253ds1120c2abc0d3728e@mail.gmail.com>
References: <810256.84037.qm@web45111.mail.sp1.yahoo.com> <7938b46a1001201305j499e05bg2654d634d7b26d76@mail.gmail.com> 
	<20100120211251.GA26274@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jamie Wellnitz <jwellnitz@gmail.com>,
	Richard Assal <richard_assal@yahoo.com>, git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>, Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Jan 20 23:34:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXj8N-0001TM-Nq
	for gcvg-git-2@lo.gmane.org; Wed, 20 Jan 2010 23:34:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754646Ab0ATWek (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jan 2010 17:34:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751678Ab0ATWek
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Jan 2010 17:34:40 -0500
Received: from mail-pw0-f42.google.com ([209.85.160.42]:40361 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751257Ab0ATWej (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jan 2010 17:34:39 -0500
Received: by pwj9 with SMTP id 9so3492198pwj.21
        for <git@vger.kernel.org>; Wed, 20 Jan 2010 14:34:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=I8WDIumIx4MlIWWNrtgr6VSBKgHzdiplRID5tHy8w9Q=;
        b=f9ASDe5ToTnQXzOPmMwPfX/VJ5hVJ1cDcmzfLuzxquWdTFeu/UoACbFa8lh16g1bu/
         I2j+P50qAUksMib1dyVZgpmsNMw1/W20X0Id3gf+YOWpVeNA3ebyWi74xIfMKlvdxerf
         ci5sx1jJN7mT6aRCuhthNYFQWwobXwuwlMEUE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=qcUv6CpwPpu0O58rzWU2HK2K8sUCsSLfPyx8Xw/XSDT5N3obCgbQibh0ozlPOOz2ua
         nSfhjWeXsDLveHihw+jSyjqt/N71F39wC9+cLsPYFsEh32Qb6bRQaTk264wEWknZNUPM
         Gscujyi+eZeJHoqtyvobRLZFKvQDMd5Um92Ls=
Received: by 10.142.9.8 with SMTP id 8mr403124wfi.174.1264026878129; Wed, 20 
	Jan 2010 14:34:38 -0800 (PST)
In-Reply-To: <20100120211251.GA26274@glandium.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137596>

Heya,

On Wed, Jan 20, 2010 at 22:12, Mike Hommey <mh@glandium.org> wrote:
> Surely the ccache directory could be shared on nfs or some other network
> filesystem. Or object file could be checked in, which is imho ugly, but
> should work (better to do that on a separate branch)

Ha! It could even be stored as a note on the tree object? The whole
notes business seems to be nearing a usable stage. Or maybe notes are
text-only, mhhh. Johan?

-- 
Cheers,

Sverre Rabbelier
