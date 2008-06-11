From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [RFC] git-sequencer.txt
Date: Wed, 11 Jun 2008 06:10:50 +0200
Message-ID: <200806110610.50619.chriscool@tuxfamily.org>
References: <20080607220101.GM31040@leksak.fem-net> <200806100646.36528.chriscool@tuxfamily.org> <20080610085955.GB5642@leksak.fem-net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Joerg Sommer <joerg@alea.gnuu.de>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Wed Jun 11 06:07:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6Hch-0003mf-C9
	for gcvg-git-2@gmane.org; Wed, 11 Jun 2008 06:07:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751000AbYFKEGi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Jun 2008 00:06:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750890AbYFKEGi
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jun 2008 00:06:38 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:38896 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750717AbYFKEGh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Jun 2008 00:06:37 -0400
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 9EE5C1AB2AB;
	Wed, 11 Jun 2008 06:06:35 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 4F4791AB2BA;
	Wed, 11 Jun 2008 06:06:35 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <20080610085955.GB5642@leksak.fem-net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84586>

Hi,

Le mardi 10 juin 2008, Stephan Beyer a =E9crit :
> Hi,
>
> > Maybe the sequencer can look at the filename it is passed.
> > If it is something like "$GIT_DIR/*/git-rebase--interactive-todo" t=
hat
> > can mean it is called by "git rebase --interactive".
>
> It's another variant, but then with every new sequencer-user you have=
 to
> add another entry to the "sequencer caller database".
>
> That means: if a user writes a script that uses sequencer he has to m=
ake
> changes to sequencer itself. Baaad for extensibility.

We could have config options for that. For example:

[sequenceruser "user_script1"]
	filename =3D user-script1-todo
	continuecall =3D user_script1.sh --continue

Regards,
Christian.
