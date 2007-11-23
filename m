From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Git in a Nutshell guide
Date: Fri, 23 Nov 2007 10:28:28 +0100
Message-ID: <200711231028.29010.jnareb@gmail.com>
References: <1195477504.8093.15.camel@localhost> <fhs33j$eg9$1@ger.gmane.org> <87tzneu1tw.fsf@lysator.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "Jonas Juselius" <jonas.juselius@chem.uit.no>
To: David =?utf-8?q?K=C3=A5gedal?= <davidk@lysator.liu.se>
X-From: git-owner@vger.kernel.org Fri Nov 23 10:29:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IvUqL-0005Q9-T9
	for gcvg-git-2@gmane.org; Fri, 23 Nov 2007 10:29:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753264AbXKWJ2m convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 23 Nov 2007 04:28:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752424AbXKWJ2m
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Nov 2007 04:28:42 -0500
Received: from nf-out-0910.google.com ([64.233.182.185]:42202 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752359AbXKWJ2l (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Nov 2007 04:28:41 -0500
Received: by nf-out-0910.google.com with SMTP id g13so2712823nfb
        for <git@vger.kernel.org>; Fri, 23 Nov 2007 01:28:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=2fJjwP+D26Ci55vJ/SnhQd4p5KSW8IpVg6+/AHKFrBc=;
        b=s0D72Tb4B5WZdwgsl9KQez0iw1xk5VIJ3kXzA8XKmn7z66D0JpDj88Y7yzX0KA6d6MZ/bkgViaJT6Ygcy/H1GOUyqB9TeI2WDZKGzdU9NaZU9wV7CliajK2WcF/O4TWLO387zszrCcLWbhsFNITdoaJ5Zq+Wyu+pU+qoQfU+iqg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=h38KLHJ7JKVWiu5xchuhDXRTXzKvnjnWH9yhea8tfWDRs3hNB+/9K3oSRKWYPwp33/0pv8s2tlrJn9uBQsQwRzVKaBzbgUq/HINLTqjj89eOhDnv4ps6YlBTu/G8wNXOIijyWVOJ3tXlhh8L9bZoG7PnwqXcmjGiDOaeJMSWHB0=
Received: by 10.82.171.16 with SMTP id t16mr10805459bue.1195810118647;
        Fri, 23 Nov 2007 01:28:38 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.249.172])
        by mx.google.com with ESMTPS id u9sm4023694muf.2007.11.23.01.28.36
        (version=SSLv3 cipher=OTHER);
        Fri, 23 Nov 2007 01:28:37 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <87tzneu1tw.fsf@lysator.liu.se>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65881>

On Thu, 22 Nov 2007, David K=C3=A5gedal wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
>=20
>> A few comments (from what I checked so far):
>>
>> 1. It is "man git-checkout" (or "git checkout --help"),
>>    not "man git checkout"
>=20
> Or "git help checkout", which is what I usually use (for some reason)=
=2E

Or, at least for now "git checkout --help", which requires only
adding "--help" at the end. At least for now because some commands
return short summary for "--help" and I think it is considered
that it should be done that way for all porcelain commands.

--=20
Jakub Narebski
Poland
