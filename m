From: Teemu Likonen <tlikonen@iki.fi>
Subject: Re: "add -p" + filenames with UTF-8 multibyte characters = "No changes"
Date: Sun, 15 Feb 2009 20:59:07 +0200
Message-ID: <87tz6vr0g4.fsf@iki.fi>
References: <2b8265360902151040t49711942udd4862cc9df01da5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Antonio =?iso-8859-1?Q?Garc=EDa_Dom=EDnguez?= 
	<nyoescape@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 15 20:00:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYmEI-0003U3-T3
	for gcvg-git-2@gmane.org; Sun, 15 Feb 2009 20:00:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754901AbZBOS7N convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 15 Feb 2009 13:59:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754596AbZBOS7L
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Feb 2009 13:59:11 -0500
Received: from mta-out.inet.fi ([195.156.147.13]:46292 "EHLO kirsi2.inet.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751262AbZBOS7K (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Feb 2009 13:59:10 -0500
Received: from mithlond.arda.local (80.220.180.181) by kirsi2.inet.fi (8.5.014)
        id 48FC5B89051CD1B5; Sun, 15 Feb 2009 20:59:08 +0200
Received: from dtw by mithlond.arda.local with local (Exim 4.69)
	(envelope-from <tlikonen@iki.fi>)
	id 1LYmCp-0005dq-OH; Sun, 15 Feb 2009 20:59:07 +0200
In-Reply-To: <2b8265360902151040t49711942udd4862cc9df01da5@mail.gmail.com>
 ("Antonio =?iso-8859-1?Q?Garc=EDa_Dom=EDnguez=22's?= message of "Sun\, 15
 Feb 2009 19\:40\:11 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110032>

On 2009-02-15 19:40 (+0100), Antonio Garc=EDa Dom=EDnguez wrote:

> I seem to have run into a bug in "add -p" and "add -i" when trying to
> stage diff hunks in tracked files with UTF-8 multibyte characters
> (such as "=E1"). If I add "=E1", commit, then modify it and try to ru=
n
> "add -p" on it, Git reports "No changes". "add -i" doesn't do
> anything, either.
>
> I've switched to 1.6.2.rc0.90.g0753 and the problem persists. If it
> helps, I've attached a small shell script with a minimal recipe for
> triggering the bug.

This bug is documented in BUGS section of "git add" manual (see "git
help add"). You can work it around with

    git config --global core.quotepath false
