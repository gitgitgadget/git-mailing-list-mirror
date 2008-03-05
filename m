From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] user.default: New config to prevent using the default values for user.*
Date: Wed, 05 Mar 2008 13:01:46 -0800 (PST)
Message-ID: <m3mypchol6.fsf@localhost.localdomain>
References: <1204744684-2043-1-git-send-email-sbejar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?iso-8859-15?q?Santi_B=E9jar?= <sbejar@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 05 22:02:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JX0kt-0000IW-FO
	for gcvg-git-2@gmane.org; Wed, 05 Mar 2008 22:02:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753683AbYCEVBt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 5 Mar 2008 16:01:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754633AbYCEVBt
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Mar 2008 16:01:49 -0500
Received: from wa-out-1112.google.com ([209.85.146.183]:10403 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752919AbYCEVBt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Mar 2008 16:01:49 -0500
Received: by wa-out-1112.google.com with SMTP id v27so1882681wah.23
        for <git@vger.kernel.org>; Wed, 05 Mar 2008 13:01:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:content-transfer-encoding:date;
        bh=4jAiaPHWYhz476CFfRpG3JhqqhZrB7mG8RqaKdR914Y=;
        b=xRW7b3uyWoMdcQJHmC9xlcvFBrys3PQGAh/UbFaCjIDaaxJ7CfEZTu+bAzE0gNoqS8TVf/JvAOMuDtR57eZ9vseSjyalK2wywWC+ka72mGKlicoLWkSDZPATo3tGa1TL/vtN5lUw8cbw6Hu5diy1xkz9MQ4op665kc7EIW+guSc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:content-transfer-encoding:date;
        b=wazLxtEUH99uMJn+BbWXUxrzw5J75MLKNpvAHw4/7Trswx+nuE6/l/ve5yxkO4dqA7UXwux72/qwKvhy1d4z9OzDNfgM3pvD0sn3dL8rUxJNKbrfqLjnNW6jUpFM/l7gPQhRP4IVCjgDgTNQ6g+aKZy7zvrr9jFIB5QEuk6/i8g=
Received: by 10.115.33.1 with SMTP id l1mr5288359waj.137.1204750907601;
        Wed, 05 Mar 2008 13:01:47 -0800 (PST)
Received: from localhost.localdomain ( [83.8.248.32])
        by mx.google.com with ESMTPS id o1sm4100786uge.1.2008.03.05.13.01.42
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 05 Mar 2008 13:01:46 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m25L1wO7025831;
	Wed, 5 Mar 2008 22:01:58 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m25L1vLX025828;
	Wed, 5 Mar 2008 22:01:57 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1204744684-2043-1-git-send-email-sbejar@gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76264>

Santi B=E9jar <sbejar@gmail.com> writes:

> Useful when you want a different email/name for each repository

> +user.default::
> +	If false the defaults values for user.email and user.name are not
> +	used. Useful when you want a different email/name for each
> +	repository, normally set in the global config file.
> +

Wouldn't it be better to use user.noDefault, or user.explicit,
or user.dontGuess... user.default seems like place to provide
some default value, not place to decide if there should be some
fallback default values or not.

--=20
Jakub Narebski
Poland
ShadeHawk on #git
