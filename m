From: =?ISO-8859-1?Q?Ask_Bj=F8rn_Hansen?= <ask@develooper.com>
Subject: Re: parent-filter loses my merged branch -- what am I doing wrong?
Date: Tue, 20 Jan 2009 12:05:30 -0800
Message-ID: <EA6D5B1E-DA22-4E57-86B6-A192090FCE53@develooper.com>
References: <7578B9A6-BF81-4096-B0FD-F433AD62A41E@develooper.com> <49743CB7.4030300@viscovery.net>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Jan 20 21:07:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPMsD-0006Zr-Sx
	for gcvg-git-2@gmane.org; Tue, 20 Jan 2009 21:06:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755923AbZATUFe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Jan 2009 15:05:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755446AbZATUFd
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Jan 2009 15:05:33 -0500
Received: from x8.develooper.com ([216.52.237.208]:55677 "EHLO
	x8.develooper.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755194AbZATUFd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Jan 2009 15:05:33 -0500
Received: (qmail 397 invoked from network); 20 Jan 2009 20:05:31 -0000
Received: from dsl081-039-130.lax1.dsl.speakeasy.net (HELO dhcp221.bur.sol) (ask@mail.dev@64.81.39.130)
  by smtp.develooper.com with (AES128-SHA encrypted) SMTP; 20 Jan 2009 20:05:31 -0000
In-Reply-To: <49743CB7.4030300@viscovery.net>
X-Mailer: Apple Mail (2.930.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106513>


On Jan 19, 2009, at 0:41, Johannes Sixt wrote:

> Ask Bj=F8rn Hansen schrieb:
>> On Sam Villain's recommendation I'm spending a bit of time cleaning =
=20
>> up
>> the branches and merges with git filter-branch, but I don't think I'=
m
>> quite understanding how it's supposed to work.
>
> Don't use --parent-filter for this; use grafts. You can see the =20
> history in
> gitk right away. Later run filter-branch without a filter (except =20
> perhaps
> the tag-name-filter).

Aha - excellent.  I didn't understand clearly from the documentation =20
that they'd be "written in stone" by filter-branch.  Building the =20
grafts with .git/info/grafts was much much easier.


   - ask

--=20
http://develooper.com/ - http://askask.com/
