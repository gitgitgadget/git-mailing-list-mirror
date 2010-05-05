From: Jeff King <peff@peff.net>
Subject: Re: Detecting GIT_DIR runtime
Date: Wed, 5 May 2010 14:14:20 -0400
Message-ID: <20100505181420.GB1556@coredump.intra.peff.net>
References: <t2gb42431c81005050838w425412d9jfe176c3b637e77c1@mail.gmail.com>
 <4BE1A2C9.6010408@dbservice.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Mahesh Vaidya <forvaidya@gmail.com>, git@vger.kernel.org
To: Tomas Carnecky <tom@dbservice.com>
X-From: git-owner@vger.kernel.org Wed May 05 20:14:33 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O9j7A-0002g4-TV
	for gcvg-git-2@lo.gmane.org; Wed, 05 May 2010 20:14:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757497Ab0EESOZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 May 2010 14:14:25 -0400
Received: from peff.net ([208.65.91.99]:55699 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757447Ab0EESOX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 May 2010 14:14:23 -0400
Received: (qmail 27806 invoked by uid 107); 5 May 2010 18:14:35 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 05 May 2010 14:14:35 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 05 May 2010 14:14:20 -0400
Content-Disposition: inline
In-Reply-To: <4BE1A2C9.6010408@dbservice.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146412>

On Wed, May 05, 2010 at 06:54:33PM +0200, Tomas Carnecky wrote:

> On 5/5/10 5:38 PM, Mahesh Vaidya wrote:
> >I have a tree like
> >/home/mvaidya/WORKSPACE/nvos/mvaidya-master-100.local/some/folder
> >
> >I would like to issue come command say "git fetch" from any level of
> >the tree. How can I deduce path of .git folder. Reason I need it as I
> >some application configuration saved in .git/workspace.properties and
> >I need to some action before git fetch.
> >
> 
> Take a look at:
> $ git rev-parse --cdup

Or even "git rev-parse --git-dir".

-Peff
