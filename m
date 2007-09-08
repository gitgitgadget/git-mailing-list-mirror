From: David Kastrup <dak@gnu.org>
Subject: Re: [RFC] Convert builin-mailinfo.c to use The Better String Library.
Date: Sat, 08 Sep 2007 08:25:00 +0200
Message-ID: <854pi51xoj.fsf@lola.goethe.zz>
References: <46DDC500.5000606@etek.chalmers.se>
	<alpine.LFD.0.999.0709061839510.5626@evo.linux-foundation.org>
	<a1bbc6950709061721r537b153eu1b0bb3c27fb7bd51@mail.gmail.com>
	<alpine.LFD.0.999.0709070135361.5626@evo.linux-foundation.org>
	<a1bbc6950709061808q85cf75co75f2331dc2bdbcbe@mail.gmail.com>
	<alpine.LFD.0.999.0709070212300.5626@evo.linux-foundation.org>
	<a1bbc6950709062009x59a41cb7re6051739c11e370c@mail.gmail.com>
	<46E0F04D.7040101@op5.se>
	<a1bbc6950709071517n7e7e99ffl3dd351092e7f19d6@mail.gmail.com>
	<85sl5q1570.fsf@lola.goethe.zz>
	<a1bbc6950709071737h155c78b7ie6d2b77719239a6a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Andreas Ericsson" <ae@op5.se>,
	"Linus Torvalds" <torvalds@linux-foundation.org>,
	"Matthieu Moy" <Matthieu.Moy@imag.fr>, Git <git@vger.kernel.org>
To: "Dmitry Kakurin" <dmitry.kakurin@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 08 08:25:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITtkm-0007oj-HP
	for gcvg-git@gmane.org; Sat, 08 Sep 2007 08:25:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751153AbXIHGZH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 8 Sep 2007 02:25:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751134AbXIHGZG
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Sep 2007 02:25:06 -0400
Received: from mail-in-12.arcor-online.net ([151.189.21.52]:49772 "EHLO
	mail-in-12.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751114AbXIHGZE (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 8 Sep 2007 02:25:04 -0400
Received: from mail-in-09-z2.arcor-online.net (mail-in-09-z2.arcor-online.net [151.189.8.21])
	by mail-in-12.arcor-online.net (Postfix) with ESMTP id DAE3C4C543;
	Sat,  8 Sep 2007 08:25:03 +0200 (CEST)
Received: from mail-in-02.arcor-online.net (mail-in-02.arcor-online.net [151.189.21.42])
	by mail-in-09-z2.arcor-online.net (Postfix) with ESMTP id C764428EBDA;
	Sat,  8 Sep 2007 08:25:03 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-013-010.pools.arcor-ip.net [84.61.13.10])
	by mail-in-02.arcor-online.net (Postfix) with ESMTP id A631236E867;
	Sat,  8 Sep 2007 08:25:03 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 08FC01CAD71D; Sat,  8 Sep 2007 08:25:00 +0200 (CEST)
In-Reply-To: <a1bbc6950709071737h155c78b7ie6d2b77719239a6a@mail.gmail.com> (Dmitry Kakurin's message of "Fri\, 7 Sep 2007 17\:37\:38 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58104>

"Dmitry Kakurin" <dmitry.kakurin@gmail.com> writes:

> On 9/7/07, David Kastrup <dak@gnu.org> wrote:
>> Just compiling under C++, with no source changes, is likely to impact
>> performance and compile time rather badly
>
> This in fact is a very specific statement. Would you care to back it
> up with facts?

Read up on the Linux kernel history in the archives.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
