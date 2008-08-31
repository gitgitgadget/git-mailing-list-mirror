From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: [PATCH] change Perl syntax to support Perl 5.6
Date: Sun, 31 Aug 2008 06:37:52 -0700
Message-ID: <8663phnw3z.fsf@blue.stonehenge.com>
References: <20080830173947.GF7185@schiele.dyndns.org>
	<20080830183413.GG7185@schiele.dyndns.org>
	<20080830183949.GA16415@coredump.intra.peff.net>
	<200808302237.17017.jnareb@gmail.com>
	<32541b130808302235g6a23efcfs78efe2ef557cd9c7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Jakub Narebski" <jnareb@gmail.com>, "Jeff King" <peff@peff.net>,
	"Robert Schiele" <rschiele@gmail.com>,
	"Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org,
	"Lea Wiemann" <lewiemann@gmail.com>
To: "Avery Pennarun" <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 31 16:05:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZnXv-0001w3-Vb
	for gcvg-git-2@gmane.org; Sun, 31 Aug 2008 16:04:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756994AbYHaODo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Aug 2008 10:03:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756471AbYHaODo
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Aug 2008 10:03:44 -0400
Received: from blue.stonehenge.com ([209.223.236.162]:30702 "EHLO
	blue.stonehenge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756717AbYHaODn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Aug 2008 10:03:43 -0400
X-Greylist: delayed 1680 seconds by postgrey-1.27 at vger.kernel.org; Sun, 31 Aug 2008 10:03:43 EDT
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id 8B5761DE508; Sun, 31 Aug 2008 06:37:53 -0700 (PDT)
x-mayan-date: Long count = 12.19.15.11.7; tzolkin = 4 Manik; haab = 10 Mol
In-Reply-To: <32541b130808302235g6a23efcfs78efe2ef557cd9c7@mail.gmail.com> (Avery Pennarun's message of "Sun, 31 Aug 2008 01:35:31 -0400")
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (berkeley-unix)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94484>

>>>>> "Avery" == Avery Pennarun <apenwarr@gmail.com> writes:

Avery> Shell quoting is a disaster (including security holes, where relevant)
Avery> waiting to happen.  The above is the only sane way to do it, and it
Avery> isn't very hard to implement.  (Instead of system() in the subprocess,
Avery> you can use exec().)

quotemeta() is about regex quoting.  This is not precisely the same as shell
quoting, and is both misleading, and potentially broken.

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Smalltalk/Perl/Unix consulting, Technical writing, Comedy, etc. etc.
See http://methodsandmessages.vox.com/ for Smalltalk and Seaside discussion
