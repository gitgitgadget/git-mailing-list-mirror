From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: Local branch ahead of tracked remote branch but git push claims everything up-to-date
Date: Wed, 20 Aug 2008 17:22:05 -0400
Message-ID: <32541b130808201422l2b128beer142544ff91de5ca3@mail.gmail.com>
References: <1219263969579-736663.post@n2.nabble.com>
	 <8585F10E-C33C-481E-B044-A7125F3316F2@web.de>
	 <32541b130808201401l2ad105ccnc37acdacd08d4c3a@mail.gmail.com>
	 <7vbpznpeup.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "=?ISO-8859-1?Q?Andreas_F=E4rber?=" <andreas.faerber@web.de>,
	ir0s <imirene@gmail.com>, git@vger.kernel.org,
	"Daniel Barkalow" <barkalow@iabervon.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 20 23:23:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVv96-0001CI-LB
	for gcvg-git-2@gmane.org; Wed, 20 Aug 2008 23:23:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752299AbYHTVWJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 Aug 2008 17:22:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752958AbYHTVWI
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Aug 2008 17:22:08 -0400
Received: from mail-gx0-f16.google.com ([209.85.217.16]:54298 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752271AbYHTVWG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Aug 2008 17:22:06 -0400
Received: by gxk9 with SMTP id 9so198424gxk.13
        for <git@vger.kernel.org>; Wed, 20 Aug 2008 14:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=MmTLmLlGPoK4Gjvn0Wrjf1xIJrPXuh1LVNTiSzW2XWo=;
        b=nzOeiKREAd2eipf5MWXW+66S03F+uQE1A82Ony7ZcUppXCdHV6nrewcO7z3UUa4HJR
         aB3UfJ5WG9uqimRfzz8YDzoln7/9WnebJ2LmT/N7xmSSSVlp1oBDYZxjYZH926NwJI93
         pfbSoxjbhTNlVi4WqKlWHdZgQfwEAkn+QBE8E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=qbIN5uWLytU0WxPcO31lWv/BEp4NsuoRBRGJvjaOulCIY5gg8qzjDQD0gW3YMyO40i
         lu4RuH78SHoSsE2NCF1UOt8IOaD8tMnPK7A97Lugv0T7Khh7t+YqPOR1Q2wzZZLFIDfy
         VtbJFSWusx5xMTVuoaRbr66aRmNN6ZowCdKFU=
Received: by 10.151.45.6 with SMTP id x6mr787724ybj.186.1219267325034;
        Wed, 20 Aug 2008 14:22:05 -0700 (PDT)
Received: by 10.150.98.19 with HTTP; Wed, 20 Aug 2008 14:22:04 -0700 (PDT)
In-Reply-To: <7vbpznpeup.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93050>

On Wed, Aug 20, 2008 at 5:15 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> "Avery Pennarun" <apenwarr@gmail.com> writes:
>
>> On Wed, Aug 20, 2008 at 4:40 PM, Andreas F=E4rber <andreas.faerber@w=
eb.de> wrote:
>>> You need to name the local branch, not the remote one:
>>>
>>> $ git push origin mybranch
>>>
>>> It should then push to remotebranch.
>>
>> Not only that, but the "ahead of tracked branch" message depends on
>> your local copy of the remote branch, not the remote copy of the
>> remote branch.
>
> I think we have long been doing so.  Daniel, correct me.

=2E..and I'm dumb.

I apologize.  "git pull origin mybranch" does not update
origin/mybranch.  "git push origin mybranch" does.

It could be argued that pull should update the local reference too,
but that's irrelevant at the moment.

Have fun,

Avery
