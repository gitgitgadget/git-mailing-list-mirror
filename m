From: Andreas Ericsson <ae@op5.se>
Subject: Re: upgrading GIT from version 1.7.0.4 to 1.7.6.1.
Date: Mon, 19 Sep 2011 14:49:53 +0200
Message-ID: <4E773A71.6020905@op5.se>
References: <1316435430491-6808156.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?ISO-8859-15?Q?Mika=EBl?= <mikael.donini@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 19 14:50:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R5dIc-0007Pv-SW
	for gcvg-git-2@lo.gmane.org; Mon, 19 Sep 2011 14:50:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755956Ab1ISMt6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 19 Sep 2011 08:49:58 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:48758 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755728Ab1ISMt6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Sep 2011 08:49:58 -0400
Received: by bkbzt4 with SMTP id zt4so5261640bkb.19
        for <git@vger.kernel.org>; Mon, 19 Sep 2011 05:49:56 -0700 (PDT)
Received: by 10.204.142.2 with SMTP id o2mr1617360bku.26.1316436594811;
        Mon, 19 Sep 2011 05:49:54 -0700 (PDT)
Received: from vix.int.op5.se (sth-vpn1.op5.com. [193.201.96.49])
        by mx.google.com with ESMTPS id fc13sm13651525bkc.0.2011.09.19.05.49.53
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 19 Sep 2011 05:49:54 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; rv:1.9.2.20) Gecko/20110831 Fedora/3.1.12-2.fc14 Thunderbird/3.1.12 ThunderGit/0.1a
In-Reply-To: <1316435430491-6808156.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181677>

On 09/19/2011 02:30 PM, Mika=EBl wrote:
>=20
> 1- Is it possible to have two GIT installations pointing on the same=20
> repositories?
>=20

The core structure and layout of a git repository hasn't changed
since may 2005, so it should work just fine provided you use any
git version that actually has a version number.

We've upgraded in a hodge-podge fashion at $dayjob. One of our
servers is still running 1.4.something. We've never even come close
to anything resembling a problem. It's actually a bit weird, since
we started using git in late 2005 and it's so far been the most
reliable and backwards-compatible piece of software we have in the
company pretty much ever since.

>=20
> 2- Do you have any suggestions, trips, hints and best practices in
> order to upgrade GIT in such a context?
>=20

Since you have such high demands on problem-free migration, I suggest
setting up a repo server running the new git (on the server side) and
having some people test against the new git with both old and new git,
as well as testing new git against the old servers.

Just get a backup first. I'm 99.9999999999999% sure you won't need it
because of anything git does, but better safe than sorry, eh?

--=20
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
