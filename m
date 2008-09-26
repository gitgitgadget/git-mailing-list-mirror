From: Yann Dirson <ydirson@altern.org>
Subject: Re: [RFC PATCH] detection of directory renames
Date: Fri, 26 Sep 2008 21:06:14 +0200
Message-ID: <20080926190614.GA4985@nan92-1-81-57-214-146.fbx.proxad.net>
References: <7vfxojtr9t.fsf@gitster.siamese.dyndns.org> <20080925213819.27029.47944.stgit@gandelf.nowhere.earth> <m3bpyb3jci.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 26 21:06:29 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KjIdW-0006QP-25
	for gcvg-git-2@gmane.org; Fri, 26 Sep 2008 21:05:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752463AbYIZTEc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Sep 2008 15:04:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752642AbYIZTEc
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Sep 2008 15:04:32 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:50141 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752311AbYIZTEb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Sep 2008 15:04:31 -0400
Received: from smtp3-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp3-g19.free.fr (Postfix) with ESMTP id ECE6917B5B2;
	Fri, 26 Sep 2008 21:04:28 +0200 (CEST)
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id C75E517B5BD;
	Fri, 26 Sep 2008 21:04:28 +0200 (CEST)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id 5C5981F0C2; Fri, 26 Sep 2008 21:06:14 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <m3bpyb3jci.fsf@localhost.localdomain>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96883>

On Thu, Sep 25, 2008 at 04:19:20PM -0700, Jakub Narebski wrote:
> Wonderfull!!!

Wow, I love this feedback :)

> I like it very much, and hope that it would get improved. And that you
> would be able to use it in merges too, to allow for example for new
> files to be created in renamed directory instead of old one which does
> not exist any longer (c.f. http://www.markshuttleworth.com/archives/123
> and following articles).

Yes, that's one of planned things.  Along the same line (once renames
are stabilized), I think about extending things so that "split dirs"
are detected as well, so merge can flag a conflict when there is a
doubt that a file would really be added in a "split directory".  The
situation may be obvious in my example (arm/ contents dispatched into
bar/ and moved/), but may also be useful when we can detect that a
significant number of files have been moved out of a directory.

> For the future, could you show examples with --abbrev option in use? TIA.

Good idea.

Best regards,
-- 
Yann
