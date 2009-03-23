From: Pascal Obry <pascal@obry.net>
Subject: Re: git svn teething problems - initial clone okay - fetches not
 working
Date: Mon, 23 Mar 2009 22:03:38 +0100
Organization: Home - http://www.obry.net
Message-ID: <49C7F92A.5050809@obry.net>
References: <2BACA6CC2F9647C19C0463120219E694@HPLAPTOP>
Reply-To: pascal@obry.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Aaron Gray <aaronngray.lists@googlemail.com>
X-From: git-owner@vger.kernel.org Mon Mar 23 22:06:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlrKg-0005Nt-Fe
	for gcvg-git-2@gmane.org; Mon, 23 Mar 2009 22:05:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754585AbZCWVDg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 Mar 2009 17:03:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758393AbZCWVDg
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Mar 2009 17:03:36 -0400
Received: from fg-out-1718.google.com ([72.14.220.154]:19213 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758203AbZCWVDf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Mar 2009 17:03:35 -0400
Received: by fg-out-1718.google.com with SMTP id 16so439562fgg.17
        for <git@vger.kernel.org>; Mon, 23 Mar 2009 14:03:32 -0700 (PDT)
Received: by 10.86.50.13 with SMTP id x13mr724023fgx.22.1237842210998;
        Mon, 23 Mar 2009 14:03:30 -0700 (PDT)
Received: from ?192.168.0.100? (AVelizy-154-1-49-205.w82-124.abo.wanadoo.fr [82.124.151.205])
        by mx.google.com with ESMTPS id 12sm3829484fgg.7.2009.03.23.14.03.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 23 Mar 2009 14:03:30 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; fr-FR; rv:1.8.1.21) Gecko/20090302 Thunderbird/2.0.0.21 Mnenhy/0.7.5.0
In-Reply-To: <2BACA6CC2F9647C19C0463120219E694@HPLAPTOP>
X-Enigmail-Version: 0.95.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114350>

Aaron Gray a =E9crit :
> Anyway I am having the problem that I can do a 'git svn fetch' and I =
see
> changes coming in. But the gitweb and another git clone from it do no=
t
> reflect those changes. The repository is still showing its two days o=
ld.

You need a:

   $ git svn rebase

to fetch *and* merge the changes into the local tracking branch (master
by default).

Pascal.

--=20

--|------------------------------------------------------
--| Pascal Obry                           Team-Ada Member
--| 45, rue Gabriel Peri - 78114 Magny Les Hameaux FRANCE
--|------------------------------------------------------
--|    http://www.obry.net  -  http://v2p.fr.eu.org
--| "The best way to travel is by means of imagination"
--|
--| gpg --keyserver keys.gnupg.net --recv-key F949BD3B
