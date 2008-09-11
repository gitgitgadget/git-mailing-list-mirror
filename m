From: Clark Williams <clark.williams@gmail.com>
Subject: StGit question
Date: Thu, 11 Sep 2008 12:04:06 -0500
Message-ID: <48C94F86.6080707@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 11 19:05:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kdpbb-0002CB-Nr
	for gcvg-git-2@gmane.org; Thu, 11 Sep 2008 19:05:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752150AbYIKREM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Sep 2008 13:04:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752058AbYIKREL
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Sep 2008 13:04:11 -0400
Received: from mail-gx0-f16.google.com ([209.85.217.16]:64427 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752062AbYIKREK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Sep 2008 13:04:10 -0400
Received: by gxk9 with SMTP id 9so16924410gxk.13
        for <git@vger.kernel.org>; Thu, 11 Sep 2008 10:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:x-enigmail-version:content-type
         :content-transfer-encoding;
        bh=DEJ5+o0G/dH9DIlnEEzASwRgrL6mBK2d0zo47OwNTos=;
        b=U1ihnWO6SOLIyVUBaDbQLuqE5H5BejU1j8pDwxGdRpDQxbI8HYLEUw4+L7Wtf5OutS
         +Ssl5coGwSlH+GAVpnvYWntcrOhHJWAY9MWgdmb34EEPclTuPY5BZ9OAREbDFeVdj/qj
         jzL22THj3hSDK2LlujtYwf35xhVV42tZjdKoo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :x-enigmail-version:content-type:content-transfer-encoding;
        b=F4/FNIhm876etxjIE0Ai9GhQU/DNTaDS7ooK2bOrE9saRqE0e40MVxxnjQ5PTRWHPV
         kWd4LPqXQOFF4CNh8SmLeuZRpFXdBWfEY0i9Q7ZaKveD34Wi8duh748y0OdBLNpZcxkT
         EirKXObSewhTILo7rxOh2D/t1t1NX2sC26X2Q=
Received: by 10.100.198.13 with SMTP id v13mr3748264anf.125.1221152648634;
        Thu, 11 Sep 2008 10:04:08 -0700 (PDT)
Received: from ?172.16.16.136? ( [12.68.228.100])
        by mx.google.com with ESMTPS id c14sm18784184ana.4.2008.09.11.10.04.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 11 Sep 2008 10:04:07 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.14 (X11/20080501)
X-Enigmail-Version: 0.95.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95623>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Are there any guidelines or best-practices for sharing StGit trees?

I'm working with the Linux -rt patchset and I need to be able to share my tree with
other people. What I'd *like* to do is push git tree's up to a git server, let other
people fetch them and have them be able to 'stg uncommit' to get back to my stack
state. The problem is that when someone uncommits, you lose the patch names.  If
you're trying to create an RPM out of a stack, this causes problems :).

Is there something I can do or something that we can do to StGit to make it possible
for an 'uncommit' to restore the original patch name? It looks like I could modify
the commit message, so that the first line is the patch name, but that's not very
nice for people scanning commits.

Or am I missing something completely trivial that will make my life easier?

Thanks,
Clark
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkjJT4UACgkQqA4JVb61b9d1tgCfeVNG1BkaZ9czZpeHrFumU+xW
3/kAnj307N0Wx5nLSmtIPr5d+UetAxEG
=uol3
-----END PGP SIGNATURE-----
