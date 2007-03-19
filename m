From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: any info getting a birdview of Git and its test suite?
Date: Mon, 19 Mar 2007 01:26:02 +0100
Message-ID: <200703190126.02948.jnareb@gmail.com>
References: <3b051c1a0703180043n1dec45by90e5cee3393d2b4d@mail.gmail.com> <etkj4l$li$1@sea.gmane.org> <Pine.LNX.4.63.0703190119140.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: F <ff.pptux@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Mar 19 01:26:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HT5hd-0000mS-0X
	for gcvg-git@gmane.org; Mon, 19 Mar 2007 01:26:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964893AbXCSA0J (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Mar 2007 20:26:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965029AbXCSA0J
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Mar 2007 20:26:09 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:34475 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964893AbXCSA0G (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Mar 2007 20:26:06 -0400
Received: by nf-out-0910.google.com with SMTP id o25so888592nfa
        for <git@vger.kernel.org>; Sun, 18 Mar 2007 17:26:05 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Jea3rT9gMeEr2Cq7TEkPxGiN5kgj8VRRZPnnifU9Dk9dGWSn3ix41YB2L6TsubB0CM3IA+lX9o+vscin0tJRzczEPMEbPddarB7sBz5Mr6Ym1TWcUgWsb+zPqtlQM/bbUUUVASOA/sSufhHFNCOgC8uSPi89iOdPwhAaq1s9WoQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=CkDnA1N3R5O3p2wfnt/b97ALHDDHH4T8H69Lr2TdmZBOtrJ2nOUBwzAQKY60Q1NSHzidXo4Vs/YnHKX2aZ+ny6AN49oiEXuRVC5LmKeNhOQM7LGv0tck/8tNLcanUQ7gQwikbbxVikQSHLRdhRLlO03Q+2j3RUOPqRTTCHMfC6k=
Received: by 10.82.167.5 with SMTP id p5mr8860726bue.1174263965109;
        Sun, 18 Mar 2007 17:26:05 -0700 (PDT)
Received: from host-89-229-25-173.torun.mm.pl ( [89.229.25.173])
        by mx.google.com with ESMTP id y6sm16321269mug.2007.03.18.17.26.03;
        Sun, 18 Mar 2007 17:26:04 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <Pine.LNX.4.63.0703190119140.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42550>

Johannes Schindelin wrote:
> On Mon, 19 Mar 2007, Jakub Narebski wrote:
> 
>> First, it would be hard to work on Git in my opinion if you have no 
>> experience with version control (SCM) software.
> 
> I have to disagree. Git is substantially more sane than CVS, so that it is 
> actually _simpler_ to learn Git than to unlearn CVS and _then_ learn Git.

Well, experience may consist of few days playing with Git. But it is not
what I wanted to say. I wanted to say that before doing any work on Git
tests one should get to know what SCM is about.

By the way, in "more extensive tests" did you want also tests of Git _API_,
and not only git commands (porcelain and plumbing)? IIRC the "more tests"
proposal for SoC2007 was by you...

(And yes, I think that Git has most sane ideas about SCM).

-- 
Jakub Narebski
Poland
