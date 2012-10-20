From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH v2] Add new remote-hg transport helper
Date: Sat, 20 Oct 2012 17:43:01 +0200
Message-ID: <20121020154301.GA31829@glandium.org>
References: <1350745206-28955-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 20 18:02:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TPbVN-0006V0-TW
	for gcvg-git-2@plane.gmane.org; Sat, 20 Oct 2012 18:02:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752162Ab2JTQCN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Oct 2012 12:02:13 -0400
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19]:56634
	"EHLO jigen.glandium.org" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751883Ab2JTQCM (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 20 Oct 2012 12:02:12 -0400
X-Greylist: delayed 1138 seconds by postgrey-1.27 at vger.kernel.org; Sat, 20 Oct 2012 12:02:12 EDT
Received: from mh by jigen.glandium.org with local (Exim 4.80)
	(envelope-from <mh@glandium.org>)
	id 1TPbCX-0002DR-Og; Sat, 20 Oct 2012 17:43:01 +0200
Content-Disposition: inline
In-Reply-To: <1350745206-28955-1-git-send-email-felipe.contreras@gmail.com>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208088>

On Sat, Oct 20, 2012 at 05:00:06PM +0200, Felipe Contreras wrote:
> Changes since v1:
> 
>  * Improved documentation
>  * Use more common 'python' binary
>  * Warn, don't barf when a branch has multiple heads
>  * Fixed marks to fetch after cloned
>  * Support for cloning/pulling remote repositories
>  * Use a more appropriate internal directory (e.g. .git/hg/origin)
>  * Fixes for python3

Are the resulting commits identical to what you'd get from using hg-git?

Mike
