From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [PATCH] gitweb: Better chopping in commit search results
Date: Sat, 23 Feb 2008 10:27:22 +0100
Message-ID: <20080223092722.GB1390@diana.vm.bytemark.co.uk>
References: <7vbq6kprql.fsf@gitster.siamese.dyndns.org> <20080222163035.5942.93410.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jean-Baptiste Quenot <jbq@caraldi.com>,
	Junio C Hamano <gitster@pobox.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 23 10:28:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSqg0-0002yG-I8
	for gcvg-git-2@gmane.org; Sat, 23 Feb 2008 10:28:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762684AbYBWJ1g convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 23 Feb 2008 04:27:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760970AbYBWJ1g
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Feb 2008 04:27:36 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3875 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758528AbYBWJ1e (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Feb 2008 04:27:34 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1JSqfC-0000Qb-00; Sat, 23 Feb 2008 09:27:22 +0000
Content-Disposition: inline
In-Reply-To: <20080222163035.5942.93410.stgit@localhost.localdomain>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74812>

On 2008-02-22 17:33:47 +0100, Jakub Narebski wrote:

> Strange that StGit always sends patches (stg mail) as if repo owner
> was their author, regardless of path/commit author (I think; unless
> "stg edit" cannot change authorship).

It'll always put the sender in the From: header in the mail,
obviously. But the patch mail template contains a "%(fromauth)s"
string, which will be replaced by "From: Real Author
<ra@example.com>\n", or the empty string if the patch author is the
same as the sender.

Your problem might be that you're using an old template.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
