From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: git-send-email generates mail with invalid Message-Id
Date: Tue, 28 Jul 2009 11:51:01 +0200
Message-ID: <40aa078e0907280251k159d9a93xa8c90413b3fab5a@mail.gmail.com>
References: <200907280446.22890.elendil@planet.nl>
	 <40aa078e0907280217g76cbfai8544edde605f8772@mail.gmail.com>
	 <200907281127.44558.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Frans Pop <elendil@planet.nl>, git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Jul 28 11:57:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MVjRJ-0002UD-9y
	for gcvg-git-2@gmane.org; Tue, 28 Jul 2009 11:57:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750997AbZG1J5Z convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 28 Jul 2009 05:57:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750759AbZG1J5Y
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Jul 2009 05:57:24 -0400
Received: from mail-fx0-f216.google.com ([209.85.220.216]:52516 "EHLO
	mail-fx0-f216.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750743AbZG1J5Y convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Jul 2009 05:57:24 -0400
X-Greylist: delayed 382 seconds by postgrey-1.27 at vger.kernel.org; Tue, 28 Jul 2009 05:57:23 EDT
Received: by fxm12 with SMTP id 12so5147fxm.37
        for <git@vger.kernel.org>; Tue, 28 Jul 2009 02:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=9jXvjPPUs5agbjNFoOIv5LngJc26tsoyH0vMJrBNRZY=;
        b=wlf3fbtlR1o/T2Tm537k+F5mHs43cPf7fY8ahAAbOG9gjH3yhbDX5OYYx6FaEN+m7K
         DPOcPyA0KUIEICKsX5OOYUnDcxSzUYedZI8UTOOmGCGNi42U/7sf4SFZHo9QaQ9t2pFy
         26+Gifwi5RS15+N1jowkq0qPSCy+fzlJnbc94=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=jhn8ZhxHvI7MRMPFTcJxZuzMnofEEMPTGi4IhQ/6ATocaicrmQtJdWvazyf296TE3z
         /mOVfqLFLwXzxjk1ybnutTUaTvGykYN+Gl5fzVuHv0W9yoP2CJjmDQQc9my6qQS9D7PP
         8RvhU4dK+nt5TEugqgmFSXw3Xv3yZxifOtf5U=
Received: by 10.204.50.195 with SMTP id a3mr4125500bkg.123.1248774661455; Tue, 
	28 Jul 2009 02:51:01 -0700 (PDT)
In-Reply-To: <200907281127.44558.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124229>

On Tue, Jul 28, 2009 at 11:27 AM, Thomas Rast<trast@student.ethz.ch> wr=
ote:
> Erik Faye-Lund wrote:
>> On Tue, Jul 28, 2009 at 4:46 AM, Frans Pop<elendil@planet.nl> wrote:
>> > I assume that this is a configuration issue in the git setup of th=
e
>> > sender, but shouldn't git-send-email refuse to send out messages w=
ith an
>> > invalid Message-Id?
>>
>> Not quite. git-send-email generates these message-ids itself (those
>> who contain "-git-send-email-", that is), and should as such be able
>> to rely on them being generated correctly. [...]
>> I'm no perl-expert, but the code looks pretty much correct to me.
>
> git-format-patch generates its own message IDs if it needs them for
> threading, with gen_message_id() (in builtin-log.c). =A0That one appe=
nds
> the committer email address blindly, without verifying that it has an
> @ in it.

That must be a separate issue (but quite possibly a valid one), since
gen_message_id's ids dont' contain "-send-email-" like the message-id
in the report does, no?

--=20
Erik "kusma" Faye-Lund
kusmabite@gmail.com
(+47) 986 59 656
