From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v4 17/73] gettextize: git-branch "Deleted branch [...]"
 message
Date: Fri, 25 Feb 2011 15:16:38 -0600
Message-ID: <20110225211638.GB4580@elie>
References: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
 <1298418152-27789-18-git-send-email-avarab@gmail.com>
 <20110225075429.GF23037@elie>
 <AANLkTi=Ua=2zm3GhHJVfECJ5VcZaMnRf9MYjSONoWcP4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 25 22:16:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pt51x-0001Wq-AC
	for gcvg-git-2@lo.gmane.org; Fri, 25 Feb 2011 22:16:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755096Ab1BYVQr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Feb 2011 16:16:47 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:55881 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752525Ab1BYVQr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Feb 2011 16:16:47 -0500
Received: by wwb22 with SMTP id 22so867103wwb.1
        for <git@vger.kernel.org>; Fri, 25 Feb 2011 13:16:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=N73DxV2oqXSbyOUBQl36VuNjO+1iip0J371v8m9JVX8=;
        b=Radp9xptl6Fjvb9JWu8YNi8yAgq3wZ3I1VPNRa4dZ4DjHSkQnahxBJKMjKDHmYHwcZ
         EuV7cBkNAPT72y6JL4wN1o3ptF2/2y2uid1b1KqJpRpRi9Z7I8AGwAP9MoYVyPzb6RnP
         TrT9jG3WM3Qek6Qv+Wm8yMiU1faEq+X50UTbo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=GTxHqXb4Ex+erxxAJT7/XUJVxspHse2ZoJjbUxJtdLETFJErbsQZ6HRf9Z+CpYCd7p
         Tv5yei4XNB0QtQNu5q+KflvycUjuG43YzRzA+JY74MhzVuvg1rbQnURtJ1kXgLdf0kVE
         ZGC0eDtOnT7mUuCDB6EVttWOdHJFN/A94KkRY=
Received: by 10.227.13.147 with SMTP id c19mr2544644wba.187.1298668605901;
        Fri, 25 Feb 2011 13:16:45 -0800 (PST)
Received: from elie (adsl-69-209-53-52.dsl.chcgil.ameritech.net [69.209.53.52])
        by mx.google.com with ESMTPS id 16sm255486wet.32.2011.02.25.13.16.43
        (version=SSLv3 cipher=OTHER);
        Fri, 25 Feb 2011 13:16:44 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTi=Ua=2zm3GhHJVfECJ5VcZaMnRf9MYjSONoWcP4@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167942>

(-cc: Jakub)

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> I split it up from the rest because I always tried to group
> translations with the tests they broke, and only the tests they broke
> and vice versa.
>
> It was often a lot of work figuring out what translation broke what
> tests. IIRC splitting this all took me around half a day at the time.
>
> So while it's easy to find out what message is the relevant one in
> this case, this is an attribute of the series I'd really like to keep
> for future bookkeeping. It's nice to be able to annotate a line in th=
e
> test suite and see a patch that changes *just* that message and
> related tests, not a lot of other unrelated messages.

Makes sense, and thanks for doing that.  It is nice to see the mass of
messages for each command that don't produce complications separate
from the harder ones.

Cheers,
Jonathan
