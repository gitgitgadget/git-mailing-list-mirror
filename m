From: Raymond Auge <raymond.auge@liferay.com>
Subject: [git-svn] How to produce log of only remotes/git-svn regardless of 
	current branch
Date: Tue, 20 Jul 2010 12:08:56 -0400
Message-ID: <AANLkTimmXzi17GdT199-YiP2nWmmsU4-YW2wd2objWdb@mail.gmail.com>
References: <AANLkTilX2SN8CFTkrHDaIx3NvhlQACYRq-QLPUVW3IJh@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 20 18:09:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ObFNe-00035x-Uz
	for gcvg-git-2@lo.gmane.org; Tue, 20 Jul 2010 18:09:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760904Ab0GTQJM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Jul 2010 12:09:12 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:36800 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758567Ab0GTQJK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Jul 2010 12:09:10 -0400
Received: by gwj18 with SMTP id 18so2729649gwj.19
        for <git@vger.kernel.org>; Tue, 20 Jul 2010 09:09:10 -0700 (PDT)
Received: by 10.101.171.20 with SMTP id y20mr6827827ano.150.1279642136779; 
	Tue, 20 Jul 2010 09:08:56 -0700 (PDT)
Received: by 10.101.47.11 with HTTP; Tue, 20 Jul 2010 09:08:56 -0700 (PDT)
In-Reply-To: <AANLkTilX2SN8CFTkrHDaIx3NvhlQACYRq-QLPUVW3IJh@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151322>

Hello All,

In trying to produce a log of only remotes/git-svn regardless of
current branch, I've tried many variations of:

--branches[=3Dpattern]
--tags[=3Dpattern]
--remotes[=3Dpattern]

with no luck.

e.g.

git --no-pager log --name-status --no-color -p -n 20=C2=A0--remotes=3Dr=
emotes/git-svn

Any ideas?
