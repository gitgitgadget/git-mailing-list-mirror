From: Dragos Foianu <dragos.foianu@gmail.com>
Subject: Re: [PATCH] diff: optimise =?utf-8?b?cGFyc2VfZGlyc3RhdF9wYXJhbXMoKQ==?= to only compare strings when necessary
Date: Thu, 20 Mar 2014 00:15:26 +0000 (UTC)
Message-ID: <loom.20140320T011443-681@post.gmane.org>
References: <1395274076-6720-1-git-send-email-dragos.foianu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 20 01:16:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQQeQ-0006VX-HH
	for gcvg-git-2@plane.gmane.org; Thu, 20 Mar 2014 01:16:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759553AbaCTAP5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2014 20:15:57 -0400
Received: from plane.gmane.org ([80.91.229.3]:37235 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756174AbaCTAP4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2014 20:15:56 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1WQQeF-0006Et-WD
	for git@vger.kernel.org; Thu, 20 Mar 2014 01:15:52 +0100
Received: from 109.100.93.176 ([109.100.93.176])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 20 Mar 2014 01:15:51 +0100
Received: from dragos.foianu by 109.100.93.176 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 20 Mar 2014 01:15:51 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 109.100.93.176 (Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Firefox/24.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244510>

I will send another version of this patch after review because there is an
extra whitespace following the else statement.
