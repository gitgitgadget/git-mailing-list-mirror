From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: Using test-lib.sh under GPLv3?
Date: Tue, 16 Feb 2010 17:07:21 -0500
Message-ID: <32541b131002161407k69c1a2batb992b75775fbd472@mail.gmail.com>
References: <87ljf8pvxx.fsf@yoom.home.cworth.org> <87hbpwpoko.fsf@yoom.home.cworth.org> 
	<5641883d1002060727ia4e6c16lf800a92fc8735430@mail.gmail.com> 
	<201002081614.24284.sojkam1@fel.cvut.cz> <871vgr78lr.fsf@yoom.home.cworth.org> 
	<87iqa2y0gz.fsf@steelpick.localdomain> <87r5oqe7mi.fsf@yoom.home.cworth.org> 
	<871vgmki4f.fsf@steelpick.localdomain> <m3aav98oj7.fsf@localhost.localdomain> 
	<87r5olfhz9.fsf@steelpick.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Carl Worth <cworth@cworth.org>, notmuch@notmuchmail.org,
	git@vger.kernel.org
To: Michal Sojka <sojkam1@fel.cvut.cz>
X-From: git-owner@vger.kernel.org Tue Feb 16 23:08:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhVaO-00011L-K2
	for gcvg-git-2@lo.gmane.org; Tue, 16 Feb 2010 23:08:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933459Ab0BPWHo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Feb 2010 17:07:44 -0500
Received: from mail-yw0-f176.google.com ([209.85.211.176]:37741 "EHLO
	mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933456Ab0BPWHn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Feb 2010 17:07:43 -0500
Received: by ywh6 with SMTP id 6so4993655ywh.4
        for <git@vger.kernel.org>; Tue, 16 Feb 2010 14:07:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=Sm+POFxriFqZR8Gi1vUwKCPv6t0k8r5Uyd3CrlR7ok0=;
        b=RicrMMHZ0QhWBE8WW2oH8SAHUeoo8x3vd7XCjw8GPO8dktFGrIz7h41KdRtnr2g/VC
         ip2QOivgupkKQP6NtDQcMYWpTHB9YUfC8APc4qXgB714zojPUdI0RS5M/VmBmAfkeTGL
         MKhkz03q0YgSg81lgTQBF4qrJjVf9hKRuvNjQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=E6F+ztgQz1YYMcHJ/WGLkqNS1y+9ohyO4ryPs886tRdWXGD2DAQjGAiqjWw58uoTKq
         gaBC9kIxLYegovrklD4LVoyXDbVd1r4/nWgx6wzURXAjZLWz2d2fbKnJqbRB2p/sumG9
         7A23tKKvmVDfBZFg9Ic1aL3L/Ywf0o4BLnCag=
Received: by 10.150.47.11 with SMTP id u11mr8870627ybu.140.1266358061123; Tue, 
	16 Feb 2010 14:07:41 -0800 (PST)
In-Reply-To: <87r5olfhz9.fsf@steelpick.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140159>

On Tue, Feb 16, 2010 at 8:06 AM, Michal Sojka <sojkam1@fel.cvut.cz> wro=
te:
> On Tue, 16 Feb 2010 02:27:37 -0800 (PST), Jakub Narebski <jnareb@gmai=
l.com> wrote:
>> Michal Sojka <sojkam1@fel.cvut.cz> writes:
>>
>> > I like the simple and powerful test suite used by Git and I would =
like
>> > to use something like that in Notmuch project (http://notmuchmail.=
org/).
>> > [...]
>>
>> Have you thought about using TAP (Test Anything Protocol) format for
>> your testsuite? =A0Its page (http://testanything.org) has a TAP-prod=
ucing
>> bash library: http://testanything.org/wiki/index.php/Tap-functions
>
> Yes, somebody has mentiond TAP on notmuch list. From a quick look at =
TAP
> shell library it seems to me a bit more complex then git's library an=
d
> it also requires bash.
>
> If we need to use some TAP-based tools, we could easily change the
> output of git's library to conform to TAP. Right?

Another TAP-like option is wvtest:

   http://github.com/apenwarr/wvtest

It's LGPLv2.

Have fun,

Avery
