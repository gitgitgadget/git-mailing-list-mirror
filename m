From: Christian Couder <christian.couder@gmail.com>
Subject: Re: Rebase and incrementing version numbers
Date: Wed, 25 Jan 2012 11:32:08 +0100
Message-ID: <CAP8UFD0gd_-=Cc0vox-6Ts4-iBWcJG8LgmqXteXgp3qc-bX13w@mail.gmail.com>
References: <CADo4Y9jGYJasDL9m7_50aOTrOyoezdyg=vcsZhQ87Qk-1XfTUQ@mail.gmail.com>
	<CADo4Y9iKvoXhKg5pEAB+cbA7Rkfa=nF4TLu0xgcS3dnkNi_n4g@mail.gmail.com>
	<1327000803.5947.59.camel@centaur.lab.cmartin.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: mike@nahas.com, git@vger.kernel.org
To: =?ISO-8859-1?Q?Carlos_Mart=EDn_Nieto?= <cmn@elego.de>
X-From: git-owner@vger.kernel.org Wed Jan 25 11:32:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rq09L-0001WO-7m
	for gcvg-git-2@lo.gmane.org; Wed, 25 Jan 2012 11:32:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751401Ab2AYKcM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Jan 2012 05:32:12 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:34303 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751080Ab2AYKcJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Jan 2012 05:32:09 -0500
Received: by pbaa10 with SMTP id a10so2911337pba.19
        for <git@vger.kernel.org>; Wed, 25 Jan 2012 02:32:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=9Z4FhDPASNTBDIIajIBzLVoCcCFP+B6wfv8lQCiROd4=;
        b=qLrVOekRrdnm4QvPSLAZaNXTSN34NsjKmY7j/5xrDK98ecBW/z70i1VFuPIFwIv7Db
         vFf9GJ4AnGbdytoCGkAxvp58BDCM41/UgpjWKt6NfizFJlzl3swZhpv/kKiKszXSrff4
         Iys5/x9cEchCDVztCQYNUEWQBfDHL742EwlXw=
Received: by 10.68.197.73 with SMTP id is9mr13434698pbc.75.1327487528905; Wed,
 25 Jan 2012 02:32:08 -0800 (PST)
Received: by 10.142.196.10 with HTTP; Wed, 25 Jan 2012 02:32:08 -0800 (PST)
In-Reply-To: <1327000803.5947.59.camel@centaur.lab.cmartin.tk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189106>

On Thu, Jan 19, 2012 at 8:20 PM, Carlos Mart=EDn Nieto <cmn@elego.de> w=
rote:
> You could write a merge driver that detects this situation and writes=
 in
> a higher number, but it's all working around the fact that it's a rac=
e
> condition.

By "merge" driver you mean a new merge startegy?

Isn't it possible to write a script and use it with git mergetool to
automatically detect and resolve the merge conflicts resulting from
changes in these numbers?

Regards,
Christian.
