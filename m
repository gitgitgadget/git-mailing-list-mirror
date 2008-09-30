From: Bruce Stephens <bruce.stephens@isode.com>
Subject: Re: How Blobs Work ( Blobs Vs. Deltas)
Date: Tue, 30 Sep 2008 16:28:21 +0100
Message-ID: <80vdwd64bu.fsf@tiny.isode.net>
References: <16946e800809300814v134a42dft37becdbd8aa7669a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 30 17:29:37 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KkhAM-0000Qi-Do
	for gcvg-git-2@gmane.org; Tue, 30 Sep 2008 17:29:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752842AbYI3P2Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Sep 2008 11:28:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752832AbYI3P2Y
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Sep 2008 11:28:24 -0400
Received: from rufus.isode.com ([62.3.217.251]:51624 "EHLO rufus.isode.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752595AbYI3P2Y (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Sep 2008 11:28:24 -0400
Received: from tiny.isode.net (shiny.isode.com [62.3.217.250]) 
          by rufus.isode.com (smtp internal) via TCP with SMTP 
          id <SOJFlQAxOW59@rufus.isode.com> for <git@vger.kernel.org>;
          Tue, 30 Sep 2008 16:28:21 +0100
Received: by tiny.isode.net (sSMTP sendmail emulation);
          Tue, 30 Sep 2008 16:28:21 +0100
X-Hashcash: 1:20:080930:git@vger.kernel.org::XCrho1DDYOAQ/S7t:0000000000000000000000000000000000000000000HRC
In-Reply-To: <16946e800809300814v134a42dft37becdbd8aa7669a@mail.gmail.com> (Feanil Patel's message of "Tue\, 30 Sep 2008 10\:14\:06 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97127>

"Feanil Patel" <feanil@gmail.com> writes:

> I was reading about git objects on The Git
> Book(http://book.git-scm.com/1_the_git_object_model.html) which was
> posted on the mailing list a while back and I was wondering something
> about blobs and how files are stored in any particular version.

[...]

> The Book was saying Git does not use delta storage so does this mean
> that there are two almost identical copies of the file with the
> difference being the change that was put in from version one to
> version two?

There might be.  git may also end up using deltas, see
<http://book.git-scm.com/7_the_packfile.html>.
