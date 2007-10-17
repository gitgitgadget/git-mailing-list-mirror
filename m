From: "franky" <yinping@kooxoo.com>
Subject: RE: Is there any plan to support partial checkout or submouduleimprovement?
Date: Wed, 17 Oct 2007 10:54:43 +0800
Message-ID: <20071017025446.51ED77E83@mail.kooxoo.com>
References: <20071016213359.GJ26127@efreet.light.src>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Keywords: gituseful
Cc: <git@vger.kernel.org>
To: "'Jan Hudec'" <bulb@ucw.cz>
X-From: git-owner@vger.kernel.org Wed Oct 17 04:55:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ihz3k-0003v1-K8
	for gcvg-git-2@gmane.org; Wed, 17 Oct 2007 04:55:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762078AbXJQCyu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 22:54:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934461AbXJQCyu
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 22:54:50 -0400
Received: from mail.kooxoo.com ([60.28.194.208]:38763 "EHLO mail.kooxoo.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755806AbXJQCyt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 22:54:49 -0400
Received: from yinping (unknown [124.42.17.129])
	by mail.kooxoo.com (Postfix) with ESMTP id 51ED77E83;
	Wed, 17 Oct 2007 10:54:45 +0800 (CST)
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
In-Reply-To: <20071016213359.GJ26127@efreet.light.src>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.3198
Thread-Index: AcgQP897ibwRazs8T7G/+Q8KypD98AAKQdQQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61321>



 franky
> -----Original Message-----
> From: Jan Hudec [mailto:bulb@ucw.cz]
> Sent: Wednesday, October 17, 2007 5:34 AM
> To: franky
> Cc: 'Johannes Schindelin'; 'Lars Hjemli'; git@vger.kernel.org
> Subject: Re: Is there any plan to support partial checkout or
> submouduleimprovement?
> 
> On Tue, Oct 16, 2007 at 19:53:08 +0800, franky wrote:
> > > You are talking as if your partial checkout was a project in its own
> > > right.  Then make it so.  Do not use a partial checkout, but make that
a
> > > submodule.
> >
> > As I said in the first email, the submodule way suffers from the
multiple
> > commit problem: src and bin as two submodules of project, three commits
(for
> > the 3 dirs separately) are needed when src directory changes and
compiled
> > binaries being put in bin directory. It's annoying to have to give 3
commit
> > logs.
> 
> Thinking about it, it's only two commits -- src can be a submodule, but
bin
> a normal directory (you can choose not to check out subprojects during
> repository checkout).
> Now I would actually say that commiting bin independently is better.
> It allows you to commit sources more often (eg. if you are doing series of
> small fixes) and more flexibility for branching (you don't want to merge
> binaries).
> 

Thanks for the advice. It's a good idea.
> --
> 						 Jan 'Bulb' Hudec
<bulb@ucw.cz>
