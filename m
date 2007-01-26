From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: cvsimport/cvsps: wrong revisions in branch
Date: Fri, 26 Jan 2007 15:06:19 +1300
Message-ID: <46a038f90701251806k719dd35p7b13fe049b9cf25c@mail.gmail.com>
References: <20070125142242.1402.qmail@b4b5deb4d44aa3.315fe32.mid.smarden.org>
	 <45B8C032.7020004@fs.ei.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Simon 'corecode' Schubert" <corecode@fs.ei.tum.de>
X-From: git-owner@vger.kernel.org Fri Jan 26 03:06:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAGTw-00055e-S1
	for gcvg-git@gmane.org; Fri, 26 Jan 2007 03:06:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030703AbXAZCGW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 25 Jan 2007 21:06:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030704AbXAZCGW
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Jan 2007 21:06:22 -0500
Received: from nf-out-0910.google.com ([64.233.182.191]:39999 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030703AbXAZCGV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jan 2007 21:06:21 -0500
Received: by nf-out-0910.google.com with SMTP id o25so1000132nfa
        for <git@vger.kernel.org>; Thu, 25 Jan 2007 18:06:20 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=j1b8EJztzBT21q0eQAti44QjnmL2x0TdcNLr38Rv4erZEq+a6jzxigbLfnA8kgu1B5A+v8wMV/xDo9st56B8hXOZvr1+3DGk32J7g21YKtoK1JkBEgXHvsQZ4dQrIU3CoWMBz03cwevq4pPuCpJ62gGoORSwuA7wnArrDhT0pA4=
Received: by 10.49.54.3 with SMTP id g3mr2657593nfk.1169777179924;
        Thu, 25 Jan 2007 18:06:19 -0800 (PST)
Received: by 10.48.215.2 with HTTP; Thu, 25 Jan 2007 18:06:19 -0800 (PST)
In-Reply-To: <45B8C032.7020004@fs.ei.tum.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37790>

On 1/26/07, Simon 'corecode' Schubert <corecode@fs.ei.tum.de> wrote:
> how do you expect this to ever work?  your tag is not a time stable one.

I agree on that, but you _can_ try a range of importers. I think you
should give Keith Packard's parsecvs a try. It is memory-bound and
won't do incremental imports but it manages to import some repos
cvsimport can't do directly.

The other option is to use cvs2svn, which is the most conservative and
careful importer around, and most likely to be able to deal with your
insane tags. And then git-svnimport right after ;-)

cheers

m
