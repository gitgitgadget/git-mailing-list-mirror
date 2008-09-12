From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Git User's Survey 2008 partial summary, part 5 - other SCM
Date: Fri, 12 Sep 2008 12:44:58 +0200
Message-ID: <200809121244.59067.jnareb@gmail.com>
References: <200809031607.19722.jnareb@gmail.com> <200809112214.18366.jnareb@gmail.com> <alpine.DEB.1.10.0809111543580.15169@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: David Lang <david@lang.hm>
X-From: git-owner@vger.kernel.org Fri Sep 12 12:46:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ke6AU-0001B3-Sf
	for gcvg-git-2@gmane.org; Fri, 12 Sep 2008 12:46:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752720AbYILKpO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Sep 2008 06:45:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752712AbYILKpO
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Sep 2008 06:45:14 -0400
Received: from gv-out-0910.google.com ([216.239.58.187]:1809 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752451AbYILKpM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Sep 2008 06:45:12 -0400
Received: by gv-out-0910.google.com with SMTP id e6so512604gvc.37
        for <git@vger.kernel.org>; Fri, 12 Sep 2008 03:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=eWm5Sdfnc5Rr/PjZSJwCJyu411xGAtU5zOySBLOzlkA=;
        b=hwIFN1D0KBsJ5c6Qne4O21iK5AYRazdvGXfAHgtOqngYIpER0DXJgnKTb6akNNK1Tp
         cIJmbeu/P59Fn2WXkzeSrMj7SrI7JJEC9redeiZ841sFnZzjN7Dw9XjTD5qkDdNQ2mlD
         Gx1WpVGPDWPkbqwVCX0QoI1XPLThUxr0mplIQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=v2WX+l/Knk5HQvlADKJh3ERSXyL46ZdnBPQllLxAI190HcawhGHXSlhFCRX1cYQK/2
         Zq3SS7SYutjKhHXtXmjVA4LEBT6Evx/E4Ol3On47HDVzPvWKFlf7FYOTry+fyetQYrZ1
         xn4qnCQjWaIJR87rnGFAYtm+HQzFsm8KmSbMI=
Received: by 10.86.26.11 with SMTP id 11mr3057987fgz.12.1221216309044;
        Fri, 12 Sep 2008 03:45:09 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.239.193])
        by mx.google.com with ESMTPS id 4sm12540425fgg.4.2008.09.12.03.45.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 12 Sep 2008 03:45:08 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <alpine.DEB.1.10.0809111543580.15169@asgard.lang.hm>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95698>

On Fri, 12 Sep 2008 00:51, david@lang.hm wrote:
> On Thu, 11 Sep 2008, Jakub Narebski wrote:
> 
> > A bit suprising for me is high place of Perforce.  Another strange
> > thing (and a bit alarming) is that MS Visual SourceSafe has higher
> > place than Monotone; but that might be caused by different design and
> > different target groups of Monotone and Git, which might have caused
> > that the communities have almost no overlap; people choose either Git
> > or Monotone, one or the other.  BitKeeper has also a very low number
> > of active users among Git users... but that is not that strange,
> > considering history.
> 
> I think you are making the wrong assumption here.
> 
> Someone may use CVS becouse they contribute to a project that is only 
> availabe via CVS
> 
> Someone may use Perforce becouse that is the VCS that their company uses

True, I have forgot that "I use this SCM" (or "I used this SCM") doesn't
necessarily mean that one _choose_ this SCM.  One can use some SCM
because it is SCM project uses, or because their company requires it;
but not necessary, as git-svn and git-p4 show one can use Git, and
make it interact with respectively Subversion and Perforce, and trying
to make it look like one uses this other SCM.

> If you do commercial development with Windows you are almsot going to be 
> required to use MS VSS.

I hope not.  Even Microsoft themselves supposedly doesn't recommend
Source(Un)Safe, but MS Visual Studio Team System.

> You are looking at it from the point of view of 'which VCS would you 
> select for a new project', but that would be a very different question.

Right.

> I find it interesting that the number of people who use git and the other 
> DVCS systems in so small. Is this becouse the 'market share' of those 
> other systems is small? Or becouse people who learn git aren't willing to 
> put up with other systems (or vice-versa)? Or is there some other trend 
> or tendancy that makes people who select one DVCS more likely to work on 
> similar projects, so people interested in those types of projects will 
> generally just see a single DVCS system

I don't think 59% (in the example case of using currently Subversion)
is small.  Take into account for example that there are people who (as
seen from responses to other questions in this survey) use SCM (Git)
only to track their private work, never publishing.  Then there are
people who do not track (perhaps with exception of web interfaces)
other projects development using version control systems, even if they
do follow their development.

Side note: the number of replies in "still use" category agrees with
other data, like mentioned Ohloh stacks, or Debian popcon (package
popularity), or Newren research, or vcscomparison research.

-- 
Jakub Narebski
Poland
