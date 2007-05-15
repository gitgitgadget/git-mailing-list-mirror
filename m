From: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: Re: [PATCH] gitweb: Do not use absolute font sizes
Date: Mon, 14 May 2007 18:06:54 -0700
Message-ID: <87odkmgaj5.fsf@morpheus.local>
References: <6efbd9b70705071613p23017509qaf9af12c1d14f9cb@mail.gmail.com> <20070509014150.7477.48489.stgit@rover> <f2a3si$ein$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 15 08:25:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HnqTQ-0002ca-1J
	for gcvg-git@gmane.org; Tue, 15 May 2007 08:25:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759108AbXEOGZX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 15 May 2007 02:25:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759563AbXEOGZX
	(ORCPT <rfc822;git-outgoing>); Tue, 15 May 2007 02:25:23 -0400
Received: from main.gmane.org ([80.91.229.2]:60167 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759108AbXEOGZX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 May 2007 02:25:23 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1HnqT0-0001OA-SP
	for git@vger.kernel.org; Tue, 15 May 2007 08:25:02 +0200
Received: from adsl-71-131-20-72.dsl.sntc01.pacbell.net ([71.131.20.72])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 15 May 2007 08:25:02 +0200
Received: from davidk by adsl-71-131-20-72.dsl.sntc01.pacbell.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 15 May 2007 08:25:02 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: adsl-71-131-20-72.dsl.sntc01.pacbell.net
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (gnu/linux)
Cancel-Lock: sha1:qGO3BV1TBf1dDUiqrTg/n6UhyEg=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47319>

Jakub Narebski <jnareb@gmail.com> writes:

> Petr Baudis wrote:
>
>> Note that this patch actually does change visual look of gitweb in F=
irefox
>> with my resolution and default settings - everything is bigger and I=
 can't
>> explain the joy of actually seeing gitweb text that is in _readable_=
 size;
>> also, my horizontal screen real estate feels better used now.
>
> Not everyone has those huge monitors with extreme resultion. For me n=
ew
> gitweb look uses much to big font, so not very much fits in screen.
>
> I'd remove=20
>
>> --- a/gitweb/gitweb.css
>> +++ b/gitweb/gitweb.css
>> @@ -1,6 +1,5 @@
>>  body {
>>         font-family: sans-serif;
>> -       font-size: 12px;
>>         border: solid #d9d8d1;
>>         border-width: 1px;
>>         margin: 10px;
>
> chunk

But then we'd be back to the brain-damaged explicit-pixel sizes.

gitweb is simply using the font size you have configured your browser
to use, and if you think that it too large, you are free to
reconfigure it.

Unfortunately, the problem is that too many web sites explicitly
select extra small font sizes, which means that you have to select a
"standard" font size in your browser that is a bit larger than you'd
actually like.

--=20
David K=C3=A5gedal
