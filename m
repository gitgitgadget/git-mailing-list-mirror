From: Scott Chacon <schacon@gmail.com>
Subject: Re: Who uses Signed-off-by and DCO?
Date: Fri, 12 Jun 2009 08:25:27 -0700
Message-ID: <d411cc4a0906120825y1ce377e7w57b18511e0684e95@mail.gmail.com>
References: <20090612084207.6117@nanako3.lavabit.com>
	 <8c9a060906120756u194b783dp4d809d7f3d6921b3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org
To: Jacob Helwig <jacob.helwig@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 12 17:25:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MF8dR-00087p-Nt
	for gcvg-git-2@gmane.org; Fri, 12 Jun 2009 17:25:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759130AbZFLPZ2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 12 Jun 2009 11:25:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759191AbZFLPZ1
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Jun 2009 11:25:27 -0400
Received: from yw-out-2324.google.com ([74.125.46.28]:33579 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752923AbZFLPZZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Jun 2009 11:25:25 -0400
Received: by yw-out-2324.google.com with SMTP id 5so1517123ywb.1
        for <git@vger.kernel.org>; Fri, 12 Jun 2009 08:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=4ZixSUtMN6Z4WXxWQ4A6B7MRuHKWJDHpIDMngROftc4=;
        b=wN9cymxV7J++eQ4e790ioGfppfLiKIldLMe8cRnpFQ5uX/AbF9Ujwt3g7FibQUgzKJ
         b4BNMokeD6bJzZsO5q2YGvQpynz8KJpN9fHc643YtEmDm6jWSx1EHPHDg4aPOhR0xehw
         LqK7IRuYyGlWZq31jUKeeghDYxptQ0mZHdQF0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=uNYRcK4TDEBLv3GQe0JGFnfrG5hSE5Ojaw1uDrCgi1b6zlEML9qaDXkj8nF3NWGA8p
         f/pUDPe9MJwGkcBmKFaA1OexSfosVJC+ugY4O+13iOw69nRpVxo0xXpnPfj/7Jx0qTXC
         xRDi6Hcvhq86H9QURIXvsnXUUCdhL1aQiqfG0=
Received: by 10.100.209.5 with SMTP id h5mr5027893ang.124.1244820327831; Fri, 
	12 Jun 2009 08:25:27 -0700 (PDT)
In-Reply-To: <8c9a060906120756u194b783dp4d809d7f3d6921b3@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121429>

Hey,

On Fri, Jun 12, 2009 at 7:56 AM, Jacob Helwig<jacob.helwig@gmail.com> w=
rote:
> GitHub uses it for the Fork Queue. =C2=A0Whenever you pull in someone=
's
> changes through the Fork Queue, it will add a SOB line for the person
> pulling in the changes. =C2=A0In this case it appears to be an "I app=
rove
> these incoming changes", instead of the DCO. =C2=A0I honestly couldn'=
t say
> how common it is for projects that aren't on GitHub to use the SOB in
> this manner, however.

It has been pointed out that this is not consistent with how other
projects used SOB - we will probably remove this feature, or at least
add a checkbox or something instead in the near future.  FYI.

Scott
