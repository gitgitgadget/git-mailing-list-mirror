From: David Kastrup <dak@gnu.org>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Thu, 17 Jan 2008 01:32:01 +0100
Message-ID: <85zlv5nvge.fsf@lola.goethe.zz>
References: <478E1FED.5010801@web.de> <m33asxn2gt.fsf@roke.D-201>
	<65026F2B-5CE8-4238-A9AB-D3545D336B41@sb.org>
	<200801162251.54219.jnareb@gmail.com>
	<1574A90A-8C45-46AD-9402-34AE6F582B3F@sb.org>
	<alpine.LFD.1.00.0801161424040.2806@woody.linux-foundation.org>
	<7652B11D-9B9F-45EA-9465-8294B701FE7C@sb.org>
	<alpine.LFD.1.00.0801161522160.2806@woody.linux-foundation.org>
	<BA518A23-FBF8-49BB-BEFB-D9A6BA1E302C@simplicidade.org>
	<alpine.LFD.1.00.0801161615330.2806@woody.linux-foundation.org>
	<E8E76634-FFEC-426B-B04D-3C2CD3790D5E@simplicidade.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Kevin Ballard <kevin@sb.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mark Junker <mjscod@web.de>, git@vger.kernel.org
To: Pedro Melo <melo@simplicidade.org>
X-From: git-owner@vger.kernel.org Thu Jan 17 01:32:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFIgb-0004wE-7F
	for gcvg-git-2@gmane.org; Thu, 17 Jan 2008 01:32:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752511AbYAQAcV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2008 19:32:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752370AbYAQAcV
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jan 2008 19:32:21 -0500
Received: from mail-in-16.arcor-online.net ([151.189.21.56]:52729 "EHLO
	mail-in-16.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751694AbYAQAcU (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Jan 2008 19:32:20 -0500
Received: from mail-in-17-z2.arcor-online.net (mail-in-17-z2.arcor-online.net [151.189.8.34])
	by mail-in-16.arcor-online.net (Postfix) with ESMTP id CFC201F72BE;
	Thu, 17 Jan 2008 01:32:18 +0100 (CET)
Received: from mail-in-10.arcor-online.net (mail-in-10.arcor-online.net [151.189.21.50])
	by mail-in-17-z2.arcor-online.net (Postfix) with ESMTP id BAE6E45C041;
	Thu, 17 Jan 2008 01:32:18 +0100 (CET)
Received: from lola.goethe.zz (dslb-084-061-027-179.pools.arcor-ip.net [84.61.27.179])
	by mail-in-10.arcor-online.net (Postfix) with ESMTP id 66C4726D363;
	Thu, 17 Jan 2008 01:32:04 +0100 (CET)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 135631C0040F; Thu, 17 Jan 2008 01:32:01 +0100 (CET)
In-Reply-To: <E8E76634-FFEC-426B-B04D-3C2CD3790D5E@simplicidade.org> (Pedro
	Melo's message of "Thu, 17 Jan 2008 00:27:52 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.92/5488/Wed Jan 16 21:44:30 2008 on mail-in-10.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70786>

Pedro Melo <melo@simplicidade.org> writes:

> On Jan 17, 2008, at 12:16 AM, Linus Torvalds wrote:
>> On Wed, 16 Jan 2008, Pedro Melo wrote:
>>>
>>> The difference I see between us is that if I tell my filesystem that
>>> I want to name my file with a particular string encoded in X, users
>>> using encoding Y will be able to read it correctly. I like my
>>> filesystem to make that work for me.
>>
>> The difference I see between us is that when I tell you that this is
>> exactly the same thing as your file *contents*, you don't seem to get
>> it.
>
> I get that you think its the same thing.
>
> What I don't get is why a user should be forced to know what type of
> encoding he and the other users are using on all the layers going down
> to the filesystem. If two users on different systems or in different
> configurations, choose the same unicode string as the name, why do we
> need to make it harder for things to just work out?

If you do the normalization in the right place, things will just work
out.  The file system is not the right place.

> I'm willing to accept a file system or other layer that normalizes
> encoding of filenames if that makes the end-user life easier,
> specially in a tool distributed by nature.

Well, as the issue shows it does not make life for the end-user easier.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
