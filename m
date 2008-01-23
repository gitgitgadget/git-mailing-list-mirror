From: Wayne Davison <wayne@opencoder.net>
Subject: Re: Why does git track directory listed in
	.gitignore/".git/info/exclude"?
Date: Wed, 23 Jan 2008 13:11:38 -0800
Message-ID: <20080123211138.GB21300@blorf.net>
References: <6bc632150801230554l3b24e1e4lb4641bf7c16857c0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: pradeep singh rautela <rautelap@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 23 22:12:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHmtL-0004TJ-EE
	for gcvg-git-2@gmane.org; Wed, 23 Jan 2008 22:12:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752041AbYAWVLk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jan 2008 16:11:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752080AbYAWVLk
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jan 2008 16:11:40 -0500
Received: from dsl-74-220-69-132.cruzio.com ([74.220.69.132]:40188 "EHLO
	dot.blorf.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751865AbYAWVLj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jan 2008 16:11:39 -0500
Received: by dot.blorf.net (Postfix, from userid 1000)
	id 776564079; Wed, 23 Jan 2008 13:11:38 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <6bc632150801230554l3b24e1e4lb4641bf7c16857c0@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71570>

On Wed, Jan 23, 2008 at 07:24:44PM +0530, pradeep singh rautela wrote:
> i.e i have added following line to both of them -
> xen-3.1.0-src/

That doesn't match the directory due to the trailing slash.  If you
remove that slash, it will match the dir, and then ignore anything
you place inside.

..wayne..
