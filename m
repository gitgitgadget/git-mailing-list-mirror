From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH v4 1/2] usage: Introduce error_errno corresponding to die_errno
Date: Sun, 8 May 2011 15:16:10 +0530
Message-ID: <20110508094608.GB18463@ramkum.desktop.amazon.com>
References: <7vr58b22ny.fsf@alter.siamese.dyndns.org> <1304839851-6477-1-git-send-email-artagnon@gmail.com> <1304839851-6477-2-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 08 11:46:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJ0ZG-0007al-TJ
	for gcvg-git-2@lo.gmane.org; Sun, 08 May 2011 11:46:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752157Ab1EHJqO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 May 2011 05:46:14 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:53555 "EHLO
	smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752037Ab1EHJqN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2011 05:46:13 -0400
X-IronPort-AV: E=Sophos;i="4.64,334,1301875200"; 
   d="scan'208";a="430286505"
Received: from smtp-in-5102.iad5.amazon.com ([10.218.9.29])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 08 May 2011 09:46:12 +0000
Received: from ramkum.desktop.amazon.com (ramkum.desktop.amazon.com [172.25.205.64])
	by smtp-in-5102.iad5.amazon.com (8.13.8/8.13.8) with ESMTP id p489kAk5023304;
	Sun, 8 May 2011 09:46:11 GMT
Received: by ramkum.desktop.amazon.com (Postfix, from userid 272482)
	id 6BBD4754817; Sun,  8 May 2011 15:16:10 +0530 (IST)
Content-Disposition: inline
In-Reply-To: <1304839851-6477-2-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.4.2.2i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173085>

Hi,

Ramkumar Ramachandra writes:
> The error function always returns the constant value -1, and this does
> not convey enough information about the nature of the error.  This
> patch introduces a new function error_errno that functions exactly
> like the error function, except that it returns `errorno` instead of a
> constant value.

An extra note: this could have been implemented differently, as seen
in my sequencer series [1].  However, after some thought, I think this
is how we want error handling to work.  The name may be a little
troubling because it doesn't behave like die_errno: does anyone have
suggestions for a different name?

[1]: http://article.gmane.org/gmane.comp.version-control.git/171262

-- Ram
