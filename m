From: Stephen Kelly <steveire@gmail.com>
Subject: Re: Creating remote branch called HEAD corrupts remote clones
Date: Thu, 20 Jan 2011 17:00:46 +0100
Message-ID: <AANLkTimVrBEdmz9e0qd4BR=VnQ0qNS7QZSvGA-B=5Uev@mail.gmail.com>
References: <ih1449$ul6$1@dough.gmane.org>
	<ih95fg$62b$1@dough.gmane.org>
	<201101201403.39174.trast@student.ethz.ch>
	<AANLkTinNNBupCi09_W60qdDGFc5CN-p=rKaf_FKW0kj1@mail.gmail.com>
	<AANLkTinoET4vBxVdfSejFmzwRaA=0AVdie5gmMvx44T5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Thu Jan 20 17:00:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PfwwR-0003dD-Bj
	for gcvg-git-2@lo.gmane.org; Thu, 20 Jan 2011 17:00:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755908Ab1ATQAt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Jan 2011 11:00:49 -0500
Received: from mail-qy0-f181.google.com ([209.85.216.181]:37609 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753880Ab1ATQAr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Jan 2011 11:00:47 -0500
Received: by qyk12 with SMTP id 12so796182qyk.19
        for <git@vger.kernel.org>; Thu, 20 Jan 2011 08:00:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=dqKr6LFaCtm81SYKPbdZRVeIb2fNa4albdKD+a+HYfc=;
        b=hoe6EoiB6CyZDxjXc9DNX6ztBaA91AzBEPQcHIA+Vtx2yy8TLbzy7i+CGLtOB1FN92
         KEwZwMZ2/faYAazlhIJkRQe1+PTuHb5DefMZTRUYZEMZxWZrM2ATQXsdDlEz10DsCozj
         KZ1wL48L6Z307nqub6XMJ7wK3VAIQvXFnqsHE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=nPdEiInxP4gl1XUDA43LMCWaiqL+rn+qjx5JsgMPuRSl5Jv4NJ7+fQgew4A75xlebM
         005IzWz65MVah5UTaIExPCdJw/LYwJrbgHDAoFPvLkR32ArDP/1/8624K0OAbfrw5wGK
         FkLSyDDn1LUjzx4B9DARm9ytxqicjQoi1KrVw=
Received: by 10.229.241.84 with SMTP id ld20mr1941923qcb.128.1295539246576;
 Thu, 20 Jan 2011 08:00:46 -0800 (PST)
Received: by 10.229.80.84 with HTTP; Thu, 20 Jan 2011 08:00:46 -0800 (PST)
In-Reply-To: <AANLkTinoET4vBxVdfSejFmzwRaA=0AVdie5gmMvx44T5@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165318>

On Thu, Jan 20, 2011 at 4:41 PM, Erik Faye-Lund <kusmabite@gmail.com> wrote:
> On Thu, Jan 20, 2011 at 4:05 PM, Stephen Kelly <steveire@gmail.com> wrote:
>> Ok so there was some movement with the result that no one uses what was set up.
>>
>> Presumably because git developers don't want a bug tracker.
>>
>> So how can I ensure that this particular issue doesn't get lost? Is
>> there no way except hope that people get involved in fixing it
>> straight away, and fix it straight away before they forget about it?
>>
>
> You could always fix it yourself, and submit a patch.
>

Correct. That would be a big rampup though and I might give up, move
on or forget and then no one would do it because everyone has
forgotten about it. I mean that in the general sense of any bug that
gets posted to this mailing list.

But I'm not trying to change how git people work. I'm just trying to
discover what the states of a bug in git should be understood to be
after it is emailed to this list and before it's in master. So far it
seems there is only one intermediate state: "Limbo, maybe forgotten.
You should email the list again"

Thanks,

Steve.
