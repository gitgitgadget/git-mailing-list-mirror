From: Matt Kraai <kraai@ftbfs.org>
Subject: Re: What's cooking in git.git (Dec 2012, #04; Sun, 16)
Date: Mon, 17 Dec 2012 13:37:30 -0800
Message-ID: <20121217213730.GA17212@ftbfs.org>
Reply-To: 7v8v8xnnx0.fsf@alter.siamese.dyndns.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 17 22:37:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TkiNn-0001FY-Ql
	for gcvg-git-2@plane.gmane.org; Mon, 17 Dec 2012 22:37:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752293Ab2LQVhi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2012 16:37:38 -0500
Received: from kvm.ftbfs.org ([46.22.115.26]:58799 "EHLO kvm.ftbfs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751777Ab2LQVhh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2012 16:37:37 -0500
Received: from kraai by kvm.ftbfs.org with local (Exim 4.72)
	(envelope-from <kraai@ftbfs.org>)
	id 1TkiNO-0004U1-2N; Mon, 17 Dec 2012 13:37:30 -0800
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211705>

Junio C Hamano wrote:
> It could turn out that we may be able to get rid of sys/param.h
> altogether, but one step at a time.  Inputs from people on minority
> platforms are very much appreciated---does your platform build fine
> when the inclusion of the file is removed from git-compat-util.h?

QNX builds fine when sys/param.h is not included.

-- 
Matt Kraai
https://ftbfs.org/kraai
