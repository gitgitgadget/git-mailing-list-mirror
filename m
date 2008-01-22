From: David Kastrup <dak@gnu.org>
Subject: Re: [RFC] File system difference handling in git
Date: Tue, 22 Jan 2008 21:21:03 +0100
Message-ID: <85ve5l393k.fsf@lola.goethe.zz>
References: <3f4fd2640801220121w60cb9a69u8519a7ceb81d3414@mail.gmail.com>
	<alpine.LFD.1.00.0801220829080.2957@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Reece Dunn <msclrhd@googlemail.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Jan 22 21:22:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHPdJ-0002Db-NQ
	for gcvg-git-2@gmane.org; Tue, 22 Jan 2008 21:22:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752699AbYAVUVY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jan 2008 15:21:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752507AbYAVUVY
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jan 2008 15:21:24 -0500
Received: from mail-in-17.arcor-online.net ([151.189.21.57]:43027 "EHLO
	mail-in-17.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752517AbYAVUVX (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Jan 2008 15:21:23 -0500
Received: from mail-in-05-z2.arcor-online.net (mail-in-05-z2.arcor-online.net [151.189.8.17])
	by mail-in-17.arcor-online.net (Postfix) with ESMTP id 0BFBB2BB711;
	Tue, 22 Jan 2008 21:21:22 +0100 (CET)
Received: from mail-in-08.arcor-online.net (mail-in-08.arcor-online.net [151.189.21.48])
	by mail-in-05-z2.arcor-online.net (Postfix) with ESMTP id D76192DAE65;
	Tue, 22 Jan 2008 21:21:21 +0100 (CET)
Received: from lola.goethe.zz (dslb-084-061-036-024.pools.arcor-ip.net [84.61.36.24])
	by mail-in-08.arcor-online.net (Postfix) with ESMTP id A105F2BB702;
	Tue, 22 Jan 2008 21:21:06 +0100 (CET)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 9919B1C3D4E5; Tue, 22 Jan 2008 21:21:03 +0100 (CET)
In-Reply-To: <alpine.LFD.1.00.0801220829080.2957@woody.linux-foundation.org>
	(Linus Torvalds's message of "Tue, 22 Jan 2008 08:56:28 -0800 (PST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.92/5521/Tue Jan 22 15:55:56 2008 on mail-in-08.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71467>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Tue, 22 Jan 2008, Reece Dunn wrote:
>> 
>>   1.  File name representation
>> 
>> For Linux file systems (correct me if I am wrong here), they all store
>> the file name as-is. The question here is what happens on
>> Windows-based file systems (e.g. NTFS) that are being read on Linux?
>
> Generally, Linux tries to follow the conventions of the filesystem, so 
> it's generally case-preserving and case-sensitive (but not normalizing in 
> any way - the case sensitivity is literally a upcase lookup table, so you 
> do "upcase(c1) == upcase(c2)" for each UCS-2 character, no combining or 
> decomposition).

s/sensitiv/insensitiv/g

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
