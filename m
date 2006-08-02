From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb.cgi: Customization
Date: Wed, 02 Aug 2006 19:34:29 +0200
Organization: At home
Message-ID: <eaqnm8$gni$1@sea.gmane.org>
References: <20060801225352.26998.qmail@web31801.mail.mud.yahoo.com> <7v8xm8xbaa.fsf@assigned-by-dhcp.cox.net> <1154535801.19994.15.camel@cashmere.sps.mot.com> <20060802165333.GA22726@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Wed Aug 02 19:34:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G8Kc1-0001YO-9h
	for gcvg-git@gmane.org; Wed, 02 Aug 2006 19:34:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751290AbWHBReW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 2 Aug 2006 13:34:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751294AbWHBReW
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Aug 2006 13:34:22 -0400
Received: from main.gmane.org ([80.91.229.2]:31890 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751290AbWHBReW (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Aug 2006 13:34:22 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1G8Kbo-0001Vs-CF
	for git@vger.kernel.org; Wed, 02 Aug 2006 19:34:16 +0200
Received: from host-81-190-31-92.torun.mm.pl ([81.190.31.92])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 02 Aug 2006 19:34:16 +0200
Received: from jnareb by host-81-190-31-92.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 02 Aug 2006 19:34:16 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-31-92.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24660>

Jeff King wrote:

> On Wed, Aug 02, 2006 at 11:23:22AM -0500, Jon Loeliger wrote:
> 
>> With this "params in config.mk" approach, I have to
>> run it multiple times, once for each web server I run.
>>
>> I _really_ would prefer an "include from ." feature
>> where I can place the specific gitweb_config.pm parts
>> in the same directory where gitweb.{pl,cgi} is installed.
> 
> Why don't we have sensible compile-time defaults that can be overridden
> by a run-time config file like every other sane program? For those who
> are opposed to the run-time config, they can simply not have a config
> file.
> 
> See the (completely untested) patch below. Obviously the config file
> name has to be set at build time. However, since it is interpolated by
> perl, you can do clever things like:
>   /etc/gitweb/$ENV{MY_VIRTUAL_HOST}.pl

Besides, we can use _relative_ paths.

I like this proposal the best.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
