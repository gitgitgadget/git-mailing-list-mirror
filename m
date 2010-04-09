From: Eric Raymond <esr@thyrsus.com>
Subject: Re: Status of all files (was: Re: How can I tell if a file is
 ignored by git?
Date: Fri, 9 Apr 2010 12:24:25 -0400
Organization: Eric Conspiracy Secret Labs
Message-ID: <20100409162425.GA32575@thyrsus.com>
References: <20100409040434.8602620CBBC@snark.thyrsus.com>
 <j2z8c9a061004082110se894f925i80c1389cd4e247f@mail.gmail.com>
 <20100409113248.GB27353@thyrsus.com>
 <m3sk74hjkg.fsf@localhost.localdomain>
 <20100409140215.GB27899@thyrsus.com>
 <vpqy6gw7lio.fsf@bauges.imag.fr>
Reply-To: esr@thyrsus.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>,
	Jacob Helwig <jacob.helwig@gmail.com>,
	Eric Raymond <esr@snark.thyrsus.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Apr 09 18:24:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0H0T-0002RA-M4
	for gcvg-git-2@lo.gmane.org; Fri, 09 Apr 2010 18:24:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754283Ab0DIQY1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Apr 2010 12:24:27 -0400
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:56728
	"EHLO snark.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751041Ab0DIQY0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Apr 2010 12:24:26 -0400
Received: by snark.thyrsus.com (Postfix, from userid 23)
	id 83081475FEF; Fri,  9 Apr 2010 12:24:25 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <vpqy6gw7lio.fsf@bauges.imag.fr>
X-Eric-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144450>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>:
> Eric Raymond <esr@thyrsus.com> writes:
> 
> > (The ls-files -t codes need better documentation.  If I get detailed enough
> > answers, I will write some.)
> 
> http://thread.gmane.org/gmane.comp.version-control.git/126516
> 
> In short, "git ls-files -t" was written long ago, never tested, and
> probably mostly used by no one. It has a very strange behavior, it's
> not just the doc. I'd advise against using it.

It sounds very much to me as though this feature should be scheduled
for deletion.
 
> "git status --porcelain" is probably what you want:
> 
>        --porcelain
>            Give the output in a stable, easy-to-parse format for
>            scripts. Currently this is identical to --short output, but
>            is guaranteed not to change in the future, making it safe
>            for scripts.

Yes, this looks like what I would want, all right - if the status
codes were actually *comprehensible*! 

We should tackle this right now, because VC is not the last front end
that will need to parse the format and at least I am willing to patch
your docs based on what I learn.  Most of your other customers won't
do that.

I'm going to start a separate thread about this.
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>
