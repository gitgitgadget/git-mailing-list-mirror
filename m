From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH RFC] gitk: display submodule diffs with appropriate
 encoding
Date: Tue, 12 Jan 2010 22:23:02 +1100
Message-ID: <20100112112302.GF6685@brick.ozlabs.ibm.com>
References: <1262695494-27975-1-git-send-email-kirr@landau.phys.spbu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Kirill Smelkov <kirr@landau.phys.spbu.ru>
X-From: git-owner@vger.kernel.org Tue Jan 12 12:23:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUeqp-0003py-0E
	for gcvg-git-2@lo.gmane.org; Tue, 12 Jan 2010 12:23:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752142Ab0ALLXe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jan 2010 06:23:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751690Ab0ALLXd
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jan 2010 06:23:33 -0500
Received: from ozlabs.org ([203.10.76.45]:51381 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752086Ab0ALLXb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jan 2010 06:23:31 -0500
Received: by ozlabs.org (Postfix, from userid 1003)
	id C32C8B7C6F; Tue, 12 Jan 2010 22:23:29 +1100 (EST)
Content-Disposition: inline
In-Reply-To: <1262695494-27975-1-git-send-email-kirr@landau.phys.spbu.ru>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136716>

On Tue, Jan 05, 2010 at 03:44:54PM +0300, Kirill Smelkov wrote:

> Previsously, when submodule commits headings contained non-latin-1
> characters, they were displayed incorrectly in gitk, because $line was
> not properly decoded, i.e.

Thanks, applied.

Paul.
