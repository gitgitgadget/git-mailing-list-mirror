From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Stable ab/i18n branch
Date: Thu, 14 Oct 2010 15:00:27 -0500
Message-ID: <20101014200027.GA18813@burratino>
References: <7v39s9fkk1.fsf@alter.siamese.dyndns.org>
 <AANLkTimr73DUBBwdj9MXOQQ=O-vmyyEZpgwdHmRsGG_-@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Erik Faye-Lund <kusmabite@gmail.com>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 14 22:04:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P6U1y-0001rs-5J
	for gcvg-git-2@lo.gmane.org; Thu, 14 Oct 2010 22:04:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755369Ab0JNUD4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 Oct 2010 16:03:56 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:38638 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755104Ab0JNUDz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Oct 2010 16:03:55 -0400
Received: by vws2 with SMTP id 2so15833vws.19
        for <git@vger.kernel.org>; Thu, 14 Oct 2010 13:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=X9pZwhc6UTZWlrjMoOKnLXyJENgF1zEV+IKxNAflUS0=;
        b=Xz13X5qjcogLMPE80tZH71mRfZHKEWcmH7k7MMRHXCOyKcG1u+4llmb1FN4JfAynqt
         KIvfkAktwBTX5nGPIqkCgdu96rfzIaS7fWgTN3PT4pNfqxu45tr9L5Okkhhe6cqvcH26
         D9IX6qx/kq8kOHO4s9YCh1Qlv4sLvn0bN/xq0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=hNioy3QKD77siSSWgM2nN+SIIWcOAmxZ/pEp9Alx951G9RSJ3ya//n3+O6w/yaLlIZ
         iDTo8MU4NgIS0G2390/j48HiR9uKd8R1+8kuI76N2wfk2LENXi4l0qwEl5GZB1LaZ+gb
         uLYRPwDVHoHehyEmJvgRNyUAzv6UShf5jGnRQ=
Received: by 10.220.45.73 with SMTP id d9mr820439vcf.187.1287086634640;
        Thu, 14 Oct 2010 13:03:54 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id l9sm6112504vbp.1.2010.10.14.13.03.53
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 14 Oct 2010 13:03:53 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTimr73DUBBwdj9MXOQQ=O-vmyyEZpgwdHmRsGG_-@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159068>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> Could you please pick up the 160 commit version of this at:
>=20
>     git://github.com/avar/git.git ab/i18n

This is a "give an inch and they'll ask for a mile" sort of thing, but
would it be possible to maintain a stable branch with the i18n
infrastructure that only gets rebased when there is reorganization
going on?

The gettextization and translations are rebased for other reasons (to
avoid going crazy), I know.  But with the infrastructure it is starting
to be hard to track what changes over time.
