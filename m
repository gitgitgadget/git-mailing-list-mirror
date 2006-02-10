From: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH] Add git-annotate - a tool for annotating files with the revision and person that created each line in the file.
Date: Fri, 10 Feb 2006 11:25:41 +0000
Message-ID: <20060210112541.GA3513@linux-mips.org>
References: <11394103753694-git-send-email-ryan@michonline.com> <cda58cb80602080835s38713193t@mail.gmail.com> <Pine.LNX.4.63.0602081843220.20568@wbgn013.biozentrum.uni-wuerzburg.de> <7v3bitr73q.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Franck Bui-Huu <vagabon.xyz@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 10 12:26:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F7WPh-0001HF-Sh
	for gcvg-git@gmane.org; Fri, 10 Feb 2006 12:26:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750932AbWBJL0A (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Feb 2006 06:26:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750936AbWBJLZ7
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Feb 2006 06:25:59 -0500
Received: from mipsfw.mips-uk.com ([194.74.144.146]:32532 "EHLO
	bacchus.dhis.org") by vger.kernel.org with ESMTP id S1750932AbWBJLZ7
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Feb 2006 06:25:59 -0500
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.4/8.13.4) with ESMTP id k1ABPgLM005097;
	Fri, 10 Feb 2006 11:25:42 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.4/8.13.4/Submit) id k1ABPf2Y005096;
	Fri, 10 Feb 2006 11:25:41 GMT
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v3bitr73q.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15872>

On Wed, Feb 08, 2006 at 11:19:37AM -0800, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> Are there any rules on the choice of the script language ?
> >
> > Yes. Do not try to introduce unnecessary dependencies. But if it is 
> > the right tool to do the job, you should use it. As of now, we have perl, 
> > python and Tcl/Tk.
> 
> Very well said.  That's what currently stands.

The dependency on Python 2.4 already is a problem for installation on some
systems ...

  Ralf
