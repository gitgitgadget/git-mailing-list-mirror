From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: GSoC draft proposal: Line-level history browser
Date: Mon, 22 Mar 2010 19:38:02 +0100
Message-ID: <fabb9a1e1003221138n50e30adaxe91ac9503932c35a@mail.gmail.com>
References: <41f08ee11003200218u59c45b6dl82a8eb56cc289256@mail.gmail.com> 
	<81b0412b1003201335g7b37c51mfa3e2280210ebb7e@mail.gmail.com> 
	<4BA544FC.7050007@gmail.com> <41f08ee11003202316w2fddc5f4jebda47f325451577@mail.gmail.com> 
	<4BA61CF9.7040104@gmail.com> <41f08ee11003212052p6b0a7495j2e38f24839541ffb@mail.gmail.com> 
	<m3hbo8jr2e.fsf@localhost.localdomain> <alpine.DEB.1.00.1003221910520.7596@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jakub Narebski <jnareb@gmail.com>,
	Bo Yang <struggleyb.nku@gmail.com>, gitster@pobox.com,
	gitzilla@gmail.com, Alex Riesen <raa.lkml@gmail.com>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Mar 22 19:38:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NtmWH-00082X-J6
	for gcvg-git-2@lo.gmane.org; Mon, 22 Mar 2010 19:38:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755774Ab0CVSiZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Mar 2010 14:38:25 -0400
Received: from mail-bw0-f209.google.com ([209.85.218.209]:52583 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755761Ab0CVSiY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Mar 2010 14:38:24 -0400
Received: by bwz1 with SMTP id 1so2210529bwz.21
        for <git@vger.kernel.org>; Mon, 22 Mar 2010 11:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=okcrcZ7nLDSneiKlUbU8IQG/9WJCdALgVrpxgu1YN4A=;
        b=ZeoAwPu4GvLO4yXxE3BVpDvxAYpOMedPttPQKb/5A74fK3l5qPkFSf5sa0CMea/p2k
         zgWap+5OU6uZP5OoCZI7VZA9yWiz6cxY//ox+css6LDnWolDPlHxPXDgesay+6bGETHC
         RaCpCGMNMlBKupfvyKIE8WQxNCw1nBK1wmhJw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=MY9CpwDm72qbd2apGQMiigYjitl3kqQks+KG7DGolgTg1/ZKCs9TQU9hrnrUZ7Kyc9
         0/fcELsj55P0OMSu4tq0YkqIWZk6ORLwILoNTw0IckVmzz0uJJcf7mh5RVjlNEM1xegB
         lWJeFFOjyuJLnLTEUt8U0lQ3wZQ2Mw/tbtM1U=
Received: by 10.204.39.200 with SMTP id h8mr4909527bke.97.1269283102363; Mon, 
	22 Mar 2010 11:38:22 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.1003221910520.7596@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142956>

Heya,

On Mon, Mar 22, 2010 at 19:21, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> As to fuzzy matching of lines that could not be attributed otherwise, I
> think that that will require a lot of playing around with different ideas.
> A simple Levenshtein-Damerau is highly unlikely to be enough.

I'd recommend making this either the last milestone, or not a
milestone at all. As I noticed with git-stats such metrics might not
exist at all (or at least be too hard to find/implement), and it's
quite a bummer to not be able to implement your primary milestone ;).

-- 
Cheers,

Sverre Rabbelier
