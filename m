From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: What's cooking in git.git (Feb 2009, #03; Sat, 07)
Date: Sun, 8 Feb 2009 13:58:53 +0100
Message-ID: <200902081358.53914.jnareb@gmail.com>
References: <7vk581syj1.fsf@gitster.siamese.dyndns.org> <m3iqnlvm29.fsf@localhost.localdomain> <87vdrlp4gy.wl%seb@cine7.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?iso-8859-1?q?S=E9bastien_Cevey?= <seb@cine7.net>
X-From: git-owner@vger.kernel.org Sun Feb 08 14:00:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LW9Gy-0001uV-K7
	for gcvg-git-2@gmane.org; Sun, 08 Feb 2009 14:00:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752567AbZBHM7H convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Feb 2009 07:59:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752392AbZBHM7F
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Feb 2009 07:59:05 -0500
Received: from fg-out-1718.google.com ([72.14.220.156]:20477 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752282AbZBHM7D (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Feb 2009 07:59:03 -0500
Received: by fg-out-1718.google.com with SMTP id 16so877782fgg.17
        for <git@vger.kernel.org>; Sun, 08 Feb 2009 04:59:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=mPK/6cSTwyPLoZKSnpYLtmxDgrYeIz+M4xicvBfdF+I=;
        b=MMHARVX35NG7CtuQf/iKaJ8R7YmgPh+ivBHBbfRwVUUQ0xmj/rZ/VSCiP9g5l5v4gn
         TmFFVqXZagaTnCLJmB8hGpCwYOhgWXs5InMHPcSAa49qUyBretBmbpr8O2YP+98+gH5a
         Q8x9RJ7wkzJHC1WiWINmX1wmSApHXwSMhquG4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=hByIn0TeiI5YfWnurMi+PUHJMX/rUnrDbaKZdJ7vdIbuESPmiz1zPU/JfCwFaE3XIZ
         ENZ+JfFOQEmmf6cIpeNwlPciyNVvmaogCpuVDHbOb387LlmgEomnIYcPfwWLb/PtgfCK
         lGZXTsG2vBbkucEivArGyJY+P0UvmtXhUDGPI=
Received: by 10.86.31.18 with SMTP id e18mr11578fge.72.1234097941696;
        Sun, 08 Feb 2009 04:59:01 -0800 (PST)
Received: from ?192.168.1.13? (abwm89.neoplus.adsl.tpnet.pl [83.8.236.89])
        by mx.google.com with ESMTPS id d4sm516817fga.28.2009.02.08.04.59.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 08 Feb 2009 04:59:01 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <87vdrlp4gy.wl%seb@cine7.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108973>

S=E9bastien Cevey wrote:
> At Sat, 07 Feb 2009 15:54:54 -0800 (PST), Jakub Narebski wrote:
=20
>>> * sc/gitweb-category (Fri Dec 12 00:45:12 2008 +0100) 3 commits
>>>  - gitweb: Optional grouping of projects by category
>>>  - gitweb: Split git_project_list_body in two functions
>>>  - gitweb: Modularized git_get_project_description to be more gener=
ic
>>>=20
>>> Design discussion between Jakub and Sebastien seems to have stalled=
=2E
>>=20
>> I tried to redo the patches, but 2nd do not apply using "git am -3"
>> because of changes in gitweb.  Sebastien, could you resend this seri=
es,
>> marking it as [PATCHv3 n/3 (resend)] or something like that (unless =
you
>> would modify them)?
>=20
> I just sent them again, let me know if there is any more problems wit=
h
> that. They are rebased onto the current git master HEAD, so hopefully
> it should be fine?

Yes, they apply just fine. Thanks.

I'll try to review them soon, but I think that they would be for after
1.6.2, as currently there is rc0 phase.
--=20
Jakub Narebski
Poland
