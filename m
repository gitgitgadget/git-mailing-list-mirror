From: Pau Garcia i Quiles <pgquiles@elpauer.org>
Subject: Re: "malloc failed"
Date: Wed, 28 Jan 2009 23:16:32 +0100
Message-ID: <3af572ac0901281416x5adef0eak89bd4b40fda52c2b@mail.gmail.com>
References: <878wow7pth.fsf@mcbain.luannocracy.com>
	 <20090128050225.GA18546@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: David Abrahams <dave@boostpro.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jan 28 23:18:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSIjg-0003Sm-An
	for gcvg-git-2@gmane.org; Wed, 28 Jan 2009 23:18:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754380AbZA1WQh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jan 2009 17:16:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754397AbZA1WQg
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jan 2009 17:16:36 -0500
Received: from mu-out-0910.google.com ([209.85.134.190]:55041 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756880AbZA1WQe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jan 2009 17:16:34 -0500
Received: by mu-out-0910.google.com with SMTP id g7so5170566muf.1
        for <git@vger.kernel.org>; Wed, 28 Jan 2009 14:16:33 -0800 (PST)
Received: by 10.223.108.140 with SMTP id f12mr82038fap.23.1233180992331; Wed, 
	28 Jan 2009 14:16:32 -0800 (PST)
In-Reply-To: <20090128050225.GA18546@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107588>

On Wed, Jan 28, 2009 at 6:02 AM, Jeff King <peff@peff.net> wrote:

> How big is the repository? How big are the biggest files? I have a
> 3.5G repo with files ranging from a few bytes to about 180M. I've never
> run into malloc problems or gone into swap on my measly 1G box.
> How does your dataset compare?

I also have malloc problems but only on Windows, on Linux it works fine.

My case: I have a 500 MB repository with a 1GB working tree, with
binary files ranging from 100KB to 50MB and a few thousand source
files.

I have two branches ('master' and 'cmake') and the latter has suffered
a huge hierarchy reorganization.

When I merge 'master' in 'cmake', if I use the 'subtree' strategy, it
works fine. If I use any other strategy, after a couple of minutes I
receive a "malloc failed" and the tree is all messed up. As I said, on
Linux it works fine, so maybe it's a Windows-specific problem.

-- 
Pau Garcia i Quiles
http://www.elpauer.org
(Due to my workload, I may need 10 days to answer)
