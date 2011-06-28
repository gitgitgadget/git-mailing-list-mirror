From: Phil Hord <hordp@cisco.com>
Subject: Re: [GSoC 11 submodule] Status update
Date: Mon, 27 Jun 2011 20:29:18 -0400
Message-ID: <4E09205E.2080904@cisco.com>
References: <20110627193444.GA26778@paksenarrion.iveqy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, hvoigt@hvoigt.net, jens.lehmann@web.de
To: Fredrik Gustafsson <iveqy@iveqy.com>
X-From: git-owner@vger.kernel.org Tue Jun 28 02:32:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QbME6-0005D4-FS
	for gcvg-git-2@lo.gmane.org; Tue, 28 Jun 2011 02:32:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753982Ab1F1AbS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Jun 2011 20:31:18 -0400
Received: from sj-iport-2.cisco.com ([171.71.176.71]:32187 "EHLO
	sj-iport-2.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755592Ab1F1AaQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jun 2011 20:30:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=hordp@cisco.com; l=908; q=dns/txt;
  s=iport; t=1309221016; x=1310430616;
  h=message-id:date:from:mime-version:to:cc:subject:
   references:in-reply-to:content-transfer-encoding;
  bh=wRWnJGtI9IZX1KAAo74vKxxtpH9bOXqm595xzaIZP7Q=;
  b=RBdj0x3h8oBRsHgA2pp1VcTLUPmSXjDtU8peg99wdXhgvOhfQJAbIf7P
   gbpY+V3vlqjs49RaA91v+OD5I4FpdM6BLzarppfIihogqhaEGjfgh6iRZ
   S5bD2WgDeJr8tgym+m1cGw0z3uIeihjBa3FR+t4b1GxMwFk1GOXNpHaXL
   g=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Av0EAHwfCU6rRDoJ/2dsb2JhbABSpzh3qxieK4YwBJIDhG6LSQ
X-IronPort-AV: E=Sophos;i="4.65,435,1304294400"; 
   d="scan'208";a="387324946"
Received: from mtv-core-4.cisco.com ([171.68.58.9])
  by sj-iport-2.cisco.com with ESMTP; 28 Jun 2011 00:30:15 +0000
Received: from [10.117.80.100] (rtp-hordp-8913.cisco.com [10.117.80.100])
	by mtv-core-4.cisco.com (8.14.3/8.14.3) with ESMTP id p5S0UEil017446;
	Tue, 28 Jun 2011 00:30:15 GMT
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.17) Gecko/20110516 Lightning/1.0b2 Thunderbird/3.1.10
In-Reply-To: <20110627193444.GA26778@paksenarrion.iveqy.com>
X-Enigmail-Version: 1.1.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176377>

Hi Fredrik and git-submodule folks,

On 06/27/2011 03:34 PM, Fredrik Gustafsson wrote:
> My fourth task (and the main task of this summer) will start on June 27 and
> will be to move a submodules .git-dir into the super-projects .git-dir.
> Design of this is already done and approved by my mentors.

This frightens me a bit, so I read the wiki link about it.  Thanks for
explaining where I can find this information.

But I'm still confused.

If I understand right, the submodule/.git dirs will be moved into the
top-level at .git/submodule/.git.  The benefit is supposed to be that
this will free up contention on the non-empty submodule directory when
the super-project switches branches.

In the simple case, git warns "unable to rmdir sub: Directory not
empty".  But I can think of other conflicts as well.

My question is, how does this proposed change help the situation?

Phil
