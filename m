From: =?UTF-8?B?SmFrdWIgTmFyxJlic2tp?= <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb/INSTALL: Simplify description of GITWEB_CONFIG_SYSTEM
Date: Tue, 16 Apr 2013 09:11:10 +0200
Message-ID: <516CF98E.2050706@gmail.com>
References: <CAPig+cSXC6cA8gc1T=byqeQF_gUYKpHTjpTt54Xog=jtfdgMwA@mail.gmail.com> <85f4e2b8e40efb234a7fc0d0ce0d40562690d001.1365719690.git.stefano.lattarini@gmail.com> <7v4nfch90r.fsf@alter.siamese.dyndns.org> <20130412064837.GA5710@elie.Belkin> <20130412064953.GB5710@elie.Belkin> <7vy5cnd0m4.fsf@alter.siamese.dyndns.org> <516888C0.90501@gmail.com> <CAM9Z-nmOzpJdT3ni0rYRkg7Z26N5XSRyqp0TkTY79AAZ85pw2A@mail.gmail.com> <7vobdfnlc7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Drew Northup <n1xim.email@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org,
	Stefano Lattarini <stefano.lattarini@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 16 09:11:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1US02w-0004ww-Vf
	for gcvg-git-2@plane.gmane.org; Tue, 16 Apr 2013 09:11:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755021Ab3DPHLP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Apr 2013 03:11:15 -0400
Received: from mail-ea0-f182.google.com ([209.85.215.182]:60445 "EHLO
	mail-ea0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754945Ab3DPHLO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Apr 2013 03:11:14 -0400
Received: by mail-ea0-f182.google.com with SMTP id q15so72051ead.27
        for <git@vger.kernel.org>; Tue, 16 Apr 2013 00:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        bh=v3s5yqiiRQefXI6WZbjGu8oEEUBGwqTFSoDbGVaDkGQ=;
        b=geBEj0ZtO/qfsPG+WH0LVn0qdgYiyjFi9qqL2jsvprfsLWzHqMzGBd2CBuWn5ylEBx
         IDyeoHhSkI9lInQGXS36hUmB1Q8gS8SMCNuvCmeQzwPGzgn+yO8O3KIymtfYp2ScNAC/
         HXu6L42ZwmVt9/gzEvXd1oQVQvqf44yzoT4jpLUNr6x1sKf6CEDeyQH+X3IGmIg3T3hR
         GBUyFuMSXs+LDvsiVAehU6rjWgc6upb/4+dctmK+jPiEI6H5ZSgpCVMyHofvQZ7M6eLQ
         whW74qTsfgkqLvj7Yz5WL/hGe79iRK7bLe1sZbW1vTJirqU0m9kOqq6IzjJoBm3uqFuU
         q0rw==
X-Received: by 10.15.83.73 with SMTP id b49mr3337351eez.25.1366096273396;
        Tue, 16 Apr 2013 00:11:13 -0700 (PDT)
Received: from [192.168.1.14] (ept17.neoplus.adsl.tpnet.pl. [83.20.61.17])
        by mx.google.com with ESMTPS id b47sm1076752eez.2.2013.04.16.00.11.11
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 16 Apr 2013 00:11:12 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
In-Reply-To: <7vobdfnlc7.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221371>

Junio C Hamano wrote:

> In order to just pick and use the more appropriate one (or a useful
> combination of the two), a clean description of what each of them do
> without historical cruft is more readable and useful, isn't it?  I
> would expect that most of them who are newly configuring a system
> would pick COMMON one and override per instance as needed, without
> touching the SYSTEM one (fallback default) after reading the above,
> and that is what we want to happen.
>=20
> Do you think sysadmins need a history lesson to understand why there
> are two different possibilities?
[...]
> I think the new text conveys the necessary information to the
> intended audience with more clarity without the history lesson or
> the record of your past frustration. Am I mistaken?

Note also that this is about *gitweb/INSTALL*, which is meant to be
*short* and succint description on how to install gitweb, and not
about the reference documentation: gitweb(1) or gitweb.conf(5).

Description of historical behavior (and backward compatibility)
has place (if any) in manpages, not gitweb/INSTALL.
--=20
Jakub Nar=C4=99bski
