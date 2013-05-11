From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] gitk: simplify file filtering
Date: Sat, 11 May 2013 19:42:58 +1000
Message-ID: <20130511094258.GC6196@iris.ozlabs.ibm.com>
References: <1367100099-13798-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jens Lehmann <Jens.Lehmann@web.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 11 12:13:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ub6o4-0004MU-QC
	for gcvg-git-2@plane.gmane.org; Sat, 11 May 2013 12:13:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753494Ab3EKKNc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 May 2013 06:13:32 -0400
Received: from ozlabs.org ([203.10.76.45]:49646 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752645Ab3EKKNb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 May 2013 06:13:31 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 6B25A2C00D8; Sat, 11 May 2013 20:13:28 +1000 (EST)
Content-Disposition: inline
In-Reply-To: <1367100099-13798-1-git-send-email-felipe.contreras@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223953>

On Sat, Apr 27, 2013 at 05:01:39PM -0500, Felipe Contreras wrote:
> git diff is perfectly able to do this with '-- files', no need for
> manual filtering.
> 
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>

Thanks, applied, with the commit message expanded to say that this
makes gettreediffs do the same as getblobdiffs.

Paul.
