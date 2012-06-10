From: konglu@minatec.inpg.fr
Subject: Re: [PATCH] git-status: Show empty directories
Date: Sun, 10 Jun 2012 20:12:56 +0200
Message-ID: <20120610201256.Horde.dB69JnwdC4BP1OOoePf1xjA@webmail.minatec.grenoble-inp.fr>
References: <1339270806-65013-1-git-send-email-muhtasib@gmail.com>
 <7vr4tnab9e.fsf@alter.siamese.dyndns.org>
 <CAA3EhHLWDtUeNB+RZA064Omwxh7SEYhSc53U0nuiSTNzioKnug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	DelSp=Yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Leila <muhtasib@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 10 20:13:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SdmdN-00082l-Vw
	for gcvg-git-2@plane.gmane.org; Sun, 10 Jun 2012 20:13:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754407Ab2FJSNB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 10 Jun 2012 14:13:01 -0400
Received: from v-smtp.minatec.grenoble-inp.fr ([147.173.216.28]:44951 "EHLO
	v-smtp.minatec.grenoble-inp.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754200Ab2FJSNA (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 10 Jun 2012 14:13:00 -0400
Received: from localhost (www02.minatec.grenoble-inp.fr [147.173.216.15])
	by v-smtp.minatec.grenoble-inp.fr (Postfix) with ESMTP id 048591A025C;
	Sun, 10 Jun 2012 20:12:57 +0200 (CEST)
Received: from reverse.completel.net (reverse.completel.net [92.103.38.66])
 by webmail.minatec.grenoble-inp.fr (Horde Framework) with HTTP; Sun, 10 Jun
 2012 20:12:56 +0200
In-Reply-To: <CAA3EhHLWDtUeNB+RZA064Omwxh7SEYhSc53U0nuiSTNzioKnug@mail.gmail.com>
User-Agent: Internet Messaging Program (IMP) H4 (5.0.17)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199615>


Leila <muhtasib@gmail.com> a =E9crit=A0:

> The question 'why are empty dirs special', is issue no 1, which I'm
> also happy to discuss. The rule empty dirs can't be added in git is
> unintuitive, as people use git to keep track of things - all things.
> So it's not about an empty dir being special, it's about how people
> use git to keep track of things. Now why might people want empty dirs
> tracked? 1) People often setup dir structure in projects before addin=
g
> any code. They often want to save that state for themselves or to
> share it with other team members.

Yup, that kind of situation is not unusual. Thus, having a reminder by
running 'git status' would help. But sharing empty dir with other team
members is another issue, no ? Even with your implementation, the user
won't be able to share empty directories.

Thanks,

Lucien Kong
