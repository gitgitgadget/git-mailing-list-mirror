From: Max Kirillov <max@max630.net>
Subject: Re: [PATCH 2/2] blame: allow blame --reverse --first-parent when it
 makes sense
Date: Thu, 22 Oct 2015 06:52:00 +0300
Message-ID: <20151022035200.GB5722@wheezy.local>
References: <1445400482-1977-1-git-send-email-max@max630.net>
 <1445400482-1977-3-git-send-email-max@max630.net>
 <CAPig+cQ_cYQ0i8PtidiLJjBr2UqwkPBW5Kv20VeN7AsmeWBsPg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Max Kirillov <max@max630.net>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Thu Oct 22 05:52:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zp6vC-0007V6-5G
	for gcvg-git-2@plane.gmane.org; Thu, 22 Oct 2015 05:52:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756616AbbJVDwG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Oct 2015 23:52:06 -0400
Received: from p3plsmtpa08-10.prod.phx3.secureserver.net ([173.201.193.111]:45062
	"EHLO p3plsmtpa08-10.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751618AbbJVDwF (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Oct 2015 23:52:05 -0400
Received: from wheezy.local ([82.181.81.240])
	by p3plsmtpa08-10.prod.phx3.secureserver.net with 
	id Y3rz1r0065B68XE013s2Mo; Wed, 21 Oct 2015 20:52:04 -0700
Content-Disposition: inline
In-Reply-To: <CAPig+cQ_cYQ0i8PtidiLJjBr2UqwkPBW5Kv20VeN7AsmeWBsPg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280033>

On Wed, Oct 21, 2015 at 12:29:12AM -0400, Eric Sunshine wrote:
> On Wed, Oct 21, 2015 at 12:08 AM, Max Kirillov <max@max630.net> wrote:
>> Do not die immediately when the two flags are specified. Instead
>> check that the specified range is along first-parent chain.  Explioit
> 
> s/Explioit/Exploit/

Fixed. Thanks.

-- 
Max
