From: Andrew Pimlott <andrew@pimlott.net>
Subject: Re: [PATCH] lib-rebase: use write_script
Date: Thu, 27 Jun 2013 12:02:45 -0700
Message-ID: <1372359086-sup-9704@pimlott.net>
References: <1372357825-21824-1-git-send-email-andrew@pimlott.net> <7va9mbs8lw.fsf@alter.siamese.dyndns.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 27 21:02:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UsHT5-00061p-DK
	for gcvg-git-2@plane.gmane.org; Thu, 27 Jun 2013 21:02:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752627Ab3F0TCu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Jun 2013 15:02:50 -0400
Received: from pimlott.net ([72.249.23.100]:60738 "EHLO fugue.pimlott.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752093Ab3F0TCu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Jun 2013 15:02:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=pimlott.net; s=default;
	h=Content-Transfer-Encoding:Message-Id:Date:References:In-reply-to:To:From:Subject:Cc:Content-Type; bh=1UTsOHZI2yCIXg+wHDMk9seUMYvaGQzIHkUZG3qWzpU=;
	b=lBnGfsonir/FXr1Do49TEuDnOZ+wmKzXwi8dKQ/ehQslbhkjKLO+DHHTx3THhN1f2K2Ob9eEpAckxOPmC1Cc6q20DG4q4UKZ2YEeIxPNgA8TWfO5FhSavl1tfSls6nKjmqifkpHnVfxboljWJSWJNVwsyJ1mgbJj2CdqLBMVtSc=;
Received: from andrew by fugue.pimlott.net with local (Exim 4.72)
	(envelope-from <andrew@pimlott.net>)
	id 1UsHSw-0006qc-1G; Thu, 27 Jun 2013 12:02:46 -0700
In-reply-to: <7va9mbs8lw.fsf@alter.siamese.dyndns.org>
User-Agent: Sup/git
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229146>

Excerpts from Junio C Hamano's message of Thu Jun 27 11:37:31 -0700 2013:
> Thanks, but it should probably be
> 
>     write_script fake-editor.sh <<-\EOF
>         case "$1" in
>         ...
>         EOF
> 
>         test_set_editor ...
> 
> if the aim is to modernize this part.

Yes, the goal is to make that file consistently use the current
practice.  (My syntax highlighting doesn't like it, but...)  I should
update the function I introduced first.  I will re-submit the rebase -i
--autosquash  patch and wait for acceptance before trying to fix other
things.

Andrew
