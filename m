From: John Goerzen <jgoerzen@complete.org>
Subject: Re: FastCGI support in gitweb
Date: Mon, 3 Mar 2008 21:59:07 -0600
Message-ID: <slrnfspi8b.83u.jgoerzen@katherina.lan.complete.org>
References: <1c3be50f0803011334u2629011cg85cb8728a244ea4e@mail.gmail.com> <m38x12jeqt.fsf@localhost.localdomain> <47CBEED2.30808@vilain.net> <200803040119.22240.jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 04 05:09:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWOSk-0002iL-4c
	for gcvg-git-2@gmane.org; Tue, 04 Mar 2008 05:09:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754752AbYCDEIY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2008 23:08:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754162AbYCDEIY
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Mar 2008 23:08:24 -0500
Received: from main.gmane.org ([80.91.229.2]:49230 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754000AbYCDEIX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2008 23:08:23 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JWORu-0006rH-48
	for git@vger.kernel.org; Tue, 04 Mar 2008 04:08:18 +0000
Received: from 63-245-179-205.kitusa.com ([63.245.179.205])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 04 Mar 2008 04:08:18 +0000
Received: from jgoerzen by 63-245-179-205.kitusa.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 04 Mar 2008 04:08:18 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 63-245-179-205.kitusa.com
User-Agent: slrn/0.9.8.1pl1 (Debian)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76030>

On 2008-03-04, Jakub Narebski <jnareb@gmail.com> wrote:
>> Thanks.  I didn't submit this because I couldn't fix the bugs in it.
>> Glad you found it.  I had to make many changes in a similar vein with a
>> current gitweb version; did it work for you in its current form?
>
> I couldn't test it with FastCGI server, as I use Apache2, and all
> FastCGI modules for Apache are third part modules. Besides, it doesn't

On Debian, this was as easy as apt-get install libapache2-mod-fcgid

> make much sense to use generic FastCGI for Perl, when there is mod_perl
> module.

Sure it can.  I currently am running both Python and Ruby code under
FastCGI.  Adding mod_perl for just one program increases my
webserver's memory footprint, potentially dramatically, and increases
my complexity as well.  I'd much rather run FastCGI than mod_perl.


