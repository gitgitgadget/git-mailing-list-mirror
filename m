From: Julien Cristau <jcristau@debian.org>
Subject: Re: [PATCH] config --get --path: check for unset $HOME
Date: Mon, 26 Jul 2010 17:33:10 +0200
Message-ID: <20100726153310.GK12476@radis.liafa.jussieu.fr>
References: <20100723003456.2976.899.reportbug@dr-wily.mit.edu>
 <20100723012322.GA27113@burratino>
 <20100725085939.GA5281@radis.liafa.jussieu.fr>
 <20100726005111.GA29755@burratino>
 <20100726140756.GH12476@radis.liafa.jussieu.fr>
 <20100726150651.GA4021@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 26 17:39:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdPmI-0007AE-Iq
	for gcvg-git-2@lo.gmane.org; Mon, 26 Jul 2010 17:39:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753350Ab0GZPji (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jul 2010 11:39:38 -0400
Received: from coloquinte.cristau.org ([91.121.16.100]:39689 "EHLO
	coloquinte.cristau.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753070Ab0GZPjh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jul 2010 11:39:37 -0400
X-Greylist: delayed 382 seconds by postgrey-1.27 at vger.kernel.org; Mon, 26 Jul 2010 11:39:37 EDT
Received: from radis.liafa.jussieu.fr (did75-9-82-229-149-154.fbx.proxad.net [82.229.149.154])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by coloquinte.cristau.org (Postfix) with ESMTPSA id 36E97B9BD;
	Mon, 26 Jul 2010 17:33:12 +0200 (CEST)
Received: from julien by radis.liafa.jussieu.fr with local (Exim 4.72)
	(envelope-from <julien@radis.liafa.jussieu.fr>)
	id 1OdPfy-00066e-M2; Mon, 26 Jul 2010 17:33:10 +0200
Content-Disposition: inline
In-Reply-To: <20100726150651.GA4021@burratino>
X-Operating-System: Linux 2.6.32-5-amd64 x86_64
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151848>

On Mon, Jul 26, 2010 at 10:06:51 -0500, Jonathan Nieder wrote:

> If $HOME is unset (as in some automated build situations),
> currently
> 
> 	git config --path path.home "~"
> 	git config --path --get path.home
> 
> segfaults.  Error out with
> 
> 	Failed to expand user dir in: '~/'
> 
> instead.
> 
> Reported-by: Julien Cristau <jcristau@debian.org>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>

Tested-by: Julien Cristau <jcristau@debian.org>

Thanks!

Cheers,
Julien
