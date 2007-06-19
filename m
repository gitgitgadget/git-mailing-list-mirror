From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH/RFC] config: Add --null/-z option for null-delimted output
Date: Tue, 19 Jun 2007 13:19:28 +0200
Message-ID: <86myywtcn3.fsf@lola.quinscape.zz>
References: <f2t6na$5bi$1@sea.gmane.org> <11821227322913-git-send-email-frank@lichtenheld.de> <Pine.LNX.4.64.0706190151160.4059@racer.site> <7v645kyba8.fsf@assigned-by-dhcp.pobox.com> <20070619021252.GE19725@planck.djpig.de> <Pine.LNX.4.64.0706191208300.4059@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 19 13:40:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I0c4S-0001BQ-Ji
	for gcvg-git@gmane.org; Tue, 19 Jun 2007 13:40:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755411AbXFSLk1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Jun 2007 07:40:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754756AbXFSLk1
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Jun 2007 07:40:27 -0400
Received: from main.gmane.org ([80.91.229.2]:53628 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753922AbXFSLk0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jun 2007 07:40:26 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1I0bvl-00027e-5u
	for git@vger.kernel.org; Tue, 19 Jun 2007 13:31:29 +0200
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 19 Jun 2007 13:31:29 +0200
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 19 Jun 2007 13:31:29 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.51 (gnu/linux)
Cancel-Lock: sha1:3c5qWpJHkRLRZnC/6DijN58bZBs=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50470>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi,
>
> On Tue, 19 Jun 2007, Frank Lichtenheld wrote:
>
>> On Mon, Jun 18, 2007 at 06:37:35PM -0700, Junio C Hamano wrote:
>> > Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>> > Another possibility, though, is to say:
>> > 
>> > 	core.some\0where\0core.over\0\0core.the\0core.rainbow\0
>> 
>> How do you denote empty values then?
>> 
>> [section]
>> 	key=
>> 	key
>> 
>> this are two very different statements atm (e.g. the one is false and
>> the other one is true).
>> 
>> I still think using two different delimiters is the simplest choice.
>
> Okay, good point. But of course, you have to use a delimiter for the key 
> name that cannot be part of the keyname. You picked '\n'. The original was 
> '='. Both work.

In the interest of simplicity, it would appear reasonable to use just
= and not introduce an additional delimiter.  This is similar to how
environments are handled and passed in Unix (though not necessarily
relevant).

-- 
David Kastrup
