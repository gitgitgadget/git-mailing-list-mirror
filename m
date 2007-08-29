From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: Mixing cherry-pick and merge
Date: Wed, 29 Aug 2007 15:14:39 +0200
Message-ID: <20070829131439.GA31212@diana.vm.bytemark.co.uk>
References: <46D56123.4030307@objectxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Michel Marti <mma@objectxp.com>
X-From: git-owner@vger.kernel.org Wed Aug 29 15:15:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQNNv-0004ME-70
	for gcvg-git@gmane.org; Wed, 29 Aug 2007 15:15:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757107AbXH2NO4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 29 Aug 2007 09:14:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757121AbXH2NO4
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Aug 2007 09:14:56 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4869 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757079AbXH2NOz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Aug 2007 09:14:55 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1IQNNX-00088V-00; Wed, 29 Aug 2007 14:14:39 +0100
Content-Disposition: inline
In-Reply-To: <46D56123.4030307@objectxp.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56943>

On 2007-08-29 14:05:55 +0200, Michel Marti wrote:

> I just merged from a branch from which I previously cherry-picked
> some commits and now the log contains the already cherry-picked
> commits twice (which is rather confusing). Is this a bug or a
> feature?

It's an inevitable consequence of git's design. When you cherry-pick a
commit, you create a (maybe slightly modified) copy of it with
different ancestry. If you then merge a branch that contains the
original commit, you will get both the original and the copy as
ancestors of your new merge commit.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
