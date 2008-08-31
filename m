From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: [PATCH] change Perl syntax to support Perl 5.6
Date: Sun, 31 Aug 2008 06:35:42 -0700
Message-ID: <86abetnw7l.fsf@blue.stonehenge.com>
References: <20080830173947.GF7185@schiele.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Robert Schiele <rschiele@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 31 16:04:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZnXw-0001w3-Na
	for gcvg-git-2@gmane.org; Sun, 31 Aug 2008 16:04:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756912AbYHaODq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Aug 2008 10:03:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756948AbYHaODp
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Aug 2008 10:03:45 -0400
Received: from blue.stonehenge.com ([209.223.236.162]:25611 "EHLO
	blue.stonehenge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756912AbYHaODn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Aug 2008 10:03:43 -0400
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id A1D2E1DE4FC; Sun, 31 Aug 2008 06:35:42 -0700 (PDT)
x-mayan-date: Long count = 12.19.15.11.7; tzolkin = 4 Manik; haab = 10 Mol
In-Reply-To: <20080830173947.GF7185@schiele.dyndns.org> (Robert Schiele's message of "Sat, 30 Aug 2008 19:39:47 +0200")
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (berkeley-unix)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94485>

>>>>> "Robert" == Robert Schiele <rschiele@gmail.com> writes:
Robert> -		open($fh, '-|', @_) or die;
Robert> +		open($fh, '-|', join(' ', @_)) or die;

No.  This is dangerous.

If you want 5.6 equivalent code, you'll have to use something
that deals with the explicit fork() of open($fh, '-|').

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Smalltalk/Perl/Unix consulting, Technical writing, Comedy, etc. etc.
See http://methodsandmessages.vox.com/ for Smalltalk and Seaside discussion
