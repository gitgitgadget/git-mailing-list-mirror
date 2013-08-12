From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: git should not use a default user.email config value
Date: Mon, 12 Aug 2013 14:54:13 +0200
Message-ID: <5208DAF5.3040006@alum.mit.edu>
References: <20130809134236.28143.75775.reportbug@tglase.lan.tarent.de> <20130809194214.GV14690@google.com> <20130809223758.GB7160@sigill.intra.peff.net> <20130809231928.GY14690@google.com> <20130810064717.GB30185@sigill.intra.peff.net> <52060EF9.2040504@alum.mit.edu> <7vvc3d1o01.fsf@alter.siamese.dyndns.org> <CAH5451nHfOaBzFzkrGvw+TyRj==cVpKF_QdXsTxnn5tTr1c0dw@mail.gmail.com> <20130812123921.GA16088@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Andrew Ardill <andrew.ardill@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Thorsten Glaser <tg@mirbsd.de>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Aug 12 14:54:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V8rdg-0006hj-GS
	for gcvg-git-2@plane.gmane.org; Mon, 12 Aug 2013 14:54:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756298Ab3HLMyU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Aug 2013 08:54:20 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:44104 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756202Ab3HLMyT (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Aug 2013 08:54:19 -0400
X-AuditID: 1207440d-b7f006d000000adf-e0-5208dafae780
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 59.29.02783.AFAD8025; Mon, 12 Aug 2013 08:54:18 -0400 (EDT)
Received: from [192.168.101.152] (mx.berlin.jpk.com [212.222.128.135] (may be forged))
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r7CCsFNX029926
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 12 Aug 2013 08:54:16 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130623 Thunderbird/17.0.7
In-Reply-To: <20130812123921.GA16088@sigill.intra.peff.net>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrLKsWRmVeSWpSXmKPExsUixO6iqPvrFkeQweVeY4vuM01sFl1Xupks
	GnqvMFu8vbmE0eL/jgUsFj9aepgtnvX/ZnRg99g56y67x7Fjrcwedxs0PZ717mH0uHhJ2ePz
	JrkAtihum6TEkrLgzPQ8fbsE7oxJr5ayF0zgrdgzS6KBcTtXFyMnh4SAicS3aY2MELaYxIV7
	69m6GLk4hAQuM0pcXXKBCcK5xiRx//41dpAqXgFtiTmHtrOC2CwCqhIL2/YzgdhsAroSi3qa
	gWwODlGBMIkrv1UhygUlTs58wgJiiwjISnw/vJERZCazQDeTROvLTWBzhAUcJb4/ngW1bBWz
	RPe7O2AJTgFriRl7zrKCDGUWUJdYP08IJMwsIC+x/e0c5gmMArOQ7JiFUDULSdUCRuZVjHKJ
	OaW5urmJmTnFqcm6xcmJeXmpRbpGermZJXqpKaWbGCHBz7uD8f86mUOMAhyMSjy8Hl/Yg4RY
	E8uKK3MPMUpyMCmJ8q6/yREkxJeUn1KZkVicEV9UmpNafIhRgoNZSYRXbR5QjjclsbIqtSgf
	JiXNwaIkzqu2RN1PSCA9sSQ1OzW1ILUIJivDwaEkwasPjHIhwaLU9NSKtMycEoQ0EwcnyHAu
	KZHi1LyU1KLE0pKMeFCcxhcDIxUkxQO01xOknbe4IDEXKArReopRl+Nd07xPjEIsefl5qVLi
	vA4gRQIgRRmleXArYKnuFaM40MfCvN4gVTzANAk36RXQEiagJUbNYEtKEhFSUg2M8gGMbm0p
	C4snft6ll7574aWnpy/0Osv/Wfzk5e05U17M73t/7/a9prfq+tK8fap6swVi82/d 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232189>

On 08/12/2013 02:39 PM, Jeff King wrote:
> On Mon, Aug 12, 2013 at 09:52:45PM +1000, Andrew Ardill wrote:
> 
>> On 11 August 2013 02:58, Junio C Hamano <gitster@pobox.com> wrote:
>>> Perhaps we need a lighter-weight mechanism
>>>
>>>         git init --profile=open
>>>         git clone --profile=open git://git.kernel.org/git.git
>>
>> This is something I would definitely use.
>>
>> All of my work git directories are in a separate folder to my other
>> git directories, and as such it would be extremely convenient if every
>> repository under that folder defaulted to the same profile. That may
>> be asking for too much though!
> 
> We could do something like the patch below, which allows:
> 
>   $ git config --global include./magic/.path .gitconfig-magic
> 
> to read ~/.gitconfig-magic only when we are in a repository with a
> directory component "/magic/".
> 
> I can see how such a thing might be useful, even though I do not have a
> use for that much flexibility myself. I find myself doing this trick for
> things like editor settings, but not for git config. So do not count
> this necessarily as a vote for doing this; it was a fun exercise for me
> that others might find useful.

We could satisfy a whole class of wishes by supporting
user-wide/system-wide git hooks like

    ~/.githooks/{pre,post}-clone     /etc/githooks/{pre,post}-clone
    ~/.githooks/{pre,post}-init      /etc/githooks/{pre,post}-init

I suppose similar functionality could be implemented via git aliases,
but hook scripts are easier to install and share.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
