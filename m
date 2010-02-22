From: =?UTF-8?Q?Bj=C3=B6rn_Gustavsson?= <bgustavsson@gmail.com>
Subject: Re: What's cooking in git.git (Feb 2010, #05; Sun, 21)
Date: Mon, 22 Feb 2010 09:17:18 +0100
Message-ID: <6672d0161002220017u7270c637k83a796cfc8730a64@mail.gmail.com>
References: <7vtytacebd.fsf@alter.siamese.dyndns.org>
	 <4B8233DE.7050106@viscovery.net>
	 <7v4ol9lngk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 22 10:33:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NjTTr-0007ft-Ae
	for gcvg-git-2@lo.gmane.org; Mon, 22 Feb 2010 09:17:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752402Ab0BVIRV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 22 Feb 2010 03:17:21 -0500
Received: from mail-ew0-f228.google.com ([209.85.219.228]:58421 "EHLO
	mail-ew0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751292Ab0BVIRU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Feb 2010 03:17:20 -0500
Received: by ewy28 with SMTP id 28so2455114ewy.28
        for <git@vger.kernel.org>; Mon, 22 Feb 2010 00:17:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=dbMmEkOjDiyz4VPhClQQMl8zuCSUNfHstUSEWnC5c4I=;
        b=ecF1c0ywV2dqVb1PldNk0uH9//Q1wWsbj9utMdPYTTqTMCobWAi5bStzMVm9WtK2N/
         RxTBbQ8U6O5Gpfmkhn83tblc1IPFvBFQvfqyI2EuVciwOJVGSo7PEPrZ8uyCt71PeTMB
         OhRIbBUrcQDlYJmZEuys1NtQXNPB9UQBdnSyU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=k54TEygvDLbhC1PbVapdFByUFMdO3054sMOlLD2QDnmigrU779DGkkW9CHGOIttfAw
         XmcWg9A9K19V3OyqAYexKtZ+g0irBSxX6hDkQybI7XdjR6ZaZP3GujtP9ND55kn8rHhe
         mvAn7OOkiRGagBR14WtSBCouFmv6fFY2lmXJ4=
Received: by 10.216.87.143 with SMTP id y15mr737026wee.42.1266826638503; Mon, 
	22 Feb 2010 00:17:18 -0800 (PST)
In-Reply-To: <7v4ol9lngk.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140650>

On Mon, Feb 22, 2010 at 8:49 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
>
> In the meantime, please run "git log --oneline --first-parent master.=
=2Epu",
> pick "ce8d258 Merge 'jn/maint-fix-pager'" from the output, and use th=
e
> second parent ce8d258^2 instead.

I use a simple Perl script called create-topic-branches.
It can be found here:

http://gist.github.com/275033

When it is run, it will print the "git branch" commands needed
to create the topic branches. Either copy and paste the
commands for the branches you are interested in,
or do something like this:

create-topic-branches next..pu | grep bg/ | sh

which will create local branches for any of my own
branches that are currently included in 'pu'.

--=20
Bj=C3=B6rn Gustavsson, Erlang/OTP, Ericsson AB
