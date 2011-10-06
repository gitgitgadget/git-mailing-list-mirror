From: Thorkil Naur <naur@post11.tele.dk>
Subject: Re: How do I investigate apparently random git clone reports of
	"error: File ... has bad hash"?
Date: Thu, 6 Oct 2011 04:34:33 +0200
Message-ID: <20111006023425.GA2554@tn24>
References: <loom.20110911T210035-693@post.gmane.org>
	<m2r53metpo.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: cvs-ghc <cvs-ghc@haskell.org>, git@vger.kernel.org
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: cvs-ghc-bounces@haskell.org Thu Oct 06 04:34:46 2011
Return-path: <cvs-ghc-bounces@haskell.org>
Envelope-to: haskell-cvs-ghc@m.gmane.org
Received: from lambda.haskell.org ([78.46.100.180])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <cvs-ghc-bounces@haskell.org>)
	id 1RBdnK-0008Kv-5h
	for haskell-cvs-ghc@m.gmane.org; Thu, 06 Oct 2011 04:34:46 +0200
Received: from localhost ([127.0.0.1] helo=lambda.haskell.org)
	by lambda.haskell.org with esmtp (Exim 4.69)
	(envelope-from <cvs-ghc-bounces@haskell.org>)
	id 1RBdnD-0000YE-C9; Thu, 06 Oct 2011 04:34:39 +0200
Received: from fep48.mail.dk ([195.41.46.231])
	by lambda.haskell.org with esmtp (Exim 4.69)
	(envelope-from <naur@post11.tele.dk>) id 1RBdnB-0000Xt-4u
	for cvs-ghc@haskell.org; Thu, 06 Oct 2011 04:34:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; d=mail.dk; s=dkim512; c=relaxed/simple;
	q=dns/txt; i=@mail.dk; t=1317868476;
	h=From:Subject:Date:To:X-TDCLU:X-TDC-Sender-From-IP:X-TDCCM:MIME-Version:Content-Type;
	bh=jhKK1J0S+uCN+e1ypwoT7MNWz6NEwHHkdw8yLECvGVA=;
	b=sHKi26Gqb1AYmTop8D4fxenmpf/ZwP356PMVGK0SUyOGLnxR+0MwPGEARbzv1njW
	sESISbgCPw7f3q8YFdXLyQ==;
X-TDC-Sender-From-IP: 87.58.52.58
X-TDCCM: v=2.0 cv=H6RsC6Hu c=1 sm=0 a=g5E0v2836JlJiYKsdgLjAQ==:17
	a=XYJHFtupD_QA:10 a=t7DaeAZO0rIA:10 a=kj9zAlcOel0A:10
	a=JqsHG6aPAAAA:8 a=tBb2bbeoAAAA:8 a=GqJYzsXzbFBoYYmoRakA:9
	a=tbFGVTYj2cz5WSpypEgA:7 a=CjuIK1q_8ugA:10 a=f2jPalWG8NMA:10
	a=7-EpqHia3K8A:10 a=YuKU6ANggZ8A:10 a=g5E0v2836JlJiYKsdgLjAQ==:117
X-TDCLU: MTIwMDEwMzgxMzI1
Received: from [87.58.52.58] ([87.58.52.58:22828] helo=localhost)
	by fep48.mail.dk (envelope-from <naur@post11.tele.dk>)
	(ecelerity 2.2.3.47 r(39824M)) with ESMTPA
	id 40/F1-00170-BB31D8E4; Thu, 06 Oct 2011 04:34:36 +0200
Content-Disposition: inline
In-Reply-To: <m2r53metpo.fsf@igel.home>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-BeenThere: cvs-ghc@haskell.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: GHC/CVS discussion and fptools/ghc CVS commit messages
	<cvs-ghc.haskell.org>
List-Unsubscribe: <http://www.haskell.org/mailman/options/cvs-ghc>,
	<mailto:cvs-ghc-request@haskell.org?subject=unsubscribe>
List-Archive: <http://www.haskell.org/pipermail/cvs-ghc>
List-Post: <mailto:cvs-ghc@haskell.org>
List-Help: <mailto:cvs-ghc-request@haskell.org?subject=help>
List-Subscribe: <http://www.haskell.org/mailman/listinfo/cvs-ghc>,
	<mailto:cvs-ghc-request@haskell.org?subject=subscribe>
Sender: cvs-ghc-bounces@haskell.org
Errors-To: cvs-ghc-bounces@haskell.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182919>

Hello Andreas,

Thank you very much for your response. I have separately received the
advice of upgrading my curl installation:

> Date: Fri, 30 Sep 2011 09:08:56 +0200
> From: Karel Gardas <karel.gardas@centrum.cz>
> To: cvs-ghc <cvs-ghc@haskell.org>
> Subject: Re: tn23 (x86 OSX HEAD), build 442, Failure
> ...
> Hello,
>
> my opensolaris builder machine also suffered from the same issue like
> tn23 and sometimes even mbolingbroke and others. Symptoms are you are
> not able to grab the ghc code or subrepos code. The solution is
> simple: (1) either remove curl from your path or (2) update curl to
> the latest version (7.21.7 works for me) and make sure it is really
> using its latest libcurl. Once I did (2) here I've never seen the
> issue again.
> ...

Additional details:

> http://www.haskell.org/pipermail/cvs-ghc/2011-October/066434.html

So it appears that upgrading curl has removed the problem.

Best regards
Thorkil

On Sun, Sep 11, 2011 at 09:59:15PM +0200, Andreas Schwab wrote:
> Thorkil Naur <naur@post11.tele.dk> writes:
> 
> >> $ git clone http://darcs.haskell.org/ghc.git/ build8
> >> Cloning into build8...
> >> error: File 42988feeeb76f5cb92b541e9dac277e073bcb3ef has bad hash
> >> error: Unable to find 42988feeeb76f5cb92b541e9dac277e073bcb3ef under
> > http://darcs.haskell.org/ghc.git
> >> Cannot obtain needed blob 42988feeeb76f5cb92b541e9dac277e073bcb3ef
> >> while processing commit ffb2e81c03a01e74825b3a0223e214df59241fab.
> >> error: Fetch failed.
> 
> I just tried to clone it and got this error:
> 
> $ git clone http://darcs.haskell.org/ghc.git
> Cloning into ghc...
> error: Recv failure: Connection reset by peer (curl_result = 56, http_code = 0, sha1 = be6810bb027643bf0697b3d237426110f064aba1)
> error: Unable to find be6810bb027643bf0697b3d237426110f064aba1 under http://darcs.haskell.org/ghc.git
> Cannot obtain needed commit be6810bb027643bf0697b3d237426110f064aba1
> while processing commit 6942b112082fbcdff5c66f06f56fdd336861da47.
> error: Fetch failed.
> 
> It looks like this is just a network problem.
> 
> Btw, the repo is rather strange.  It's not a bare repo, but does not
> contain a .git directory.  Instead the files that are normally under
> .git are placed directly in the working tree.
> 
> Andreas.
> 
> -- 
> Andreas Schwab, schwab@linux-m68k.org
> GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
> "And now for something completely different."
