From: Michael Witten <mfwitten@gmail.com>
Subject: Time zone option name (Re: [RFC 5/5] Date Mode: Tests)
Date: Sat, 23 Apr 2011 03:45:51 +0000
Message-ID: <453b72ab-40cc-431b-9865-3080c250a7dd-mfwitten@gmail.com>
References: <0f30e048-7dd2-4aff-8c1f-00bf0dfa3d34-mfwitten@gmail.com>
            <bbf61df6-b7fa-429e-866e-899354953cbd-mfwitten@gmail.com>
            <7vd3kfusva.fsf@alter.siamese.dyndns.org>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 23 05:47:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QDToh-0008Dq-6b
	for gcvg-git-2@lo.gmane.org; Sat, 23 Apr 2011 05:47:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754307Ab1DWDr1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Apr 2011 23:47:27 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:56849 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753562Ab1DWDr0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Apr 2011 23:47:26 -0400
Received: by eyx24 with SMTP id 24so309055eyx.19
        for <git@vger.kernel.org>; Fri, 22 Apr 2011 20:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:subject:date:from:to:cc:message-id:references;
        bh=l5YU+TcY6OBObEKZ+bu68x+a71niy81NE1W3KSYWNj4=;
        b=EwMPGiD7wMrATAGN3K9z+lB5L/h3SJxLBXyTM+cf9Kcl8PET1XzSOjYHWto0ZGnIcQ
         sVe+WmPvn8uUjpy63pccQXM9l9Kt9gBa9RSmaBxQG8B0NgxwvFTOBxFXh6aZp4CCSQRJ
         OmoUFa1BM01v9zbw3ToqbtcAI3ntp4Sw6lX4k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:date:from:to:cc:message-id:references;
        b=hy1dfpYYwnD7WGMvyEkE8uUKZSt1tbk0kwx+uz10m17NOs/H24s+jx2f8HAMH4Wq8A
         YNVTgTTQi6tz5XqooyxFOfj10IW9kKy1ridfv0NEYvNxtqNR+xTwYpekYZWAi3nyH4df
         ItNsBIQVk1ECbePYB0KJdApRWIrKnMSULHclk=
Received: by 10.213.23.89 with SMTP id q25mr853063ebb.120.1303530445168;
        Fri, 22 Apr 2011 20:47:25 -0700 (PDT)
Received: from gmail.com (tor-exit-router40-readme.formlessnetworking.net [199.48.147.40])
        by mx.google.com with ESMTPS id y7sm2452915eeh.7.2011.04.22.20.47.23
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 22 Apr 2011 20:47:24 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171950>

On Thu, 21 Apr 2011 15:44:41 -0700, Junio C Hamano wrote:

> I'd like to have part of the tests in this patch at the beginning of the
> series to document and protect the behaviour of the current --date related
> options, then your enhancement that adds --zone that lets the users
> specify the timezone and the format independently, and finally the
> remainder of this patch as an addition to the test script to document and
> protect the interaction between the two options (e.g. what happens when
> none or only one is specified? what happens when conflicting options such
> as "--date=local --zone=gmt" is given?).

I'd like to clarify what you intend the new time zone option to be named; my
patch series currently uses `--time-zone' (which is admittedly long), but it
would appear here that you find `--zone' attractive. My only qualm there is
that `zone' is such a rich word; not only is it somewhat incomprehensible out
of context, but it also might be useful for something else in the future.
