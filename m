From: Eyvind Bernhardsen <eyvind-git@orakel.ntnu.no>
Subject: Re: [PATCH] fast-import: Document the effect of "merge" with no "from" in a commit
Date: Fri, 21 Mar 2008 14:57:40 +0100
Message-ID: <FB8C4A1F-3DC1-4D7B-910B-5F721F39B244@orakel.ntnu.no>
References: <F6F70627-FAE7-43F1-BECC-E70A4A561982@orakel.ntnu.no> <20080318034321.GK8410@spearce.org> <F4486D8E-3256-4FA7-89A7-3EC7E7D64162@orakel.ntnu.no> <20080319020625.GA3535@spearce.org> <9A41E5AD-2305-457B-A214-7A11A1B559F6@orakel.ntnu.no> <20080320034031.GX8410@spearce.org> <6FC571BB-D304-4D25-B1F2-1E03BD5438F8@orakel.ntnu.no>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: James Westby <jw+debian@jameswestby.net>,
	Ian Clatworthy <ian.clatworthy@internode.on.net>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Git Mailing List <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Mar 21 14:58:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JchlN-0005X0-H8
	for gcvg-git-2@gmane.org; Fri, 21 Mar 2008 14:58:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755803AbYCUN5t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2008 09:57:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753999AbYCUN5t
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Mar 2008 09:57:49 -0400
Received: from 97.84-49-228.nextgentel.com ([84.49.228.97]:58707 "EHLO
	eyvind.bernhardsens.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752077AbYCUN5s (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2008 09:57:48 -0400
Received: from [192.168.0.3] (ip-254-5-149-91.dialup.ice.no [91.149.5.254])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by eyvind.bernhardsens.net (Postfix) with ESMTP id 57F271460ED;
	Fri, 21 Mar 2008 14:57:44 +0100 (CET)
In-Reply-To: <6FC571BB-D304-4D25-B1F2-1E03BD5438F8@orakel.ntnu.no>
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77741>

On 20. mars. 2008, at 11.43, Eyvind Bernhardsen wrote:
> On 20. mars. 2008, at 04.40, Shawn O. Pearce wrote:
>> As I understand it, this discussion about leaving out 'from' and
>> using 'merge' is only relevant on a *new* branch.
>
> Ah.  Unfortunately, that means that I don't understand why cvs2svn  
> works; it never removes files when creating a commit, even for an  
> existing branch, so I assumed that a "from" was required to populate  
> the tree.  I'll do some more testing to see what's going on.

It turns out that I'm an idiot and you're right.  I'll rewrite the  
patch to reflect that the "merge" behaviour only applies when creating  
a branch.
-- 
Eyvind Bernhardsen
