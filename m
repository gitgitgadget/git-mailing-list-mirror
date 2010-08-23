From: Greg Brockman <gdb@MIT.EDU>
Subject: Re: What's cooking in git.git (Aug 2010, #05; Sat, 21)
Date: Sun, 22 Aug 2010 20:47:35 -0500
Message-ID: <AANLkTin26gfGTZyo+ZzG8s-FBTvY2Q9tYgYAQ70f8Lx=@mail.gmail.com>
References: <7v4oen5clj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 23 03:47:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OnM8Z-0006g7-3e
	for gcvg-git-2@lo.gmane.org; Mon, 23 Aug 2010 03:47:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752040Ab0HWBrk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 22 Aug 2010 21:47:40 -0400
Received: from DMZ-MAILSEC-SCANNER-7.MIT.EDU ([18.7.68.36]:62774 "EHLO
	dmz-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751397Ab0HWBrk convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Aug 2010 21:47:40 -0400
X-AuditID: 12074424-b7b2bae000005b3f-78-4c71d32b5514
Received: from mailhub-auth-4.mit.edu ( [18.7.62.39])
	by dmz-mailsec-scanner-7.mit.edu (Symantec Brightmail Gateway) with SMTP id 0A.9F.23359.B23D17C4; Sun, 22 Aug 2010 21:47:23 -0400 (EDT)
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by mailhub-auth-4.mit.edu (8.13.8/8.9.2) with ESMTP id o7N1lc9u004333
	for <git@vger.kernel.org>; Sun, 22 Aug 2010 21:47:38 -0400
Received: from mail-iw0-f174.google.com (mail-iw0-f174.google.com [209.85.214.174])
	(authenticated bits=0)
        (User authenticated as gdb@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id o7N1laBj023229
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NOT)
	for <git@vger.kernel.org>; Sun, 22 Aug 2010 21:47:37 -0400 (EDT)
Received: by iwn5 with SMTP id 5so3088839iwn.19
        for <git@vger.kernel.org>; Sun, 22 Aug 2010 18:47:35 -0700 (PDT)
Received: by 10.231.171.7 with SMTP id f7mr5807791ibz.72.1282528055601; Sun,
 22 Aug 2010 18:47:35 -0700 (PDT)
Received: by 10.231.154.212 with HTTP; Sun, 22 Aug 2010 18:47:35 -0700 (PDT)
In-Reply-To: <7v4oen5clj.fsf@alter.siamese.dyndns.org>
X-Brightmail-Tracker: AAAAAxWs/CYVrP/VFa3IeA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154201>

> * gb/shell-ext (2010-07-28) 3 commits
> =A0- Add sample commands for git-shell
> =A0- Add interactive mode to git-shell for user-friendliness
> =A0- Allow creation of arbitrary git-shell commands
>
> I am not very happy about adding these backdoors to git-shell, which =
is
> primarily a security mechanism, and obviously security and backdoor d=
o not
> mix well.
That's a fair concern, and I would not feel slighted if you decided to
abandon the patches for this reason.  However, are there things we
could do to mitigate the chance of an attacker taking advantage of the
new functionality?  For example, what about requiring the git shell
user to set a config variable in order to enable the extended shell?
Or alternatively, as someone suggested previously, require the root
user to drop some enabling config into /etc?  Do you have any
particular threat models in mind?

=46or what it's worth, at this point my $project is using the git-shell
in production.  It's been a timesaver for us to just be able to give
our devs a single ssh string (git@xvm.mit.edu) and let them figure out
which repositories are available by themselves.  This will probably
become somewhat less vital once we've deployed gitweb, but even then
it will be nice to be able to do repository discovery from the command
line.

Greg
