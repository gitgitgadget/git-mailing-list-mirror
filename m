From: Pete Harlan <pgit@pcharlan.com>
Subject: Re: [1.8.0] Tracking empty directories
Date: Fri, 04 Feb 2011 23:43:48 -0800
Message-ID: <4D4CFFB4.2040508@pcharlan.com>
References: <7vzkqh8vqw.fsf@alter.siamese.dyndns.org> <7vwrll57ha.fsf@alter.siamese.dyndns.org> <m3zkqe8xc8.fsf_-_@localhost.localdomain> <AANLkTi=bK7mFS3eWVMWXqZSnv73tafL9AGazk4jPLddp@mail.gmail.com> <4928FF12-E593-4CDB-AC68-B4078CC5920E@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 05 08:44:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Plcop-0003kF-VD
	for gcvg-git-2@lo.gmane.org; Sat, 05 Feb 2011 08:44:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750974Ab1BEHoT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Feb 2011 02:44:19 -0500
Received: from hapkido.dreamhost.com ([66.33.216.122]:58707 "EHLO
	hapkido.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750914Ab1BEHoS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Feb 2011 02:44:18 -0500
Received: from homiemail-a42.g.dreamhost.com (caibbdcaaaaf.dreamhost.com [208.113.200.5])
	by hapkido.dreamhost.com (Postfix) with ESMTP id 0238017A5AF
	for <git@vger.kernel.org>; Fri,  4 Feb 2011 23:44:18 -0800 (PST)
Received: from homiemail-a42.g.dreamhost.com (localhost [127.0.0.1])
	by homiemail-a42.g.dreamhost.com (Postfix) with ESMTP id 4F8EF68C05D;
	Fri,  4 Feb 2011 23:43:49 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pcharlan.com; h=message-id:date
	:from:mime-version:to:cc:subject:references:in-reply-to
	:content-type:content-transfer-encoding; q=dns; s=pcharlan.com;
	 b=BLOUuQyBQECyLXZgfmXIxsBogLej3jVTdHOuxyre+fp9fbCY67jEup8/4U96l
	IfbEpVO8qpJI+dhMi+GWTDeJXu8MQ1HZsWkiqS8gVqKDD3aQhbH9/AYNqGCtl/OV
	8Sw9AzDNDDSGxXLBBC6azbp4quGZrNQ4jkK21aLnpeR2+8=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pcharlan.com; h=message-id
	:date:from:mime-version:to:cc:subject:references:in-reply-to
	:content-type:content-transfer-encoding; s=pcharlan.com; bh=SLQc
	CvwKqYL/Zx0KLjybRY29lbU=; b=kdWG4UK7wVO2FJE5PLdeNAtBmZF3SZJt6fYf
	JvhJTvbE06MFAXhFJlXWKmbPGwIzz+ldkCxtjEBHPoI50LUNFtnhqpUJKCCXUgRB
	KSPyQvreop8SG7daOHts3LpiXw5R79G1JziPZ7RKWveB0qpbepsHs6RMTSZo81up
	SVjzLDc=
Received: from [192.168.0.101] (185.132-78-65.ftth.swbr.surewest.net [65.78.132.185])
	(Authenticated sender: pete@tento.net)
	by homiemail-a42.g.dreamhost.com (Postfix) with ESMTPA id 2C8E968C05B;
	Fri,  4 Feb 2011 23:43:49 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.13) Gecko/20101208 Thunderbird/3.1.7
In-Reply-To: <4928FF12-E593-4CDB-AC68-B4078CC5920E@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166078>

On 02/02/2011 03:33 PM, David Aguilar wrote:
> I don't like where this is going. Users are not always right. Touch
> .gitignore and be done with it.  This is a big change with
> negligible benefits.  I don't understand why this is needed.

I worked for a huge company that was converting a large project to
Git.  They had a wiki about the conversion.  There was a section
titled "Git Gotchas" that had one entry: Git Doesn't Track Empty
Directories.

This has come up as something to be worked around in each of the
conversions to Git I've been part of.

And unlike other things Git doesn't track, such as permissions or
modification times, I can't argue that Git's behavior here is superior
to what they were expecting.  I'd love to see this feature in Git if
only to make the issue go away.  And I don't think it's a slippery
slope, that once this is in then they'll be clamoring for resource
forks and ACLs.  Developers know some things aren't handled by SCMs,
they just don't think that includes directories.

--Pete
