From: =?ISO-8859-1?Q?Gr=E9goire_Barbier?= <devel@gbarbier.org>
Subject: Re: Project Hosting with git ?
Date: Sat, 12 Jan 2008 18:41:50 +0100
Message-ID: <4788FBDE.6090903@gbarbier.org>
References: <912ec82a0801120553u3621c991u7c4cb4793960159c@mail.gmail.com> <9b3e2dc20801120845n15d59fe6q178ba257c12a28e0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Neshama Parhoti <pneshama@gmail.com>, git@vger.kernel.org
To: Stephen Sinclair <radarsat1@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 12 18:42:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDkNB-0005zG-Oj
	for gcvg-git-2@gmane.org; Sat, 12 Jan 2008 18:42:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755433AbYALRlr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 12 Jan 2008 12:41:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755427AbYALRlr
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Jan 2008 12:41:47 -0500
Received: from relay1-v.mail.gandi.net ([217.70.178.75]:54614 "EHLO
	relay1-v.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755133AbYALRlq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jan 2008 12:41:46 -0500
Received: from localhost (mfilter5-v.gandi.net [217.70.178.39])
	by relay1-v.mail.gandi.net (Postfix) with ESMTP id 9364E362AF;
	Sat, 12 Jan 2008 18:41:45 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at mfilter5-v.mgt.gandi.net
Received: from relay1-v.mail.gandi.net ([217.70.178.75])
	by localhost (mfilter5-v.gandi.net [217.70.178.39]) (amavisd-new, port 10024)
	with ESMTP id 4ePR0M2BOTLS; Sat, 12 Jan 2008 18:34:29 +0100 (CET)
Received: from [192.168.79.1] (soy95-1-82-229-96-169.fbx.proxad.net [82.229.96.169])
	by relay1-v.mail.gandi.net (Postfix) with ESMTP id B1C75362AA;
	Sat, 12 Jan 2008 18:41:43 +0100 (CET)
User-Agent: Thunderbird 2.0.0.9 (Windows/20071031)
In-Reply-To: <9b3e2dc20801120845n15d59fe6q178ba257c12a28e0@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70335>

Stephen Sinclair a =E9crit :
> However, git works fine over http.  I have a project on SF which I wa=
s
> using with subversion, but I recently switched the project over to
> git.

I disagree: git does not work "fine" over http, it only works fine for=20
fetch/pull.
At less with last versions, push over http/webdav does not work (and by=
=20
the way corrupts the remote repository, by changing the HEAD sha withou=
t=20
uploading related objects).
I initiated a thread about that on the list a few weeks ago, with=20
subject "git over webdav: what can I do for improving http-push ?".=20
However I did not (yet?) post a patch.

> I simply posted a bare git repo on the project website, and bang it's
> "hosted" on sourceforge.  In order to automate things a bit, I set up
> a local repo which, when I push to it, runs git-update-server-info an=
d
> then uses rsync to upload the repo changes to the SF web server.

I agree with this: if you push locally and then upload, it works fine.=20
With rsync, ftp, sftp or whatever you want.

--=20
Gr=E9goire Barbier - gb =E0 gbarbier.org - +33 6 21 35 73 49
