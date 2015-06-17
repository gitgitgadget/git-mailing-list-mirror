From: "Andres G. Aragoneses" <knocte@gmail.com>
Subject: Re: [PATCH v2] git-checkout.txt: Document "git checkout <pathspec>"
 better
Date: Wed, 17 Jun 2015 19:53:06 +0200
Message-ID: <mlsc62$8u5$1@ger.gmane.org>
References: <558127CB.70603@web.de>	<CACsJy8CuRcV2Rxaz8Ut4ayW-Hyd8Aao5W4JMc20jcfggOG3d4g@mail.gmail.com>	<vpq8ubiwqo9.fsf@anie.imag.fr> <mlrmnt$te5$1@ger.gmane.org>	<vpqoaketusa.fsf@anie.imag.fr> <mlrn9r$9ho$1@ger.gmane.org>	<vpqtwu6sf4r.fsf@anie.imag.fr>	<xmqqoake4akt.fsf@gitster.dls.corp.google.com>	<xmqqd20u48at.fsf@gitster.dls.corp.google.com>	<5581A3A3.1070908@web.de> <vpqh9q6gsdt.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 17 19:53:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5HWj-0003u6-IE
	for gcvg-git-2@plane.gmane.org; Wed, 17 Jun 2015 19:53:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756251AbbFQRxZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Jun 2015 13:53:25 -0400
Received: from plane.gmane.org ([80.91.229.3]:35455 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755820AbbFQRxU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jun 2015 13:53:20 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Z5HWY-0003iy-6V
	for git@vger.kernel.org; Wed, 17 Jun 2015 19:53:18 +0200
Received: from 46.24.152.62 ([46.24.152.62])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 17 Jun 2015 19:53:18 +0200
Received: from knocte by 46.24.152.62 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 17 Jun 2015 19:53:18 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 46.24.152.62
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
In-Reply-To: <vpqh9q6gsdt.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271877>

On 17/06/15 19:24, Matthieu Moy wrote:
> Torsten B=F6gershausen <tboegi@web.de> writes:
>
>> My v3 will probably use the original line:
>> git-checkout - Checkout a branch or paths to the working tree
>
> I think mentionning "Switch branch" was a real improvement. For someo=
ne
> not familiar with the version control vocabulary, "checkout" does not
> mean much (just looked in a dictionary, it talks about payment and
> leaving a room in a hotel ...). And someone not understanding what
> "checkout" means in this context won't be helped much reading the
> description and getting "checkout" there.
>
> (Ironically, Junio did almost the same remark when I proposed to
> document "git describe" as "Describe ...", but the word "describe" do=
es
> not have the ambiguity problem that "checkout" has)
>
>> 'git checkout <commit> -- <path>'
>> will "copy" the version from another commit into the workspace.
>
> If <commit> exists, it means that the state of this path existed
> somewhere in <path> in the past (well, modulo "git add -p" and other
> ways to cheat with history).
>
> So, to me, "restore a previous version" does apply in this case. Perh=
aps
> "restore a recorded state into the worktree" (my favorite up to now I
> think).
>
> But as you say, it copies into the workspace, so "copy a previous
> version into the workspace" sounds good to me.
>
> Basically, I'm fine with anything starting with "Switch branches or",
> but please do change the headline ;-).
>

Having read all this thread, I think it's really confusing that:
1) We have this command named "checkout", as Matthieu points out.
2) This command allows different distinct operations (one for when it=20
receives a path, other for when it receives a branch, other for when it=
=20
receives a commit...).

So what I would propose is fix the root of the problem: split these=20
command in several ones, and mark the "checkout" command as deprecated=20
(it would still allow the same functions as before, but it would not be=
=20
documented, and would be announced as deprecated when used).

So then we could have a "git switch <branchname>" for switching to a=20
different branch.

Also a "git discard <path>" to discard local changes.

Etcetera.

Comments?
