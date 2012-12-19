From: Matt Kraai <kraai@ftbfs.org>
Subject: Re: [PATCH] Remove duplicate entry in ./Documentation/Makefile
Date: Wed, 19 Dec 2012 10:49:57 -0800
Message-ID: <20121219184957.GA28215@ftbfs.org>
Reply-To: 7vd2y5aom8.fsf@alter.siamese.dyndns.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Thomas Ackermann <th.acker@arcor.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 19 19:50:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TlOim-0004rf-92
	for gcvg-git-2@plane.gmane.org; Wed, 19 Dec 2012 19:50:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752080Ab2LSSuG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Dec 2012 13:50:06 -0500
Received: from kvm.ftbfs.org ([46.22.115.26]:59719 "EHLO kvm.ftbfs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751214Ab2LSSuF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Dec 2012 13:50:05 -0500
Received: from kraai by kvm.ftbfs.org with local (Exim 4.72)
	(envelope-from <kraai@ftbfs.org>)
	id 1TlOiL-0007Pb-Vv; Wed, 19 Dec 2012 10:49:57 -0800
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Thomas Ackermann <th.acker@arcor.de>
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211841>

Hi,

Junio C Hamano wrote:
> If not by eyeballing but with some mechanical process, did you spot
> any others?

I found one other unnecessarily duplicated line in the top-level
Makefile:

 LIB_H += xdiff/xdiff.h

by running

 find -name Makefile | xargs grep += | sort | uniq -d

and inspecting the results by hand, but this only checked lines
containing "+=".

-- 
Matt Kraai
https://ftbfs.org/kraai
