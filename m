From: Max Kirillov <max@max630.net>
Subject: Re: [PATCH 1/4] Add test for showing discarded changes with diff --cc
Date: Fri, 3 Apr 2015 19:03:33 +0300
Message-ID: <20150403160333.GD8771@wheezy.local>
References: <1428006853-21212-1-git-send-email-max@max630.net>
 <1428006853-21212-2-git-send-email-max@max630.net>
 <xmqqy4mai71d.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 03 18:03:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ye449-00027k-0T
	for gcvg-git-2@plane.gmane.org; Fri, 03 Apr 2015 18:03:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750996AbbDCQDY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Apr 2015 12:03:24 -0400
Received: from p3plsmtpa11-07.prod.phx3.secureserver.net ([68.178.252.108]:57977
	"EHLO p3plsmtpa11-07.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750711AbbDCQDY (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Apr 2015 12:03:24 -0400
Received: from wheezy.local ([82.181.81.240])
	by p3plsmtpa11-07.prod.phx3.secureserver.net with 
	id BU3K1q00B5B68XE01U3NBx; Fri, 03 Apr 2015 09:03:23 -0700
Content-Disposition: inline
In-Reply-To: <xmqqy4mai71d.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266713>

On Thu, Apr 02, 2015 at 01:55:58PM -0700, Junio C Hamano wrote:
> So I'll give a preliminary nitpicks first ;-)

Thank you; fixed the issues you mentioned.

>> + test_seq 11 | sed -e "s/^7/7change1/" -e "s/^11/11change2/" -e
>> "s/^2/2change2/" >long/only2 &&
>> +	git add long/only2 &&
> 
> Patch is line-wrapped around here?

I hope it was you email program which wrapped it (maybe at
quoting). It looks ok in my mutt and in source, and I uses
same git format-patch+git send-email as usual.

-- 
Max
