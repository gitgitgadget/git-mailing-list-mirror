From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: how to rewalk the commit list after rename detection
Date: Wed, 25 Jun 2008 21:04:04 +0200
Message-ID: <20080625190404.GE4039@steel.home>
References: <20080623153814.GD15773@redhat.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Don Zickus <dzickus@redhat.com>
X-From: git-owner@vger.kernel.org Wed Jun 25 21:06:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBaIk-0004gl-Eq
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 21:05:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753305AbYFYTEK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2008 15:04:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753004AbYFYTEJ
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jun 2008 15:04:09 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:62886 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752348AbYFYTEI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2008 15:04:08 -0400
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: :YSxENQjhO8RswxTRIGdg20tf4EbVSQ==
Received: from tigra.home (Fad8f.f.strato-dslnet.de [195.4.173.143])
	by post.webmailer.de (fruni mo5) (RZmta 16.45)
	with ESMTP id Y05ee1k5PHmlow ; Wed, 25 Jun 2008 21:04:05 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id D5DB2277BD;
	Wed, 25 Jun 2008 21:04:04 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id BB3CD56D2A; Wed, 25 Jun 2008 21:04:04 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080623153814.GD15773@redhat.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86322>

Don Zickus, Mon, Jun 23, 2008 17:38:14 +0200:
> I am trying to find a way to handle a situation where I am looking for a
> change in a particular file, but the filename is old and has since been
> renamed.
> 
> Processing the commit list internally (using init_revisions,
> setup_revisions, get_revision), I can easily find the rename of the file,
> but that is usually the start of the walk for that file (as it was just
> deleted for the rename).  I do not know how to re-walk the commits list
> armed with the new file name.

Try looking at git log --follow <name>
