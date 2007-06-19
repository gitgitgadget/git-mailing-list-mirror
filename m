From: Bill Lear <rael@zopyra.com>
Subject: Re: Errors building git-1.5.2.2 on 64-bit Centos 5
Date: Tue, 19 Jun 2007 08:50:03 -0500
Message-ID: <18039.57099.57602.28299@lisa.zopyra.com>
References: <18039.52754.563688.907038@lisa.zopyra.com>
	<Pine.LNX.4.64.0706191359160.4059@racer.site>
	<20070619132456.GA15023@fiberbit.xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Marco Roeland <marco.roeland@xs4all.nl>
X-From: git-owner@vger.kernel.org Tue Jun 19 15:50:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I0e6W-0003X2-0y
	for gcvg-git@gmane.org; Tue, 19 Jun 2007 15:50:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751543AbXFSNu1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Jun 2007 09:50:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751493AbXFSNu0
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Jun 2007 09:50:26 -0400
Received: from mail.zopyra.com ([65.68.225.25]:61994 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750755AbXFSNu0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jun 2007 09:50:26 -0400
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id l5JDo6E24553;
	Tue, 19 Jun 2007 08:50:06 -0500
In-Reply-To: <20070619132456.GA15023@fiberbit.xs4all.nl>
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50480>

On Tuesday, June 19, 2007 at 15:24:56 (+0200) Marco Roeland writes:
>On Tuesday June 19th 2007 at 14:00 Johannes Schindelin wrote:
>
>> On Tue, 19 Jun 2007, Bill Lear wrote:
>> 
>> > Also breaks (tar fails) if I do the 'make configure; ./configure'
>> > route.
>> 
>> Then there is a test missing in configure.
>> 
>> > /home/blear/build/git-1.5.2.2/utf8.c:328: undefined reference to `libiconv'
>> 
>> You are missing libiconv.
>
>On Linux there usually is no separate libiconv as this is integrated
>into GNU libc. Most of the time this kind of error results when somehow
>there _is_ a separate installation of libiconv under /usr/local/lib or
>something. An #include <iconv.h> then finds the version under
>/usr/local/include/iconv.h which has rather different definitions, due to
>using all kind of macros.
>
>If this is Bills situation try uninstalling the separate iconv package
>or at least temporarily rename its iconv.h header.

Well, I'll try that, but this is a fresh install of Centos 5, not a
custom-hacked OS, and I would think that git should build out of the
box on it.

I checked and there is no iconv package (rpm).  I really don't want
to have to temporarily rename a header.  I can't hand this out to
the rest of the company, some of whom do not have root access to
be able to rename header files.


Bill
