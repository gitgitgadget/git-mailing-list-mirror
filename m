From: Ronan Keryell <Ronan.Keryell@hpc-project.com>
Subject: Re: Recovering Committed Changes in a Detached Head?
Date: Sun, 09 Oct 2011 09:46:31 +0200
Message-ID: <87k48efvzc.fsf@an-dro.info.enstb.org>
References: <1318107488.5865.46.camel@R0b0ty>
	<20111008213741.GA24409@goldbirke>
	<ab706826-75df-4410-941e-6b40ec92713c@email.android.com>
	<CACsJy8CsMCju7joj2B2xbBSTF1vHjyuFeSZyPhTJisO2sU-Fqg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 09 09:46:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RCo5r-0003pO-Ed
	for gcvg-git-2@lo.gmane.org; Sun, 09 Oct 2011 09:46:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751801Ab1JIHqh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Oct 2011 03:46:37 -0400
Received: from minou.info.enstb.org ([193.50.97.146]:32918 "EHLO
	minou.info.enstb.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751189Ab1JIHqg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 Oct 2011 03:46:36 -0400
Received: from an-dro.info.enstb.org (localhost [127.0.0.1])
	by minou.info.enstb.org (8.14.4/8.14.4/Debian-2) with ESMTP id p997kV11011958;
	Sun, 9 Oct 2011 09:46:33 +0200
In-Reply-To: <CACsJy8CsMCju7joj2B2xbBSTF1vHjyuFeSZyPhTJisO2sU-Fqg@mail.gmail.com>
	(Nguyen Thai Ngoc Duy's message of "Sun, 9 Oct 2011 16:52:11 +1100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183187>

>>>>> On Sun, 9 Oct 2011 16:52:11 +1100, Nguyen Thai Ngoc Duy <pclouds@=
gmail.com> said:

    Nguyen> On Sun, Oct 9, 2011 at 9:00 AM, Martin Fick <mfick@codeauro=
ra.org> wrote:

    >> While rflog is cool, I can't help but think that git could be
    >> even more helpful for these scenarios.

    >> First, maybe git could create refs for these automatically,
    >> perhaps with a name like orphans/1? =C2=A0Maybe these refs would=
 only
    >> be visible via git branch --orphans.

    Nguyen> If I remember correctly, we don't have private ref
    Nguyen> namespace, any refs created automatically this way could be
    Nguyen> pushed out by accident.

A way to avoid this could be to deal with this like git-stash works,
instead of relying on the branch machinery.

But anyway, I think there is a trade-off between keeping some reference=
s
to some hypothetical future use and preventing the garbage collector to
reclaim useless objects...
--=20
  Ronan KERYELL                      |\/  Phone:  +1 408 844 HPC0
  HPC Project, Inc.                  |/)  Cell:   +33 613 143 766
  5201 Great America Parkway #3241   K    Ronan.Keryell@hpc-project.com
  Santa Clara, CA 95054              |\   skype:keryell
  USA                                | \  http://hpc-project.com
