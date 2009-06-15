From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: egit and RSA keys for SSH
Date: Mon, 15 Jun 2009 08:04:30 -0700
Message-ID: <20090615150430.GY16497@spearce.org>
References: <F2969C1B08CBEE42B78C04C280D578E72CAF41E19B@donkey.landcare.ad.landcareresearch.co.nz> <be6fef0d0906150727i2f57318dq9dc9b1a3d1208196@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Aaron Hicks <HicksA@landcareresearch.co.nz>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 15 17:04:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MGDjl-0008Og-PC
	for gcvg-git-2@gmane.org; Mon, 15 Jun 2009 17:04:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753636AbZFOPEd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jun 2009 11:04:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752973AbZFOPEc
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Jun 2009 11:04:32 -0400
Received: from george.spearce.org ([209.20.77.23]:59177 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751408AbZFOPEc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jun 2009 11:04:32 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 6C0CD38215; Mon, 15 Jun 2009 15:04:32 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <be6fef0d0906150727i2f57318dq9dc9b1a3d1208196@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121613>

Tay Ray Chuan <rctay89@gmail.com> wrote:
> On Mon, Jun 15, 2009 at 8:16 AM, Aaron
> Hicks<HicksA@landcareresearch.co.nz> wrote:
> > The problem is I can't see how to associate an RSA key in
> > order to authenticate the SSH login with our gitosis repository (or
> > GitHub). We have PuTTY installed and use Pageant to manage keys, and
> > the required key is already loaded. We've used the 'import project'
> > wizard, and initialised git in our project workspace, and though egit
> > becomes aware that the project is a git repository, there seem to
> > be no menu items for associating an RSA key with a remote repository.
> 
> For git, I set the GIT_SSH environment variable to PuTTY's plink.exe
> location. I wonder if this might work with egit?

No.  JGit (the library under EGit) does not honor GIT_SSH.

-- 
Shawn.
