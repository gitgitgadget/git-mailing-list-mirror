From: Eli Barzilay <eli@barzilay.org>
Subject: Re: Possible bug with `export-subst' attribute
Date: Sun, 25 Jul 2010 18:41:26 -0400
Message-ID: <19532.48534.761164.164123@winooski.ccs.neu.edu>
References: <19531.65276.394443.190317@winooski.ccs.neu.edu>
	<20100725130935.GA22083@LK-Perkele-V2.elisa-laajakaista.fi>
	<20100725221539.GA21813@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>, git@vger.kernel.org,
	Will Palmer <wmpalmer@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 26 00:41:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Od9t0-0003A0-Oc
	for gcvg-git-2@lo.gmane.org; Mon, 26 Jul 2010 00:41:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751971Ab0GYWl3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Jul 2010 18:41:29 -0400
Received: from winooski.ccs.neu.edu ([129.10.115.117]:58021 "EHLO barzilay.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751783Ab0GYWl3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jul 2010 18:41:29 -0400
Received: from eli by barzilay.org with local (Exim 4.66)
	(envelope-from <eli@barzilay.org>)
	id 1Od9ss-0002Md-Oz; Sun, 25 Jul 2010 18:41:26 -0400
In-Reply-To: <20100725221539.GA21813@burratino>
X-Mailer: VM 8.0.12 under 23.1.1 (x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151797>

On Jul 25, Jonathan Nieder wrote:
> Ilari Liusvaara wrote:
> 
> > I remember seeing similar stuff. It isn't just archive, I also rember seeing
> > commit printing full hashes in that informational line it prints when it has
> > made the commit (IIRC, normally that hash is abbrevated).
> 
> My bad.  Would something like this fix it?

In my case (using archive), this fixes it -- thanks!

-- 
          ((lambda (x) (x x)) (lambda (x) (x x)))          Eli Barzilay:
                    http://barzilay.org/                   Maze is Life!
