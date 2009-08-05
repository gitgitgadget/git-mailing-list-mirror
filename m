From: John Tapsell <johnflux@gmail.com>
Subject: Re: Message from git reset: confusing?
Date: Wed, 5 Aug 2009 21:07:33 +0300
Message-ID: <43d8ce650908051107o5df3a780j7481bc364ae3062d@mail.gmail.com>
References: <vpqab2e7064.fsf@bauges.imag.fr>
	 <7v1vnqb2hc.fsf@alter.siamese.dyndns.org>
	 <32541b130908051042x5308e8fte7b3ead6bf1f24ee@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, git <git@vger.kernel.org>
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 05 20:07:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYkto-000529-PW
	for gcvg-git-2@gmane.org; Wed, 05 Aug 2009 20:07:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751307AbZHESHe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2009 14:07:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751236AbZHESHd
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Aug 2009 14:07:33 -0400
Received: from mail-yw0-f183.google.com ([209.85.211.183]:37921 "EHLO
	mail-yw0-f183.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751037AbZHESHd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Aug 2009 14:07:33 -0400
Received: by ywh13 with SMTP id 13so367114ywh.15
        for <git@vger.kernel.org>; Wed, 05 Aug 2009 11:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Csb5YEVdfN+i6ArTCRdWWN8hXUXbYAwzJxPLyvt7BWM=;
        b=sUK0zkQMoqyWMtBp7ZKZTwVu4HFj0tiaBzwrOdt/yscQ+ckRXn/NbMkEvKUijIa3Nb
         X4jyYyEsAqrntx1317n68VUNWTTga7sFqSS8Ih1pjAOAifSbpLsNaYArsg9MiewQAUXB
         yZNSp3OvJnZ4ZkaVWcEqFCKTTxeuP53vEXmso=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=o62Cm810e/uYejtnHWfT0c+mF0z0Cjg4DZg44VMJRFesP0BOiT+X5aZ+O54h9tGIe9
         xnrn6vlaNAN0rFx3YfmtvhJ3HivwEt7c7bhpt+c3A4OcR/5k2tuKEkHl+rWrMpf3J7Y/
         jgWRP7Lu5TDnd6S0oJ+CnbZ5Dv82B+Sn3qcJM=
Received: by 10.150.144.17 with SMTP id r17mr749132ybd.36.1249495653038; Wed, 
	05 Aug 2009 11:07:33 -0700 (PDT)
In-Reply-To: <32541b130908051042x5308e8fte7b3ead6bf1f24ee@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124936>

> Even if people don't know what "M" means on day 1 (although hopefully
> they don't need "git reset" on day 1), at least it doesn't look like
> an error message.

Actually for newbies, git reset is pretty much the first thing they
learn to try to undo the mess that they created.

Almost the very first thing a newbie to git does is something like:

$ git checkout experimental_branch
<modify file>
$ git commit
..
(what do you mean I've committed to a detached head?  why is
everything going wrong?  what's happening!!)

$ git reset
