From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: jgit merge question
Date: Wed, 14 Jan 2009 15:12:22 -0800
Message-ID: <20090114231222.GB10179@spearce.org>
References: <S1760244AbZANHqN/20090114074613Z+1959@vger.kernel.org> <4EDE3D74-CEA3-473C-ADD1-03B79AAB9EDF@asu.edu> <alpine.DEB.1.00.0901141124460.3586@pacific.mpi-cbg.de> <20090114153034.GZ10179@spearce.org> <AB447EEF7BAAB7489B29A4F3F788D02C01CDD792@EX07.asurite.ad.asu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Birchfield <dbirchfield@asu.edu>
X-From: git-owner@vger.kernel.org Thu Jan 15 00:13:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNEvk-0002Ou-2S
	for gcvg-git-2@gmane.org; Thu, 15 Jan 2009 00:13:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756265AbZANXMZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2009 18:12:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755992AbZANXMY
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jan 2009 18:12:24 -0500
Received: from george.spearce.org ([209.20.77.23]:56440 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755204AbZANXMX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2009 18:12:23 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id BC3DC38210; Wed, 14 Jan 2009 23:12:22 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <AB447EEF7BAAB7489B29A4F3F788D02C01CDD792@EX07.asurite.ad.asu.edu>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105728>

David Birchfield <dbirchfield@asu.edu> wrote:
> Great - thanks so much for this feedback and link.  My merge
> needs are straightforward, so hopefully this will suit the need!
> 
> I have pulled the latest jgit updates and downloaded the four
> .java files that are referenced in your link.  I have added these
> to the directory structure for jgit in the following new folder:
> org.spearce.jgit/src/org/spearce/jgit/merge/

Instead of copying 4 files, why don't you actually fetch the 8
commits and merge them into your local repository?  You are getting
build errors because you didn't get an exception type in the errors
directory, and at least two existing classes had new methods added
to them in order to support the merge API.

-- 
Shawn.
