From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Wishlist for branch management
Date: Mon, 01 Feb 2010 09:49:51 -0800
Message-ID: <4B67143F.6090903@zytor.com>
References: <4B662BEF.7040503@zytor.com> <20100201091907.GJ9553@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Mon Feb 01 18:50:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nc0Pb-0002ir-7i
	for gcvg-git-2@lo.gmane.org; Mon, 01 Feb 2010 18:50:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752602Ab0BARuE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Feb 2010 12:50:04 -0500
Received: from terminus.zytor.com ([198.137.202.10]:37630 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752127Ab0BARuB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Feb 2010 12:50:01 -0500
Received: from mail.hos.anvin.org (c-98-210-181-100.hsd1.ca.comcast.net [98.210.181.100])
	(authenticated bits=0)
	by mail.zytor.com (8.14.3/8.14.3) with ESMTP id o11Hnqn9031562
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 1 Feb 2010 09:49:52 -0800
Received: from tazenda.hos.anvin.org (tazenda.hos.anvin.org [172.27.0.16])
	by mail.hos.anvin.org (8.14.3/8.14.3) with ESMTP id o11HnqOD024101
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 1 Feb 2010 09:49:52 -0800
Received: from tazenda.hos.anvin.org (localhost.localdomain [127.0.0.1])
	by tazenda.hos.anvin.org (8.14.3/8.13.6) with ESMTP id o11Hnp5f007815;
	Mon, 1 Feb 2010 09:49:51 -0800
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.7) Gecko/20100120 Fedora/3.0.1-1.fc11 Thunderbird/3.0.1
In-Reply-To: <20100201091907.GJ9553@machine.or.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138632>

On 02/01/2010 01:19 AM, Petr Baudis wrote:
> I'm used to git symbolic-ref HEAD. I like the fact that human-friendly
> and scripting interfaces are mostly separated to different commands.

It's makes the learning curve for scripting git unnecessarily large.
Furthermore, it's rather unrealistic for people who are not git people
to follow this dictum -- I have seen the git scripts that the kernel
people write, including myself, and they generally tend to use the same
commands they're used to using themselves.

So I think it's actually a really bad UI design.  It helps making clear
what is scriptable (stable) and what isn't, but expecting people to use
a different mental rubric when scripting than when working on the
command line is completely unrealistic.

	-hpa

-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.
