From: Steven Grimm <koreth@midwinter.com>
Subject: Re: Can I have this, pretty please?
Date: Sun, 12 Aug 2007 22:21:10 +0800
Message-ID: <46BF1756.5070305@midwinter.com>
References: <85ir7kq42k.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Sun Aug 12 16:21:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IKEJh-0004I4-Sf
	for gcvg-git@gmane.org; Sun, 12 Aug 2007 16:21:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758964AbXHLOVP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 12 Aug 2007 10:21:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758876AbXHLOVO
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Aug 2007 10:21:14 -0400
Received: from tater2.midwinter.com ([216.32.86.91]:46320 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1754660AbXHLOVO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Aug 2007 10:21:14 -0400
Received: (qmail 28374 invoked from network); 12 Aug 2007 14:21:13 -0000
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=200606; d=midwinter.com;
  b=iVBF3Ztat5f78y8W+kewTNQ87d3vO4ovn0+tn7tXRc78o0V2EoOqXCpq1Gn0+PpW  ;
Received: from localhost (HELO sgrimm-mbp.local) (koreth@127.0.0.1)
  by localhost with SMTP; 12 Aug 2007 14:21:12 -0000
User-Agent: Thunderbird 2.0.0.6 (Macintosh/20070728)
In-Reply-To: <85ir7kq42k.fsf@lola.goethe.zz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55686>

David Kastrup wrote:
> Mapping a repository into newsgroups (one per branch head?), complete
> with threads, references, header display, article fetch (by
> git-format-patch), Message Ids (=commit id) is much more
> straightforward than creating an HTML server.  And it means that
> everybody can use his favorite newsreader for navigating a repository.
>   

The news data model has one big problem. It is a tree structure (or 
rather, a set of tree structures). But git's ancestry graphs are not 
trees; a commit can have multiple parents as well as multiple children, 
and branches can join each other multiple times (via merges) as well as 
split off indefinitely.

I realize that you can give a list of parent message IDs in a news 
header, but I'm going to go out on a limb and guess that all existing 
newsreaders expect that list to be a linear series of messages going 
back toward the root of the thread (since that's all that ever occurs in 
real netnews), rather than an arbitrary DAG.

Not saying it's a worthless idea, but I bet you will not be able to get 
an accurate display of a repository's history using a news reader 
without modifying it to deal with more complex ancestry structures.

-Steve
