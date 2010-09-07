From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 13/15] gettextize: git-revert messages using the "me"
 variable
Date: Tue, 7 Sep 2010 00:39:36 -0500
Message-ID: <20100907053936.GS1182@burratino>
References: <1283638229-14199-1-git-send-email-avarab@gmail.com>
 <1283775704-29440-14-git-send-email-avarab@gmail.com>
 <20100906185023.GE25426@burratino>
 <AANLkTi=8VXBFW7jzUe4EuCd+i221zRUt6LHGBYG8FQya@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jan =?utf-8?Q?Kr=C3=BCger?= <jk@jk.gs>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 07 07:41:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OsqwA-0003FV-Cu
	for gcvg-git-2@lo.gmane.org; Tue, 07 Sep 2010 07:41:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751472Ab0IGFlh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Sep 2010 01:41:37 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:58054 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751083Ab0IGFlg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Sep 2010 01:41:36 -0400
Received: by gxk23 with SMTP id 23so1828009gxk.19
        for <git@vger.kernel.org>; Mon, 06 Sep 2010 22:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=Irgd8pgwMzg1cBGyYriiP0CSpkGTILD2aYe8dXNhRac=;
        b=lVD+9Yhv29BQYhTeL4SAJot4nTgIWTAuHd+pshsswwbjJv9IJnG02dvwXd3rzuKeKS
         nhQff5sBUEms5nXGpka+xNDkwfsJYVIK8eWg1CUpBDcivo3DNKsfrqHSnl2QdvbojqCD
         iGbveBPuVOLtpTg+bLTRrO6lwrQhJyKihUayw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=Bzyx93S2eGmV4VDQFWbPWEVDuVJnX3eWml9mUc/RLeeeidHj9/i9CELUZTDqk7ZCDD
         crsEWYAO9QG4agyijeD0x0309SC9++QF7YXnW9/Sx+RuZdXkOWpUxMpmElUfc+7XmrcK
         2TAOkJMAuLcXSh7RVzp9C0+Q5Sb/9fCx4PGQ0=
Received: by 10.100.140.10 with SMTP id n10mr828927and.106.1283838095714;
        Mon, 06 Sep 2010 22:41:35 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id i25sm10712152anh.37.2010.09.06.22.41.34
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 06 Sep 2010 22:41:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTi=8VXBFW7jzUe4EuCd+i221zRUt6LHGBYG8FQya@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155679>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> On Mon, Sep 6, 2010 at 18:50, Jonathan Nieder <jrnieder@gmail.com> wr=
ote:

>> Not good, in my opinion. =C2=A0The dialogue ought to look like this,=
 I think:
>>
>> =C2=A0$ git cherry-pick astermay
>> =C2=A0...
>> =C2=A0fatal: cherry-pick: Unableway otay itewray ewnay indexway ilef=
ay
[...]
> I don't know if all of the above hold true, e.g. because some
> languages will always transliterate things, even proper nouns.
>
> But as mentioned before the string is probably being used in too many
> different contexts for it to be useful to them.

Hmm, okay.  Do you mean languages like Japanese or something else?  At
any rate, I guess you are right that this is too complicated for the
moment.
