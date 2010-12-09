From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 0/2] [RFD] Using gitrevisions :/search style with other
 operators
Date: Wed, 8 Dec 2010 19:59:26 -0600
Message-ID: <20101209015926.GA31119@burratino>
References: <1291820319-12455-1-git-send-email-pclouds@gmail.com>
 <201012082051.09730.jnareb@gmail.com>
 <AANLkTimU6Bhx-2XsZ45_7BmT9fo9MpK8TJWB3zZ=j-i7@mail.gmail.com>
 <201012090254.24999.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Kevin Ballard <kevin@sb.org>, Yann Dirson <dirson@bertin.fr>,
	Jeff King <peff@peff.net>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 09 02:59:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQVnP-00082a-5q
	for gcvg-git-2@lo.gmane.org; Thu, 09 Dec 2010 02:59:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932115Ab0LIB7n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Dec 2010 20:59:43 -0500
Received: from mail-qy0-f177.google.com ([209.85.216.177]:44282 "EHLO
	mail-qy0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753243Ab0LIB7m (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Dec 2010 20:59:42 -0500
X-Greylist: delayed 8053 seconds by postgrey-1.27 at vger.kernel.org; Wed, 08 Dec 2010 20:59:42 EST
Received: by qyk27 with SMTP id 27so1335597qyk.1
        for <git@vger.kernel.org>; Wed, 08 Dec 2010 17:59:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=ERAZgqVXcyb11Tq5njZwqjui24uThOS24fGxuzHvOfA=;
        b=hT3IUd7qnqmQuwQGYdtbWU1Ee9Yp4kOsEii22yUy/Kbtq//A+FHqhP0gx7dlwObqCi
         9Lt3/QXsGHnLVwT1lxE990sRinQFCZ3g+iNF4wEye4WLnQAVrB7wWbcuq/YxxOpGz5BJ
         BfeiryEn58n7e/ITmJExL8o8svHtDlBfHxetI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=FFfemaDkcWGVB1c7/zr+K9Jasn/Ict9YFYb+gn8hUUG0vyTspnwDlmQOskd432T3wY
         aVxl7soReoX2CK3NUBW2oQdWqMpuKVsD47w9AeOcgIOnpCAgxZRKpSf2c9qUfVOtbII9
         TL5WjPziEvX1Mcc+hrXvV9QOMC9ZwFIsJSb3s=
Received: by 10.220.187.70 with SMTP id cv6mr1460593vcb.226.1291859981217;
        Wed, 08 Dec 2010 17:59:41 -0800 (PST)
Received: from burratino (adsl-69-209-58-175.dsl.chcgil.ameritech.net [69.209.58.175])
        by mx.google.com with ESMTPS id d14sm376327vcx.23.2010.12.08.17.59.39
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 08 Dec 2010 17:59:40 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <201012090254.24999.jnareb@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163256>

Jakub Narebski wrote:

> You would need HEAD{^{/foo}^@}x3, or use special rule that HEAD^{/foo}x2
> means really HEAD^{/foo}^@^{/foo}, with ^@ used to join them.

That said, does ^2x500 really do something meaningful that a person
would ever need?  I like the

	^{:nth(3)/foo}

syntax because perl6 supports m:nth(3)/foo/, suggesting a menu of
already-defined modifiers to implement when they prove useful, known
already to a certain subset of the audience and proven useful already
in a different context.
