From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Tree with leading '0' modes in 1.7.0.3
Date: Fri, 26 Mar 2010 15:29:50 -0700
Message-ID: <20100326222950.GB10910@spearce.org>
References: <20100326215600.GA10910@spearce.org> <20100326222659.GA18369@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>, mike.lifeguard@gmail.com
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 26 23:30:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NvI2l-0002ZC-Lv
	for gcvg-git-2@lo.gmane.org; Fri, 26 Mar 2010 23:30:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754463Ab0CZW3y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Mar 2010 18:29:54 -0400
Received: from mail-yw0-f172.google.com ([209.85.211.172]:57654 "EHLO
	mail-yw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752077Ab0CZW3y (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Mar 2010 18:29:54 -0400
Received: by ywh2 with SMTP id 2so3812690ywh.33
        for <git@vger.kernel.org>; Fri, 26 Mar 2010 15:29:53 -0700 (PDT)
Received: by 10.101.106.1 with SMTP id i1mr2531754anm.24.1269642592891;
        Fri, 26 Mar 2010 15:29:52 -0700 (PDT)
Received: from localhost (george.spearce.org [209.20.77.23])
        by mx.google.com with ESMTPS id 20sm1176012iwn.13.2010.03.26.15.29.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 26 Mar 2010 15:29:51 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100326222659.GA18369@progeny.tock>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143291>

Jonathan Nieder <jrnieder@gmail.com> wrote:
> Shawn O. Pearce wrote:
> 
> > Any ideas?  Why is Git 1.7.0.3 jamming a leading '0' on a file mode?
> 
> See http://thread.gmane.org/gmane.comp.version-control.git/141028
> and commit c88f0cc (notes: fix malformed tree entry, 2010-02-24).
> 
> The regression that that fixes appeared in 61a7cca0 (Notes API:
> write_notes_tree(): Store the notes tree in the database, 2010-02-13),
> which is not part of 1.7.0.3.

That may be true... but I doubt the tree in question was a notes
tree.  The path entries were names like 'README', 'modules' and
'stewardbot'.  Something I would assume was the project's source
tree, not its notes tree.  Unless someone abused the note tree
editor to edit the README or something...

-- 
Shawn.
