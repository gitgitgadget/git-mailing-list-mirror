From: Miles Bader <miles@gnu.org>
Subject: Re: how do I create a branch and push it so several developers can share work?
Date: Thu, 09 Sep 2010 14:36:30 +0900
Message-ID: <buo8w3bsckh.fsf@dhlpc061.dev.necel.com>
References: <AANLkTinO9TVyg6EBS1ZuQPS+VWxzODmLan0sDGzFw8eh@mail.gmail.com>
	<20100908224041.GB8466@vfa-6z.perlninja.com>
	<AANLkTiknS8vwqWRVn49eaEEbmQ-iqBa6zpgq6Y=nB326@mail.gmail.com>
Reply-To: Miles Bader <miles@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jacob Helwig <jacob.helwig@gmail.com>,
	"git\@vger.kernel.org List" <git@vger.kernel.org>
To: Robert Buck <buck.robert.j@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 09 07:36:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OtZoS-0006MK-9c
	for gcvg-git-2@lo.gmane.org; Thu, 09 Sep 2010 07:36:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752270Ab0IIFgi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Sep 2010 01:36:38 -0400
Received: from TYO202.gate.nec.co.jp ([202.32.8.206]:34425 "EHLO
	tyo202.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751003Ab0IIFgh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Sep 2010 01:36:37 -0400
Received: from mailgate3.nec.co.jp ([10.7.69.195])
	by tyo202.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id o895aV08028995;
	Thu, 9 Sep 2010 14:36:31 +0900 (JST)
Received: (from root@localhost) by mailgate3.nec.co.jp (8.11.7/3.7W-MAILGATE-NEC)
	id o895aVY19484; Thu, 9 Sep 2010 14:36:31 +0900 (JST)
Received: from relay51.aps.necel.com ([10.29.19.60])
	by vgate01.nec.co.jp (8.14.4/8.14.4) with ESMTP id o895ZpPj010960;
	Thu, 9 Sep 2010 14:36:30 +0900 (JST)
Received: from relay51.aps.necel.com ([10.29.19.103] [10.29.19.103]) by relay51.aps.necel.com with ESMTP; Thu, 9 Sep 2010 14:36:30 +0900
Received: from dhlpc061 ([10.114.113.213] [10.114.113.213]) by relay51.aps.necel.com with ESMTP; Thu, 9 Sep 2010 14:36:30 +0900
Received: by dhlpc061 (Postfix, from userid 31295)
	id 84627124012; Thu,  9 Sep 2010 14:36:30 +0900 (JST)
System-Type: x86_64-unknown-linux-gnu
Blat: Foop
In-Reply-To: <AANLkTiknS8vwqWRVn49eaEEbmQ-iqBa6zpgq6Y=nB326@mail.gmail.com>
	(Robert Buck's message of "Wed, 8 Sep 2010 19:01:28 -0400")
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155840>

Robert Buck <buck.robert.j@gmail.com> writes:
> Related question, is there a way to have fullers show up automatically
> as a local branch for developers simply through a `git clone`?

Hm, can't you have them do "git clone --branch fullers REMOTE" ?

I thinnnnnk that does the right thing (does the clone, then makes a
local "fullers" branch that tracks the remote "fullers" branch).

AFAIK there's no way to get multiple new local branches though
(e.g. master _and_ fullers)...

-Miles

-- 
(\(\
(^.^)
(")")
*This is the cute bunny virus, please copy this into your sig so it can spread.
