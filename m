From: Nick Hengeveld <nickh@reactrix.com>
Subject: Re: Why not clone to a remote directory over SSH
Date: Wed, 23 Nov 2005 16:19:55 -0800
Message-ID: <20051124001955.GP3968@reactrix.com>
References: <20051123211601.GA2260@hpsvcnb.fc.hp.com> <7vd5kr3pz1.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0511240038001.11106@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, Carl Baldwin <cnb@fc.hp.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 24 01:23:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ef4si-00053P-OA
	for gcvg-git@gmane.org; Thu, 24 Nov 2005 01:22:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030536AbVKXAW2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 23 Nov 2005 19:22:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030544AbVKXAW2
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Nov 2005 19:22:28 -0500
Received: from 195.37.26.69.virtela.com ([69.26.37.195]:1964 "EHLO
	teapot.corp.reactrix.com") by vger.kernel.org with ESMTP
	id S1030536AbVKXAW1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Nov 2005 19:22:27 -0500
Received: from teapot.corp.reactrix.com (localhost.localdomain [127.0.0.1])
	by teapot.corp.reactrix.com (8.12.11/8.12.11) with ESMTP id jAO0Jugi011537;
	Wed, 23 Nov 2005 16:19:56 -0800
Received: (from nickh@localhost)
	by teapot.corp.reactrix.com (8.12.11/8.12.11/Submit) id jAO0Jtpb011535;
	Wed, 23 Nov 2005 16:19:55 -0800
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0511240038001.11106@wbgn013.biozentrum.uni-wuerzburg.de>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12665>

On Thu, Nov 24, 2005 at 12:41:56AM +0100, Johannes Schindelin wrote:

> Obviously, this only works if the other side can connect to this side via 
> ssh. Hmm. Firewalls? Disabled sshd? `hostname` not reliably returning a 
> valid address for the remote side?

If sshd is running locally, you can forward a port back to yourself and
have the remote clone localhost:`pwd`.  Assuming there's a way to clone
using a nonstandard port.

-- 
For a successful technology, reality must take precedence over public
relations, for nature cannot be fooled.
