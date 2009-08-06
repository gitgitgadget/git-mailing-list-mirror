From: Philip Herron <herron.philip@googlemail.com>
Subject: Re: Hash Tables
Date: Thu, 06 Aug 2009 06:17:10 +0100
Message-ID: <4A7A6756.4010305@googlemail.com>
References: <4A7A5D9C.7000604@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 06 07:17:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYvMF-0003rq-Hn
	for gcvg-git-2@gmane.org; Thu, 06 Aug 2009 07:17:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753339AbZHFFRO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Aug 2009 01:17:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753279AbZHFFRN
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Aug 2009 01:17:13 -0400
Received: from mail-ew0-f214.google.com ([209.85.219.214]:34652 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752060AbZHFFRN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Aug 2009 01:17:13 -0400
Received: by ewy10 with SMTP id 10so520545ewy.37
        for <git@vger.kernel.org>; Wed, 05 Aug 2009 22:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:references:in-reply-to
         :x-enigmail-version:openpgp:content-type:content-transfer-encoding;
        bh=fAfHhC17Oela7QGDzRM7FEEjZyz/uWnoB8dgNKMBME0=;
        b=Hfn/rM9d3AKgJyhijAiLSpfFkA3BmRRPxIL5nEmaYzxQJijnoIC8xU2YrING6Md2QE
         YVLzuavTBOl74My/5Nhv6Tv0oB0sT2JPB0aShSt9kZ/mWVvCZWc7EUD27K3IqRPX+vk4
         ed6hl2CfrxRIf4FWL3U4JTc0P65r63IiwCe50=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:x-enigmail-version:openpgp:content-type
         :content-transfer-encoding;
        b=V9MLjTPJMZ42i5Dp4HbjuTTIfiUuijF+cbo+l1108qfAJxaAqB//uPnXHQRJV5IQiV
         x1YJlV3dkUoOkhoWIwcMsmtuCZa0bxi1JToHZ43696R/kZqjLqzur8wOnqcfNDOewjEn
         YwcHGDKULbwERbsV7Bh4kFfprI4DivLwFrq7k=
Received: by 10.210.65.1 with SMTP id n1mr1892783eba.28.1249535832971;
        Wed, 05 Aug 2009 22:17:12 -0700 (PDT)
Received: from ?192.168.1.12? (host86-141-209-104.range86-141.btcentralplus.com [86.141.209.104])
        by mx.google.com with ESMTPS id 7sm3361034eyb.30.2009.08.05.22.17.11
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 05 Aug 2009 22:17:12 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.22 (X11/20090608)
In-Reply-To: <4A7A5D9C.7000604@googlemail.com>
X-Enigmail-Version: 0.95.7
OpenPGP: url=http://keyserver.ubuntu.com:11371/
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125041>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hey

Sorry for the mail i played around with the hash.c and i see how it
works now! Feel little bit stupid what threw me off was the  alloc_nr(
); but its defined to #define alloc_nr(x) (((x)+16)*3/2) which is
quite nice.

and the nr threw me off but i see how it works now its actually the
similar as what i was doing in my program, but your grow table was
better because of alloc_nr acts like a threshold to grow and scale
better, mine just added on another chunk of 32 elements just because
it seemed like a good number to get something working.

Question still stands is the hashing function one, which one and why?

Thanks loads, Sorry for bad posts!

- --Phil
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAkp6Z1UACgkQAhcOgIaQQ2FvQwCdGAgcuAUNG2/YyyzhXct3J2qc
azwAninE/8I+Z4T4h294tCzXlLzmyGqW
=Vahj
-----END PGP SIGNATURE-----
