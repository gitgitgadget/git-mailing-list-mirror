From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: stg branch -r instructions
Date: Mon, 17 Mar 2008 14:42:38 +0100
Message-ID: <20080317134238.GA1271@diana.vm.bytemark.co.uk>
References: <87d4ptczu8.fsf@lysator.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Catalin Marinas <catalin.marinas@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: David =?iso-8859-1?Q?K=E5gedal?= <davidk@lysator.liu.se>
X-From: git-owner@vger.kernel.org Mon Mar 17 14:43:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JbFci-0000BT-QM
	for gcvg-git-2@gmane.org; Mon, 17 Mar 2008 14:43:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752996AbYCQNmx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 17 Mar 2008 09:42:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753111AbYCQNmx
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Mar 2008 09:42:53 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3482 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752954AbYCQNmx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Mar 2008 09:42:53 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1JbFbq-0000QL-00; Mon, 17 Mar 2008 13:42:38 +0000
Content-Disposition: inline
In-Reply-To: <87d4ptczu8.fsf@lysator.liu.se>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77431>

On 2008-03-17 13:14:07 +0100, David K=E5gedal wrote:

> so, the usage string is wrong. In fact, the described usage string
> is only for the default action to create a new branch.

Yes, this is far from pretty.

> Maybe it would have been better to have separate stg subcommands?
>
>   stg branch NAME [COMMIT]
>   stg list-branches
>   stg rename-branch OLD NEW
>   ... etc ...

My first thought was another level of subcommands:

  stg branch NAME [COMMIT]
  stg branch list
  stg branch rename OLD NEW

But this would create ambiguities -- how do I create a branch called
"list"?. One could go with something like

  stg branch NAME [COMMIT]
  stg branch/list
  stg branch/rename OLD NEW

but this is highly non-standard, and would probably confuse every
single new user. Perhaps with dashes instead:

  stg branch NAME [COMMIT]
  stg branch-list
  stg branch-rename OLD NEW

Which is essentially what you proposed, but with more regular (and
more tab-completion-friendly) names.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
