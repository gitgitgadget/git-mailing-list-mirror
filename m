From: Ron Garret <ron1@flownet.com>
Subject: Re: My use case
Date: Sat, 30 Jan 2010 11:19:45 -0800
Organization: Amalgamated Widgets
Message-ID: <ron1-EF6DDC.11194530012010@news.gmane.org>
References: <ron1-09825C.00261930012010@news.gmane.org> <1264840729-sup-5264@ezyang> <ron1-CC0A6E.00541330012010@news.gmane.org> <20100130174844.GD788@thunk.org> <ron1-A58BC7.10295430012010@news.gmane.org> <7vtyu3o1hq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 30 20:21:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NbIsi-00039N-Vt
	for gcvg-git-2@lo.gmane.org; Sat, 30 Jan 2010 20:21:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754457Ab0A3TVP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Jan 2010 14:21:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754481Ab0A3TVO
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jan 2010 14:21:14 -0500
Received: from lo.gmane.org ([80.91.229.12]:51831 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754441Ab0A3TVJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jan 2010 14:21:09 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1NbIs5-0002PE-Ts
	for git@vger.kernel.org; Sat, 30 Jan 2010 20:20:41 +0100
Received: from 68-190-211-184.dhcp.gldl.ca.charter.com ([68.190.211.184])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 30 Jan 2010 20:20:41 +0100
Received: from ron1 by 68-190-211-184.dhcp.gldl.ca.charter.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 30 Jan 2010 20:20:41 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 68-190-211-184.dhcp.gldl.ca.charter.com
User-Agent: MT-NewsWatcher/3.5.1 (Intel Mac OS X)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138495>

In article <7vtyu3o1hq.fsf@alter.siamese.dyndns.org>,
 Junio C Hamano <gitster@pobox.com> wrote:

> Ron Garret <ron1@flownet.com> writes:
> 
> > You are absolutely right.  That is another reason why having the 
> > individual files tracked separately from the main project would be a 
> > good thing if I can get it to work.  (It would be kind of like having a 
> > git-stash on a per-file basis.)
> 
> When you have more than one functions defined in a file, and the
> interactive Lisp development cycle works primarily on s-exp basis, not
> necessarily constrained by file boundaries, don't you want even finer
> grained control than "stash per-file"?
> 
> I don't think of a good solution myself, but I find your "finer than whole
> tree" an interesting topic.

You're reading my mind.  My long-term vision for this thing is indeed a 
revision control system based on S-expressions, not files.  (I 
personally think the whole concept of files is fundamentally broken, but 
that's a whole 'nuther kettle of lobster.)  Unfortunately, that opens up 
a Pandora's box of ancillary issues, which would be seriously off-topic 
here.  If you're interested we can talk about it off-line (or we can do 
it here if you think it's not too much of a tangent).

rg
