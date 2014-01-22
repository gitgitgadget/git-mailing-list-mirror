From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH v2] gitk: Comply with XDG base directory specification
Date: Wed, 22 Jan 2014 22:08:07 +1100
Message-ID: <20140122110806.GC7306@iris.ozlabs.ibm.com>
References: <1390331416-4662-1-git-send-email-astrilhayato@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Astril Hayato <astrilhayato@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 22 12:08:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W5vfN-0004LB-J5
	for gcvg-git-2@plane.gmane.org; Wed, 22 Jan 2014 12:08:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753419AbaAVLIN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jan 2014 06:08:13 -0500
Received: from ozlabs.org ([203.10.76.45]:41151 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752549AbaAVLIM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jan 2014 06:08:12 -0500
Received: by ozlabs.org (Postfix, from userid 1003)
	id 18F3E2C00A8; Wed, 22 Jan 2014 22:08:11 +1100 (EST)
Content-Disposition: inline
In-Reply-To: <1390331416-4662-1-git-send-email-astrilhayato@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240818>

On Tue, Jan 21, 2014 at 07:10:16PM +0000, Astril Hayato wrote:
> Write the gitk config data to $XDG_CONFIG_HOME/git/gitk ($HOME/.config/git/gitk
> by default) in line with the XDG specification. This makes it consistent with
> git which also follows the spec.
> 
> If $HOME/.gitk already exists use that for backward compatibility, so only new
> installations are affected.
> 
> Signed-off-by: Astril Hayato <astrilhayato@gmail.com>

Thanks, applied.

Paul.
