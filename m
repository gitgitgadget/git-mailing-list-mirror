From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: Losing branches (whee, data loss)
Date: Wed, 16 May 2007 09:10:28 +0200
Message-ID: <8c5c35580705160010s506b6f53y4209c1b541c3112a@mail.gmail.com>
References: <464A940C.3080906@garzik.org>
	 <8c5c35580705152248w254e4201w65da1e1ad229f6ee@mail.gmail.com>
	 <464A9C9B.70904@garzik.org>
	 <20070516061449.GA25273@artax.karlin.mff.cuni.cz>
	 <464AA773.3090808@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Jan Hudec" <bulb@ucw.cz>, "Git Mailing List" <git@vger.kernel.org>
To: "Jeff Garzik" <jeff@garzik.org>
X-From: git-owner@vger.kernel.org Wed May 16 09:10:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HoDee-00072a-Ba
	for gcvg-git@gmane.org; Wed, 16 May 2007 09:10:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755105AbXEPHKa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 16 May 2007 03:10:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755336AbXEPHKa
	(ORCPT <rfc822;git-outgoing>); Wed, 16 May 2007 03:10:30 -0400
Received: from wr-out-0506.google.com ([64.233.184.226]:19552 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755105AbXEPHKa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 May 2007 03:10:30 -0400
Received: by wr-out-0506.google.com with SMTP id 76so97467wra
        for <git@vger.kernel.org>; Wed, 16 May 2007 00:10:29 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qDnDtKTelfQgjgCO17/T7hs1suX/OBQ4KuaRmKkrRVd0UdFMqxoJI8ecLUt+QGv3iKoXZSdJfjJeOwsdnQh2gWr+wa0KgXR4SR8ohTpeqbuOOUijqAGzFgUTBSn0vGN8q3tNk4zmjn9aUf5QtkiDVb94gU/VUHEo39iDg7tpxUk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PGr+SUgGArea88gqI+MoDwaKUw5s7dwCma67lPDNnVew3oCC73++wAYPTcBX7moHYI/03NbVIufCEZtije/nBT15z3iwUmVns3jCi0RyBxoEjWqJIX+yK+Oqo36oXaRF3sT9oBo2D7vOz1duqc5pGkLUwsbvlBiM5cyQFexpOLw=
Received: by 10.114.155.1 with SMTP id c1mr2032440wae.1179299429062;
        Wed, 16 May 2007 00:10:29 -0700 (PDT)
Received: by 10.114.235.4 with HTTP; Wed, 16 May 2007 00:10:28 -0700 (PDT)
In-Reply-To: <464AA773.3090808@garzik.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47423>

On 5/16/07, Jeff Garzik <jeff@garzik.org> wrote:
> Jan Hudec wrote:
> > And does the .git/logs/refs/heads/upstream-fixes still exist?
>
> Nope.
>
>
> > If it does not, as last resort you'd have to git fsck --unreachable
> > (this gives you all things that are not reachable from any ref), filter
> > out only commit objects and than remember which one should have been on
> > that branch after reading it's log, date and changes.
>
> Yeah, that will probably recover it.  I wound up digging the emails out
> of the trash bin, and applying them again.
>

That's bad.

Just out of curiosity: do you get any output from 'git log RENAMED-REF'?

--
larsh
