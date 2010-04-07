From: Marat Radchenko <marat@slonopotamus.org>
Subject: Re: git clone: very long &quot;resolving deltas&quot; phase
Date: Wed, 7 Apr 2010 09:22:37 +0000 (UTC)
Message-ID: <loom.20100407T112028-388@post.gmane.org>
References: <loom.20100406T161552-321@post.gmane.org> <vpqljd062xb.fsf@bauges.imag.fr> <4BBB5346.6070607@gmail.com> <4BBB53F5.9010106@op5.se> <alpine.LFD.2.00.1004061702340.7232@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 07 11:35:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NzRfH-0002Zr-4s
	for gcvg-git-2@lo.gmane.org; Wed, 07 Apr 2010 11:35:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757544Ab0DGJfI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Apr 2010 05:35:08 -0400
Received: from lo.gmane.org ([80.91.229.12]:56074 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752460Ab0DGJfG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Apr 2010 05:35:06 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1NzRf5-0002VB-Df
	for git@vger.kernel.org; Wed, 07 Apr 2010 11:35:03 +0200
Received: from 195.218.191.171 ([195.218.191.171])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 07 Apr 2010 11:35:03 +0200
Received: from marat by 195.218.191.171 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 07 Apr 2010 11:35:03 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 195.218.191.171 (Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/532.9 (KHTML, like Gecko) Chrome/5.0.307.7 Safari/532.9)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144208>

Nicolas Pitre <nico <at> fluxnic.net> writes:
> The "Resolving deltas" is performed locally, when Git is actually 
> expanding all the deltas in the received pack to find the actual SHA1 of 
> the resulting object in order to create the pack index.
Is there any technical limitation why it cannot be done simultaniously with
fetch (piped or whatever), instead of a separate step after fetch?
