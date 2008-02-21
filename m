From: Steven Walter <stevenrwalter@gmail.com>
Subject: Re: Minor annoyance with git push
Date: Thu, 21 Feb 2008 17:35:49 -0500
Message-ID: <20080221223549.GA26266@dervierte>
References: <7v7ihd7ee1.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0802100213330.11591@racer.site> <20080210101756.GB26568@coredump.intra.peff.net> <alpine.LSU.1.00.0802101219280.11591@racer.site> <20080210122321.GA31009@coredump.intra.peff.net> <alpine.LSU.1.00.0802101303140.11591@racer.site> <7vzltwavf9.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0802201305350.17164@racer.site> <76718490802200720w4dd89dc1lf7b19d546d3bfd00@mail.gmail.com> <alpine.LSU.1.00.0802201535250.17164@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Feb 21 23:36:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSK1x-0003y3-H4
	for gcvg-git-2@gmane.org; Thu, 21 Feb 2008 23:36:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765222AbYBUWgI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Feb 2008 17:36:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757142AbYBUWgH
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Feb 2008 17:36:07 -0500
Received: from ik-out-1112.google.com ([66.249.90.176]:39942 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757202AbYBUWgF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Feb 2008 17:36:05 -0500
Received: by ik-out-1112.google.com with SMTP id c28so206897ika.5
        for <git@vger.kernel.org>; Thu, 21 Feb 2008 14:36:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        bh=8qPC9l7eY1LNiyK7oKrqZ41CPLFjhc6UAdlRqRokbck=;
        b=LbM8fzCei/0sPrLGmd/Ap8O/Tibxvvr0RY+smocYMHgpScsoF1+hqQJF6jlcDy7MaCZPr0Xh00RJiNNH7NUgibtouQzyrXtLMn3LN/ThCbX0n6GIljwwVnTQKeTY2u7mr64FQ3iajgY5+w6SIbpFErMj5seEzvXM1OKdCZ9WUYs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=nbjTKKRnTdqIicak0MNd0P7DEYyb8Y0XmsvXb/xVtgqm3AVDe230tww7Zzppb/S3bKfeMy7RdvCI+RGbfNr+NiLHk5t0haD1zKCe+F68apm7I87P2WRs12ZK9xQgdTShMEnlxW5qeRsS6sh0cKY5HvC1mbLBu/JmKqdDabTtnW0=
Received: by 10.142.187.2 with SMTP id k2mr5627255wff.25.1203633352979;
        Thu, 21 Feb 2008 14:35:52 -0800 (PST)
Received: from dasbrennen.isa-geek.org ( [76.177.39.93])
        by mx.google.com with ESMTPS id l22sm943503wrl.38.2008.02.21.14.35.51
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 21 Feb 2008 14:35:52 -0800 (PST)
Received: by dasbrennen.isa-geek.org (Postfix, from userid 1000)
	id 0D74D234D3; Thu, 21 Feb 2008 17:35:49 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <alpine.LSU.1.00.0802201535250.17164@racer.site>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74672>

On Wed, Feb 20, 2008 at 03:38:31PM +0000, Johannes Schindelin wrote:
> That depends awfully on your definition of "safe".
> 
> I, for one, hate the idea already, that I am "safe" when "git push" does 
> not do the thing I asked it to, and which it has done for a couple of 
> years now without complaint, and which I have gotten used to.
> 
> And then, there will be a great confusion for me, since I work on 5 
> different machines on an average day, with 5 different git versions, and 
> having different config settings.

Which is worse: pushing more refs than you intended (requiring rewinding
refs on a repository that other people may pull from), or pushing fewer
refs than you intended, requiring you to run the command a second time?
-- 
-Steven Walter <stevenrwalter@gmail.com>
Freedom is the freedom to say that 2 + 2 = 4
B2F1 0ECC E605 7321 E818  7A65 FC81 9777 DC28 9E8F 
