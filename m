From: Alex Amiryan <alex@amiryan.org>
Subject: Update working copy on push without touching several files
Date: Tue, 20 Oct 2009 19:43:06 +0500
Message-ID: <4ADDCC7A.8080607@amiryan.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 20 16:43:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0Fvi-0004F5-OS
	for gcvg-git-2@lo.gmane.org; Tue, 20 Oct 2009 16:43:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752448AbZJTOnI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Oct 2009 10:43:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752428AbZJTOnH
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Oct 2009 10:43:07 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:24339 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752407AbZJTOnG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Oct 2009 10:43:06 -0400
Received: by fg-out-1718.google.com with SMTP id d23so2069944fga.1
        for <git@vger.kernel.org>; Tue, 20 Oct 2009 07:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:message-id:date:from
         :user-agent:mime-version:to:subject:x-enigmail-version:openpgp
         :content-type:content-transfer-encoding;
        bh=Fi6gvZwO5Agar8byGTLgGPP/fng+S9hu67XOrKQnHYU=;
        b=YpKvBej7zs32XNVbGpeGb5K+2ZMk/8QJAMHm+y5Se6EJcSRddBnKfkPz0c9JJ8bxaU
         6An5WpCqeaOovmMPYhjaKqktOhzH0UBR2BEgmq6z92YRxwD3JQYsTqc7TKeoOfLSV9Jq
         bRTpwmsLQFr0B1HlirW8CIl1OzK5uM+ENyhTI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:message-id:date:from:user-agent:mime-version:to:subject
         :x-enigmail-version:openpgp:content-type:content-transfer-encoding;
        b=NMtuuJMNAAEQlX55Y38v0GRXh1D2dBOrVcGe3IYqhsBVPLrCsI/ts5sOyyTJTsWmAK
         f4SwAEC5Za+2mYpczNAoCuYvhRwPUplEYr1CsXbdrteb7W3O5TRg49bRJrPN3k/HUVZh
         HIQ2MteLxgZJUW6BX06Q8Q9K2iltA9xivPFlA=
Received: by 10.86.209.23 with SMTP id h23mr3917453fgg.22.1256049789994;
        Tue, 20 Oct 2009 07:43:09 -0700 (PDT)
Received: from ?83.217.237.158? ([83.217.237.158])
        by mx.google.com with ESMTPS id d6sm614fga.15.2009.10.20.07.43.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 20 Oct 2009 07:43:09 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.23 (X11/20090812)
X-Enigmail-Version: 0.96.0
OpenPGP: id=54435131;
	url=hkp://pool.sks-keyserver.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130799>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello. I am a web site developer. My team is developing web sites
locally using git. Online versions of websites are maintained with git
too. I need to have working copy of my remote git repository (online
version of the site) updated by git push (which I do locally). The
problem is that I have some files there (like database config) that have
to be different from local ones and they must not be updated on git
push. I have made "git update-index --assume-unchanged
incs/config.db.php" but they are not being updated only when I do "git
pull" remotely. I have used some post-update hooks which I found on the
net, but they all do "git reset --hard HEAD" which restores my config
files. Can you please help me to write post-update hook which updates
remote working copy but doesn't touch my assume-unchanged marked files.

- --
Alex Amiryan
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkrdzHMACgkQ1KOfm1RDUTH3eQCgsEy+349Q/BnqLyl+6uQcZ871
lZgAn38ZlB4r5Utdt9PbxH/oCCIU2cjM
=2FQ/
-----END PGP SIGNATURE-----
