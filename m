From: Bill Lear <rael@zopyra.com>
Subject: Re: [gitolite] symlink hooks instead of copying them
Date: Thu, 4 Feb 2010 00:17:22 -0600
Message-ID: <19306.26226.369115.104150@blake.zopyra.com>
References: <20100204013556.GA2590@atcmail.atc.tcs.com>
	<20100204012840.GC497@atcmail.atc.tcs.com>
	<20100204014657.GA10114@lapse.rw.madduck.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git discussion list <git@vger.kernel.org>,
	Sitaram Chamarty <sitaram@atc.tcs.com>,
	Teemu Matilainen <teemu.matilainen@iki.fi>
To: martin f krafft <madduck@madduck.net>
X-From: git-owner@vger.kernel.org Thu Feb 04 07:17:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ncv23-0003Mc-4l
	for gcvg-git-2@lo.gmane.org; Thu, 04 Feb 2010 07:17:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753409Ab0BDGRd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Feb 2010 01:17:33 -0500
Received: from 75-27-130-60.lightspeed.austtx.sbcglobal.net ([75.27.130.60]:54131
	"HELO blake.zopyra.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1753186Ab0BDGRc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2010 01:17:32 -0500
Received: (qmail 9319 invoked by uid 500); 4 Feb 2010 06:17:26 -0000
In-Reply-To: <20100204014657.GA10114@lapse.rw.madduck.net>
X-Mailer: VM 8.1.0-beta under 23.1.1 (i386-redhat-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138951>

On Thursday, February 4, 2010 at 14:46:57 (+1300) martin f krafft writes:
>also sprach Sitaram Chamarty <sitaram@atc.tcs.com> [2010.02.04.1428 +1300]:
>> I'm ok with symlinking stuff; a couple of "cp" commands
>> would change to "ln" :)  Let me try it out (and make sure it
>> works for upgrades also...)
>
>ln -sf even.

Does 'ln -sf' work reliably on all distros?  I seem to recall on Ubuntu
7.10 that this was broken.


Bill
