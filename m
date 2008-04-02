From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Describe the bug about handling non-Ascii filenames in
 'git add -i'
Date: Wed, 02 Apr 2008 10:18:58 -0700
Message-ID: <7vy77w89a5.fsf@gitster.siamese.dyndns.org>
References: <200804012232.03559.tlikonen@iki.fi>
 <m3y77xtk32.fsf@localhost.localdomain>
 <7v63v1ccmb.fsf@gitster.siamese.dyndns.org>
 <20080402170646.GA12711@mithlond.arda.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Teemu Likonen <tlikonen@iki.fi>
X-From: git-owner@vger.kernel.org Wed Apr 02 19:20:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jh6cy-0001No-Bn
	for gcvg-git-2@gmane.org; Wed, 02 Apr 2008 19:20:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755948AbYDBRTQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Apr 2008 13:19:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755023AbYDBRTQ
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Apr 2008 13:19:16 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:38785 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754734AbYDBRTP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Apr 2008 13:19:15 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 1E4535D68;
	Wed,  2 Apr 2008 13:19:11 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 2230C5D66; Wed,  2 Apr 2008 13:19:05 -0400 (EDT)
In-Reply-To: <20080402170646.GA12711@mithlond.arda.local> (Teemu Likonen's
 message of "Wed, 2 Apr 2008 20:06:46 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78700>

This is not limited to non-ascii.  You would also need to warn about HT,
LF and double-quotes in the filenames.

I'd call this a limitation, though.
