From: Mike Gant <mwgant@gmail.com>
Subject: Re: [PATCH] git-add: allow --ignore-missing always, not just in dry
 run
Date: Mon, 6 Feb 2012 21:39:09 -0700
Message-ID: <20120207043909.GA16349@gantsfort.com>
References: <1326923544-8287-1-git-send-email-dieter@plaetinck.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dieter Plaetinck <dieter@plaetinck.be>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 07 05:45:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rucw3-0002CQ-Ii
	for gcvg-git-2@plane.gmane.org; Tue, 07 Feb 2012 05:45:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756240Ab2BGEpi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Feb 2012 23:45:38 -0500
Received: from gantsfort.com ([64.66.245.199]:19595 "EHLO mail.gantsfort.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755967Ab2BGEpi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Feb 2012 23:45:38 -0500
X-Greylist: delayed 387 seconds by postgrey-1.27 at vger.kernel.org; Mon, 06 Feb 2012 23:45:38 EST
Received: from mg1 (mg1.gantsfort.com [192.168.0.10])
	by mail.gantsfort.com (Postfix) with SMTP id C64C017DFA;
	Mon,  6 Feb 2012 21:39:09 -0700 (MST)
Received: by mg1 (sSMTP sendmail emulation); Mon, 06 Feb 2012 21:39:09 -0700
Mail-Followup-To: git@vger.kernel.org,
	Dieter Plaetinck <dieter@plaetinck.be>
Content-Disposition: inline
In-Reply-To: <1326923544-8287-1-git-send-email-dieter@plaetinck.be>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190137>

On Wed, Jan 18, 2012 at 10:52:24PM +0100, Dieter Plaetinck wrote:
> There is no need to restrict use of --ignore-missing to dry runs,
> it can be useful to ignore missing files during normal operation as
> well.

FWIW I would be in favor of this change and I was going to submit a
patch, too. My use case is different, though. I create branches that
will never be merged to the mainline because they have files added that
I don't want in master. The files added to these branches can vary. In
my script to create the branch, I want the largest possible set of these
files as the argument to 'git add' but if not all exist it's okay. I
realize I can write my script to only add the files that exist but I'm
lazy ;) and the --ignore-missing option would be easier.

Mike
