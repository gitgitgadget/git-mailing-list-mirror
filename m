From: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
Subject: Re: What's cooking in git.git (Apr 2011, #04; Tue, 12)
Date: Thu, 14 Apr 2011 15:38:14 +0200
Message-ID: <BANLkTi=7YSfKe=Pc5n-BNr30=ADM-jRXrg@mail.gmail.com>
References: <7vaafvnl9t.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Apr 14 15:38:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QAMkh-0007rE-8w
	for gcvg-git-2@lo.gmane.org; Thu, 14 Apr 2011 15:38:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758705Ab1DNNiW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 Apr 2011 09:38:22 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:64395 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754614Ab1DNNiV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Apr 2011 09:38:21 -0400
Received: by vws1 with SMTP id 1so1273746vws.19
        for <git@vger.kernel.org>; Thu, 14 Apr 2011 06:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Sw5Vn92eMrdLPGy1xid2JxjgMQ5z5HG1zKbcmJgb5X8=;
        b=dqXgGobeBItZ8+jTpVqLdxEDmgyixs347JatP11hMbk4GPCdk7ZT1CrkaaGOrMgacC
         HCTIzn1j9uQHrmJ0qZslPEc8cWPQlNjweMlm3V5zJYhXbxUI5r37YvspCgSkQxeVYYV7
         uzLRaU1qcu3BOycafkdZlKOdyEpWIB1J19zoY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=MagoDfFDYN94vvYpxp4t0zhvQlRhmLvyURgum1eiwxG3nco1fptPt1y8RFWom43kWJ
         vQVkW5WOYLo1Q/Pbct3+45llEH5m5JmtvKZITEueXJb1WdOU84xIqlGA9R8ENmTQlQOC
         enjBgl1OkEpGJlZeBBj7LczEmYqNzW+X+U91k=
Received: by 10.52.180.72 with SMTP id dm8mr1073204vdc.118.1302788294621; Thu,
 14 Apr 2011 06:38:14 -0700 (PDT)
Received: by 10.220.180.202 with HTTP; Thu, 14 Apr 2011 06:38:14 -0700 (PDT)
In-Reply-To: <7vaafvnl9t.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171515>

On Wed, Apr 13, 2011 at 12:43 AM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> * mh/git-svn-automkdirs (2011-04-01) 1 commit
> =A0(merged to 'next' on 2011-04-03 at 7fa4978)
> =A0+ git-svn: add an option to skip the creation of empty directories
>
> Should be safe, but I'd like an Ack from git-svn folks.

I wanted to test performance of this change - what's the best way to do=
 it?

I tried some ideas, but rebase was too fast for performance measurement=
s.
I did not have new commits, but just some old, already in trunk changes=
, which
I tried to rebase - probably it was just fast forward?


--=20
Piotr Krukowiecki
