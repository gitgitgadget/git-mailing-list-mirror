From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Diff format in packs
Date: Mon, 31 Jul 2006 17:20:55 -0400
Message-ID: <9e4733910607311420n8537b76lbde4d60062195403@mail.gmail.com>
References: <9e4733910607311408i10e17dse776920de7c5076a@mail.gmail.com>
	 <ealruh$sq9$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 31 23:21:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G7fC9-0003uz-LN
	for gcvg-git@gmane.org; Mon, 31 Jul 2006 23:21:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030360AbWGaVU5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 31 Jul 2006 17:20:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932529AbWGaVU5
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Jul 2006 17:20:57 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:8350 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932458AbWGaVU4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Jul 2006 17:20:56 -0400
Received: by nf-out-0910.google.com with SMTP id o25so33899nfa
        for <git@vger.kernel.org>; Mon, 31 Jul 2006 14:20:55 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=c1I2eGsIzdjM/CUmgivuigTs3qdWpzZpHIBENKoq7D7RiZm4SdDRsZhn4y4MTzg8bK+LKj2llWMuRPMQ4LiVWcioDRObUns7EX1Z/iI5znFlc6DmibGrCFE5bWFO79udXiipiE87osiNJUMtoDDkML5GaOfgghLrH6V8i1CZWvQ=
Received: by 10.78.156.6 with SMTP id d6mr41584hue;
        Mon, 31 Jul 2006 14:20:55 -0700 (PDT)
Received: by 10.78.149.8 with HTTP; Mon, 31 Jul 2006 14:20:55 -0700 (PDT)
To: "Jakub Narebski" <jnareb@gmail.com>
In-Reply-To: <ealruh$sq9$1@sea.gmane.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24546>

On 7/31/06, Jakub Narebski <jnareb@gmail.com> wrote:
> Jon Smirl wrote:
>
> > I'm trying to build a small app that takes a CVS ,v and writes out a
> > pack corresponding to the versions. Suggestions on the most efficient
> > strategy for doing this by calling straight into the git C code?
> > Forking off git commands is not very efficient when done a million
> > times.
>
> Something akin to parsecvs by Keith Packard?

I see the error in my thoughts now, I need the fully expanded delta to
compute the sha-1 so I might as well use the parsecvs code.

I am working on combining cvs2svn, parsecvs and cvsps into something
that can handle Mozilla CVS.

-- 
Jon Smirl
jonsmirl@gmail.com
