From: Alexei Sholik <alcosholik@gmail.com>
Subject: Re: [PATCH 2/2] Add Author and Documentation sections to git-for-each-ref.txt
Date: Wed, 9 Mar 2011 14:14:10 +0200
Message-ID: <AANLkTimyW7CMSkXndHOW9Gbvu124YYT5e-SdGUq3-OGu@mail.gmail.com>
References: <1299590170-30799-1-git-send-email-alcosholik@gmail.com>
	<1299590170-30799-3-git-send-email-alcosholik@gmail.com>
	<4D773570.4010803@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Mar 09 13:14:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PxIHR-0006sc-De
	for gcvg-git-2@lo.gmane.org; Wed, 09 Mar 2011 13:14:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932238Ab1CIMOM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Mar 2011 07:14:12 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:60070 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932181Ab1CIMOL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Mar 2011 07:14:11 -0500
Received: by wya21 with SMTP id 21so362819wya.19
        for <git@vger.kernel.org>; Wed, 09 Mar 2011 04:14:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=5L54ocAA8eVt8DraUnxpudg0Lw1VBpUqT1hDfCt4WK0=;
        b=a37n8SciSs6XJlBJ83OhRhvrWIgrXvuZLGx9cjDjyQv3ZXZNn/PgKcOIQVK7n1AZNw
         XCPST/rg3T+Gzw5E7UOzwRS8t1g7F4pET5ilDpGtDJWvbrL2bGZSJuz1yTZL+WhmC3Fi
         UDNFqUEE8J1E9BqJazSMKyklfvZYxerMp84tk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=JfnSM4B1o0MD0q9dypln1/mCavuyIZsIWnmgYcEQ8mgobWA1inKbxVvNPju9TP4pS7
         NJYfQYsno3kkFXx+45cBMq8ROnhcWm7rIIbVVcVGiZlBqDyvPWnvfSlmSGSmwWarUOA1
         Zz+o/lDhhWdC6WryN4dsDqjIOtlKTA9VaxyUc=
Received: by 10.216.90.79 with SMTP id d57mr4430955wef.65.1299672850183; Wed,
 09 Mar 2011 04:14:10 -0800 (PST)
Received: by 10.216.7.9 with HTTP; Wed, 9 Mar 2011 04:14:10 -0800 (PST)
In-Reply-To: <4D773570.4010803@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168730>

On 9 March 2011 10:08, Michael J Gruber <git@drmicha.warpmail.net> wrote:
> +Evangelisation
> ---------------
> Jeff King <peff@peff.net>
>
> Just kidding!
>
> (Jeff is the 2nd main f-e-r author, but Junio created it.)
>
> Michael ;)
>

I meant no offense. Just ran this command

git blame -p "$1" | awk '$1 ~ /author$/ { print substr($0,
length("author  "), length($0)) }' | sort | uniq -c | sort -nr

on the for-each-ref.c and saw that Junio had the first place by a
relatively large margin.

Similarly, the git-for-each-ref.txt (I used plain git blame on this
one) has mostly been composed by Junio. Surely, it's not my privilege
to decide on the list of authors, but I wonder why the original
authors haven't claimed their rightful place in the docs.

-- 
Best regards,
Alexei Sholik
