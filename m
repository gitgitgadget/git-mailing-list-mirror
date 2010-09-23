From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Listing files in order they are changed
Date: Thu, 23 Sep 2010 13:48:07 -0700 (PDT)
Message-ID: <m3pqw4gpb2.fsf@localhost.localdomain>
References: <AANLkTimHrCujEggj9KbAWWivY+WxnL0YqsXs+idhymBA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Parag Kalra <paragkalra@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 23 22:48:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OysiH-0006Tj-J8
	for gcvg-git-2@lo.gmane.org; Thu, 23 Sep 2010 22:48:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756544Ab0IWUsM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 23 Sep 2010 16:48:12 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:38757 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755358Ab0IWUsL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Sep 2010 16:48:11 -0400
Received: by wyb28 with SMTP id 28so1299399wyb.19
        for <git@vger.kernel.org>; Thu, 23 Sep 2010 13:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=zcR/LuQpVDwTjb9naw1F1xYv8ogszJNtFCqWh+cDvRU=;
        b=M87LbtHQsdrJh3EiWAFQsxV4nTyzyIVIhPbWaQgnEwzCgphejEna3UyfQV14wNejH+
         yoD1Zl9tlUnJzSBZbMedEhgBSN1+AUNbvggneYsRSrnwppF5qu2Vpq5WILCMYGbF6Lm6
         YahZiNgp4Gdaoab2VbLFgunk0BvmoxYIJhWds=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        b=RaDfaJgLKW487WLiLkii5zqvW+PiAWLwOK+XRA7ykIAKgxp4RptaLvOdxJwjO58xAq
         4+oJIy84jAfStrCmjj4fZl7KmqBMWBQLysNhtVZU2s6VTu8oUXJB+HEZIbW7nahoZ9xT
         o7nWzXAgEin6DWIs7s2ue89iQ/t/GNeDCN6ik=
Received: by 10.227.134.135 with SMTP id j7mr1048684wbt.17.1285274888302;
        Thu, 23 Sep 2010 13:48:08 -0700 (PDT)
Received: from localhost.localdomain (abvh105.neoplus.adsl.tpnet.pl [83.8.205.105])
        by mx.google.com with ESMTPS id bj11sm863798wbb.4.2010.09.23.13.48.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 23 Sep 2010 13:48:07 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o8NKleJN022660;
	Thu, 23 Sep 2010 22:47:50 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o8NKlTK2022654;
	Thu, 23 Sep 2010 22:47:29 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <AANLkTimHrCujEggj9KbAWWivY+WxnL0YqsXs+idhymBA@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156907>

Parag Kalra <paragkalra@gmail.com> writes:

> Is there a way I can make Git list all the tracked=A0files in the
> working directory=A0in order they are changed (modified, added or
> deleted)
>=20
> Something like displayed by: git ls-files

No, it is currently not possible, mainly because git thinks in terms
of changes to project as a whole, not as changes to individual files.

The tree blame ("git blame <directory>"), if it existed (I have
working prototype), would be of use here.
--=20
Jakub Narebski
Poland
ShadeHawk on #git
