From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: Hey - A Conceptual Simplication....
Date: Fri, 20 Nov 2009 05:31:04 +0300
Message-ID: <20091120023103.GC22556@dpotapov.dyndns.org>
References: <005a01ca684e$71a1d710$54e58530$@com> <20091118142512.1313744e@perceptron> <008401ca6880$33d7e550$9b87aff0$@com> <m37htnd3kb.fsf@localhost.localdomain> <31e9dd080911181152h665d5d9dr5c0736c0ca3234c1@mail.gmail.com> <009401ca68bc$7e4b12b0$7ae13810$@com> <20091119074226.GA23304@atjola.homenet> <00d401ca6954$a29fa020$e7dee060$@com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, B.Steinbrink@gmx.de,
	'Jason Sewall' <jasonsewall@gmail.com>,
	'Jakub Narebski' <jnareb@gmail.com>,
	'Jan =?iso-8859-1?Q?Kr=FCger'?= <jk@jk.gs>, torvalds@osdl.org
To: George Dennie <gdennie@pospeople.com>
X-From: git-owner@vger.kernel.org Fri Nov 20 03:31:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NBJHR-0003CU-4f
	for gcvg-git-2@lo.gmane.org; Fri, 20 Nov 2009 03:31:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758205AbZKTCbL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Nov 2009 21:31:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758175AbZKTCbL
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Nov 2009 21:31:11 -0500
Received: from mail-fx0-f221.google.com ([209.85.220.221]:39626 "EHLO
	mail-fx0-f221.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753432AbZKTCbK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Nov 2009 21:31:10 -0500
Received: by fxm21 with SMTP id 21so3175079fxm.21
        for <git@vger.kernel.org>; Thu, 19 Nov 2009 18:31:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=ekkk4fhm70B4YuzLcthwoHerH7A51v/Jy5//bpD3aO0=;
        b=XwMc4G3sw3DurUHxkWNHnGYEZiAMTiFQATPionl+iDfAFIX84SGMVhA7cCUGL/q63v
         EvE99qNd2YZjoEgrugd+gpEISSLgX7FlH2VENvrXi5j7GgdwJVFx+dIrDkjNFJCqJm8R
         HrQSVg4j97nVxcHb39VbUY1OOShtPoLgsGFaY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=qcWYzFE0LPctjSFslW7SVuJhu8Thd1IzXZrW9omJ17KoTxrrUkObaKwB3/jDgZHGZK
         qsQ8QvgPVH09HuBOdwor1iIOt8aRBkt4KPZDRraAbFa0wEo9dYVrhkvDSt/3WM3DuzO8
         6jOr57pLUBLjlTV+/wUd8r705uhDsRViYRQg0=
Received: by 10.86.187.10 with SMTP id k10mr646885fgf.49.1258684275925;
        Thu, 19 Nov 2009 18:31:15 -0800 (PST)
Received: from localhost (ppp91-76-17-113.pppoe.mtu-net.ru [91.76.17.113])
        by mx.google.com with ESMTPS id l19sm2420092fgb.8.2009.11.19.18.31.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 19 Nov 2009 18:31:15 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <00d401ca6954$a29fa020$e7dee060$@com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133297>

On Thu, Nov 19, 2009 at 03:12:35PM -0500, George Dennie wrote:
> 
> I think an important piece of conceptual information missing from the docs
> is a concise list of the conceptual properties defining the context of the
> working tree, index, and repository during normal use. This itemization
> would go far in explaining the synergies between the various commands. 

Speaking about "normal use"... I suggest you read about Git workflows:

$ git help gitworkflows

> 
> Functionally, all the commands merely manipulate these properties. If these
> properties were summarize in context one would expect that would represent a
> very complete functional model of Git. A user could review the description
> figure what they wanted to do and then find the command(s) to accomplish it.

It is like to say that driving a car merely means to manipulate its
components, so if these components were summarized, it would be all
that one needs to know to drive a car...

While I don't dispute that basic understanding of key Git concepts is
important, understanding of a typical Git workflow cannot be deduced
from knowledge of separate parts. Now if I were to describe Git just in
a few words, I would say that Git repository is just a DAG of objects,
the working tree is the place where you work, and the index is what
helps you to create fine-grained commits and do merges. But it says
very little (if anything) about how to use it.


Dmitry
