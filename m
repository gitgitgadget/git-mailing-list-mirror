From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Conforming to pep8
Date: Fri, 09 May 2014 16:33:47 +0200
Message-ID: <536CE74B.8050302@alum.mit.edu>
References: <20140509015429.GA550@wst420> <20140509020908.GG9218@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Pete Wyckoff <pw@padd.com>
To: Jonathan Nieder <jrnieder@gmail.com>,
	William Giokas <1007380@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 09 16:33:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wils4-0002IX-Dy
	for gcvg-git-2@plane.gmane.org; Fri, 09 May 2014 16:33:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756787AbaEIOdw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 May 2014 10:33:52 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:49001 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755542AbaEIOdv (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 May 2014 10:33:51 -0400
X-AuditID: 12074413-f79076d000002d17-72-536ce74e54f5
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 74.69.11543.E47EC635; Fri,  9 May 2014 10:33:50 -0400 (EDT)
Received: from [192.168.69.130] (p5DDB2E4D.dip0.t-ipconnect.de [93.219.46.77])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s49EXm6n025496
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Fri, 9 May 2014 10:33:49 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.4.0
In-Reply-To: <20140509020908.GG9218@google.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLKsWRmVeSWpSXmKPExsUixO6iqOv3PCfY4MkcM4t3j28wWXRd6Way
	eHtzCaPFpIudrA4sHjtn3WX3+HVkPbvH501yAcxR3DZJiSVlwZnpefp2CdwZH+Z9ZilYwFvR
	vKaVtYHxHFcXIyeHhICJxN22rWwQtpjEhXvrgWwuDiGBy4wSCy53s0A4Z5kk+uesYgWp4hXQ
	lnhw4AiYzSKgKtF5dDUziM0moCuxqKeZqYuRg0NUIEjiz1lFiHJBiZMzn7CA2CICPhLtS68x
	gtjMAsYSX76sBIsLC8hLTPp6jQnEFgKqeTKzDSzOKaAvceH5aWaQkRIC4hI9jUEQrToS7/oe
	MEPY8hLb385hnsAoOAvJtllIymYhKVvAyLyKUS4xpzRXNzcxM6c4NVm3ODkxLy+1SNdcLzez
	RC81pXQTIyS4hXcw7jopd4hRgINRiYfXYXp2sBBrYllxZe4hRkkOJiVRXtEtOcFCfEn5KZUZ
	icUZ8UWlOanFhxglOJiVRHg1DwPleFMSK6tSi/JhUtIcLErivGpL1P2EBNITS1KzU1MLUotg
	sjIcHEoSvJbPgBoFi1LTUyvSMnNKENJMHJwgw7mkRIpT81JSixJLSzLiQfEbXwyMYJAUD9De
	qqcge4sLEnOBohCtpxh1OS40rGhhEmLJy89LlRLnZQYpEgApyijNg1sBS2WvGMWBPhbmtQG5
	hAeYBuEmvQJawgS0xFc/G2RJSSJCSqqBcVeDccj+Nd9l2Wy+ce9bOpMjRez2vqve+ln2h8uW
	MDlNm86wT+rekWMeTMpnjs09vbb3v6hQT2fCzz+SbIs1pm+xuRV5SfCQ0JOSvwVT 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248560>

On 05/09/2014 04:09 AM, Jonathan Nieder wrote:
> (cc-ing Pete Wyckoff who maintains git-p4 and Michael Haggerty
> who maintains git-multimail)
> William Giokas wrote:
> 
>>      - We follow PEP-8 (http://www.python.org/dev/peps/pep-0008/).
>>
>> It's even the first thing that you see when you go looking for 'python'
>> in the coding style document. I just ran every file in the tree that
>> either ended in '.py' or had a python #!, and was greeted with a whole
>> bunch of output::
>>
>>     ./git-p4.py
>>     ./contrib/svn-fe/svnrdump_sim.py
>>     ./contrib/remote-helpers/git-remote-bzr
>>     ./contrib/hooks/multimail/post-receive
>>     ./contrib/hooks/multimail/migrate-mailhook-config
>>     ./contrib/hooks/multimail/git_multimail.py
>>     ./contrib/hooks/multimail/README
>>     ./contrib/hg-to-git/hg-to-git.py
>>     ./contrib/gitview/gitview
>>     ./contrib/fast-import/import-zips.py
> 
> Thanks for running this check.  Passing on the result to the
> maintainers of some of those scripts in case they have thoughts.
> 
> [...]

Thanks for the heads-up, William and Jonathan.  I wasn't aware of the
pep8 tool.  Though I think it enforces a couple of rules that go a bit
beyond PEP8, I don't mind conforming to it, at least with options

    --max-line-length=99 --hang-closing

I just committed a change to my upstream repository that gets pep8 to
run cleanly on all Python files.

I don't think it is worth making an extra code drop to Git just to push
these mild stylistic changes, but if somebody disagrees you know where
to find my repo.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
