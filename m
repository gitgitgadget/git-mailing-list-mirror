From: Josef Wolf <jw@raven.inka.de>
Subject: Re: Problems using perl's Git.pm module
Date: Fri, 3 Dec 2010 09:38:28 +0100
Message-ID: <20101203083827.GD26070@raven.wolf.lan>
References: <20101202114003.GA26070@raven.wolf.lan>
 <AANLkTi=8=k9iNWzTnGz821k9A_CZNiEt_KkC8TXu6oS_@mail.gmail.com>
 <7vpqtkrrtc.fsf@alter.siamese.dyndns.org>
 <AANLkTikQdw3aafsfP+SCQ-z9_TZrPJx694QOSeNTrvp6@mail.gmail.com>
 <20101202181425.GG3962@burratino>
 <AANLkTimKKssBbtuLKCqG9WGbOe+-CH4pc5PDaNxCH_PS@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= <avarab@gmail.com>,
	git@vger.kernel.org, Petr Baudis <pasky@suse.cz>
To: demerphq <demerphq@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 03 09:40:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PORBk-0003wj-Rp
	for gcvg-git-2@lo.gmane.org; Fri, 03 Dec 2010 09:40:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753505Ab0LCIkN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Dec 2010 03:40:13 -0500
Received: from quechua.inka.de ([193.197.184.2]:45156 "EHLO mail.inka.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751802Ab0LCIkM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Dec 2010 03:40:12 -0500
Received: from raven.inka.de (uucp@[127.0.0.1])
	by mail.inka.de with uucp (rmailwrap 0.5) 
	id 1PORBa-0003ea-Sv; Fri, 03 Dec 2010 09:40:10 +0100
Received: by raven.inka.de (Postfix, from userid 1000)
	id A2CDB76337; Fri,  3 Dec 2010 09:38:28 +0100 (CET)
Mail-Followup-To: Josef Wolf <jw@raven.inka.de>,
	demerphq <demerphq@gmail.com>, Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= <avarab@gmail.com>,
	git@vger.kernel.org, Petr Baudis <pasky@suse.cz>
Content-Disposition: inline
In-Reply-To: <AANLkTimKKssBbtuLKCqG9WGbOe+-CH4pc5PDaNxCH_PS@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162773>

On Thu, Dec 02, 2010 at 07:41:00PM +0100, demerphq wrote:
> Well, the counter  arguments are:
> 
> No back-compat layer for older gits. Tight binding to a particular git
> - no availability of upgrades independent of upgrading git.

I don't understand this one. Why do you need independent upgrades here?
Since Git.pm comes with git core, the installed version of Git.pm should
always match the installed version of git.

> No
> availability or review of the module on the standard venues for doing
> so for Perl modules. CPAN, CPANTESTERS, smoke reports, etc.

A module on CPAN has better tests for perl integration.
A module in git-core has better tests for git integration.

You trade one for the other. The question is which is more critical. IMHO,
git-integration is more critical.
