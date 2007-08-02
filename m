From: Marko Macek <Marko.Macek@gmx.net>
Subject: Re: cvs2svn conversion directly to git ready for experimentation
Date: Thu, 02 Aug 2007 21:22:31 +0200
Message-ID: <46B22EF7.80108@gmx.net>
References: <46AFCF3E.5010805@alum.mit.edu> <65F1862F-4DF2-4A52-9FD5-20802AEACDAB@zib.de> <46B2132D.7090304@alum.mit.edu>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000906080907050601000803"
To: Michael Haggerty <mhagger@alum.mit.edu>,  git@vger.kernel.org, 
 users@cvs2svn.tigris.org,  prohaska@zib.de
X-From: users-return-1609-gcvscu-users=m.gmane.org@cvs2svn.tigris.org Thu Aug 02 21:23:20 2007
Return-path: <users-return-1609-gcvscu-users=m.gmane.org@cvs2svn.tigris.org>
Envelope-to: gcvscu-users@gmane.org
Received: from sc157.sjc.collab.net ([204.16.104.146] helo=tigris.org)
	by lo.gmane.org with smtp (Exim 4.50)
	id 1IGgGV-0003kk-Mj
	for gcvscu-users@gmane.org; Thu, 02 Aug 2007 21:23:20 +0200
Received: (qmail 4255 invoked by uid 5000); 2 Aug 2007 19:23:18 -0000
Mailing-List: contact users-help@cvs2svn.tigris.org; run by ezmlm
Precedence: bulk
list-help: <mailto:users-help@cvs2svn.tigris.org>
list-unsubscribe: <mailto:users-unsubscribe@cvs2svn.tigris.org>
list-post: <mailto:users@cvs2svn.tigris.org>
Delivered-To: mailing list users@cvs2svn.tigris.org
Received: (qmail 4241 invoked from network); 2 Aug 2007 19:23:18 -0000
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AgAAAHLMsUbVpUAUkmdsb2JhbACOEwEBAgcEBBEW
X-IronPort-AV: i="4.19,215,1183359600"; 
 d="png'150?scan'150,208,150"; a="78859159:sNHT34714484"
X-IRONPORT: SCANNED
X-Authenticated: #420190
X-Provags-ID: V01U2FsdGVkX1+0ycVEni+0AQ2eI6fSPiFmFq17O2aN8cjWdRQnI3
	ZDH1vfFyj+CCFg
User-Agent: Thunderbird 2.0.0.5 (X11/20070716)
In-Reply-To: <46B2132D.7090304@alum.mit.edu>
X-Y-GMX-Trusted: 0
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54588>

--------------000906080907050601000803
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Michael Haggerty wrote:
> This can definitely be caused by unlabeled branches.  It can also be
> caused by branches rooted in a vendor branch.  In many cases, such
> branches can actually be grafted onto trunk, but cvs2svn does not (yet)
> attempt this.

It would be nice to be able to exclude the vendor branch if only 
the initial commit was made on it (or maybe handle it better, by 
remapping the commits to the main branch when they match).

I have tested this on my repository and currently gitk draws 
large 'railroad switching stations' because many tags have the 
vendor branch as a parent (and in some cases also the parent branch, 
in addition to the parent commit).

	Mark

--------------000906080907050601000803
Content-Type: image/png;
 name="railroad.png"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="railroad.png"

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

--------------000906080907050601000803
Content-Type: text/plain; charset=iso-8859-1

---------------------------------------------------------------------
To unsubscribe, e-mail: users-unsubscribe@cvs2svn.tigris.org
For additional commands, e-mail: users-help@cvs2svn.tigris.org
--------------000906080907050601000803--
