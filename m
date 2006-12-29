From: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: Re: [RFH] An early draft of v1.5.0 release notes
Date: Fri, 29 Dec 2006 12:56:00 +0100
Message-ID: <87k60alxv3.fsf@morpheus.local>
References: <200612271300.kBRD082j007703@laptop13.inf.utfsm.cl> <7vtzzh5dnv.fsf@assigned-by-dhcp.cox.net> <7vbqlo4zg8.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0612272041421.18171@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Fri Dec 29 12:56:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1H0GLV-0006Sh-8z
	for gcvg-git@gmane.org; Fri, 29 Dec 2006 12:56:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752313AbWL2L4O convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 29 Dec 2006 06:56:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752314AbWL2L4O
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Dec 2006 06:56:14 -0500
Received: from main.gmane.org ([80.91.229.2]:36038 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752281AbWL2L4N (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Dec 2006 06:56:13 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1H0GLG-0007kk-77
	for git@vger.kernel.org; Fri, 29 Dec 2006 12:56:06 +0100
Received: from c83-253-22-207.bredband.comhem.se ([83.253.22.207])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 29 Dec 2006 12:56:06 +0100
Received: from davidk by c83-253-22-207.bredband.comhem.se with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 29 Dec 2006 12:56:06 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: c83-253-22-207.bredband.comhem.se
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (gnu/linux)
Cancel-Lock: sha1:RaNZGePsQm2Wcbze87uet5b4uHA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35589>

Nicolas Pitre <nico@cam.org> writes:

> On Wed, 27 Dec 2006, Junio C Hamano wrote:
>
>> Junio C Hamano <junkio@cox.net> writes:
>>=20
>> > "Horst H. von Brand" <vonbrand@inf.utfsm.cl> writes:
>> > ...
>> >> And what happens to the people who can't/won't display UTF-8? Thi=
s is a
>> >> both a project wide configuration (how does stuff get saved) + a =
user/local
>> >> configuration (how to display stuff).
>> > ...
>> > Maybe i18n.displayencoding set to latin1 is what you are after?
>> > I think it might make sense...
>>=20
>> I've done this and will be pushing the result out in 'next'
>> shortly, with a new test.  I find the result mostly sensible.
>
> Shouldn't the LANG environment variable be used for this purpose=20
> instead?

You mean LC_CTYPE, no?

--=20
David K=C3=A5gedal
