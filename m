From: Teemu Likonen <tlikonen@iki.fi>
Subject: Re: Making custom git-remove-tree command
Date: Thu, 04 Feb 2010 18:32:51 +0200
Message-ID: <87tytxhsgc.fsf@mithlond.arda>
References: <87iqad2x09.fsf@mithlond.arda> <4B6A9985.4050909@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Feb 04 17:33:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nd4dv-0001xY-9z
	for gcvg-git-2@lo.gmane.org; Thu, 04 Feb 2010 17:33:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758330Ab0BDQdL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Feb 2010 11:33:11 -0500
Received: from mta-out.inet.fi ([195.156.147.13]:55261 "EHLO kirsi1.inet.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758315Ab0BDQdK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2010 11:33:10 -0500
Received: from mithlond.arda (84.251.132.215) by kirsi1.inet.fi (8.5.014)
        id 4B1D0B4D0281FFFE; Thu, 4 Feb 2010 18:33:02 +0200
Received: from dtw by mithlond.arda with local (Exim 4.69)
	(envelope-from <tlikonen@iki.fi>)
	id 1Nd4dP-0005iw-4R; Thu, 04 Feb 2010 18:32:51 +0200
In-Reply-To: <4B6A9985.4050909@viscovery.net> (Johannes Sixt's message of
	"Thu, 04 Feb 2010 10:55:17 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138975>

* 2010-02-04 10:55 (+0100), Johannes Sixt wrote:

> I think you should be able to reduce all of this to just
>
> git read-tree --index-output=/tmp/empty.index -m -u \
> 	4b825dc642cb6eb9a060e54bf8d69288fbee4904 # empty tree
> rm -f /tmp/empty.index
>
> (with the usual caveats about temporary files).

Thanks, it works. It's also _much_ faster than my "git ls-tree" with
shell loop thing. It prints ugly error, though:

    fatal: unable to write new index file

Also, it doesn't leave any index output files around.
