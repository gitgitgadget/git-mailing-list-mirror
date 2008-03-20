From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Invalid refspec?
Date: Thu, 20 Mar 2008 09:46:01 -0700
Message-ID: <7vy78dwdh2.fsf@gitster.siamese.dyndns.org>
References: <2008-03-20-11-53-31+trackit+sam@rfc1149.net>
 <alpine.LNX.1.00.0803200914420.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Samuel Tardieu <sam@rfc1149.net>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Thu Mar 20 17:47:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JcNuj-0001Pc-TT
	for gcvg-git-2@gmane.org; Thu, 20 Mar 2008 17:46:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754515AbYCTQqL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Mar 2008 12:46:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754501AbYCTQqK
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Mar 2008 12:46:10 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:39768 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754456AbYCTQqJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Mar 2008 12:46:09 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 86F2220ED;
	Thu, 20 Mar 2008 12:46:08 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id EE85620E8; Thu, 20 Mar 2008 12:46:04 -0400 (EDT)
In-Reply-To: <alpine.LNX.1.00.0803200914420.19665@iabervon.org> (Daniel
 Barkalow's message of "Thu, 20 Mar 2008 09:21:18 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77670>

Daniel Barkalow <barkalow@iabervon.org> writes:

> We need a test for the src being an object name around line 443 in 
> remote.c; I'll have something this evening if nobody beats me to it.

Careful.  That is ONLY valid for pushes.  For fetches, you are allowed to
name existing refs and nothing else.
