From: Philip Herron <herron.philip@googlemail.com>
Subject: Hash Tables
Date: Thu, 06 Aug 2009 05:35:40 +0100
Message-ID: <4A7A5D9C.7000604@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 06 06:36:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYuiR-0002Yz-AL
	for gcvg-git-2@gmane.org; Thu, 06 Aug 2009 06:36:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751205AbZHFEfo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Aug 2009 00:35:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751287AbZHFEfn
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Aug 2009 00:35:43 -0400
Received: from mail-ew0-f214.google.com ([209.85.219.214]:40897 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750785AbZHFEfm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Aug 2009 00:35:42 -0400
Received: by ewy10 with SMTP id 10so508673ewy.37
        for <git@vger.kernel.org>; Wed, 05 Aug 2009 21:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:x-enigmail-version:openpgp
         :content-type:content-transfer-encoding;
        bh=Dtd5zehxzRS2Vawsqy7f96dCjGugXahnldLDUHjIw7I=;
        b=apNEU7qZ/2EtKbTrwIEju3rR6hWQRYsVAgyvfGqoRaJHNUwnJvdDGOpiI6qNYLWJMh
         Diqn8jlvnPkkCtbQu66XmHQbonW/V0Sd0M019jcQa73nNClEK58vR3uA+PovT8BKoNhM
         NAOPICXpCBOJrkZiA0AG68ueg3hWFUFBLijRA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :x-enigmail-version:openpgp:content-type:content-transfer-encoding;
        b=PnsiBSMC06WPFXkS6dWqZTy0rSJbjXPSm3XExkikXk2xcAF1GKRTJnpRM+lS7XiYre
         VqEUFCRVYJ4Eh9m4L3wglMdtHjFJw819qxf3eSDcafIDE/N+qoKZYpEhq0YTgZWskCb1
         CG05z+oxUnMx/7W8kmi7okHGbgqaMfz24Rwjs=
Received: by 10.210.77.14 with SMTP id z14mr1070946eba.90.1249533342822;
        Wed, 05 Aug 2009 21:35:42 -0700 (PDT)
Received: from ?192.168.1.12? (host86-141-209-104.range86-141.btcentralplus.com [86.141.209.104])
        by mx.google.com with ESMTPS id 7sm1876914eyb.20.2009.08.05.21.35.41
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 05 Aug 2009 21:35:42 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.22 (X11/20090608)
X-Enigmail-Version: 0.95.7
OpenPGP: url=http://keyserver.ubuntu.com:11371/
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125037>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hey guys

This is my first time posting to git mailing-list didn't get much
response from irc.

I've been loving git and just been poking at its hash tables in
hash.{c,h}, which are very nice. I've been implementing my own hash
tables and i have some questions on how you guys done it.

1 - Are you using the sha1.c as your hashing function? And why did you
choose it, I have been playing with a few different ones to see how it
goes.

2 -table lookup i see your hash_table has an unsigned int nr, not
quite sure what that is for num_remaing      or something is what i
first thought.
    But i see in your table lookup you use hash % size and it returns
an index to the array. And would love       to  know how that works.
Is size the current number of hash entries in the table?

3 - what is the initial table size as in when you first insert an
entry into the table, the array must be                allocated to a
length, and you grow when you reach a threshold.

Anyways thanks!

- --Phil
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAkp6XZsACgkQAhcOgIaQQ2HWGgCfU6l909k7/JK3gf6BB2Cu35xB
jBIAn2Jl6UWp5ZvTXJxUWc91tgn//z25
=6l91
-----END PGP SIGNATURE-----
