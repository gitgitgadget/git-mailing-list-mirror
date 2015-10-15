From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 1/3] strbuf: make stripspace() part of strbuf
Date: Thu, 15 Oct 2015 18:43:44 +0200
Message-ID: <vpqeggw13r3.fsf@grenoble-inp.fr>
References: <1444911524-14504-1-git-send-email-tklauser@distanz.ch>
	<1444911524-14504-2-git-send-email-tklauser@distanz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Tobias Klauser <tklauser@distanz.ch>
X-From: git-owner@vger.kernel.org Thu Oct 15 18:44:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZmldE-0003Kj-S6
	for gcvg-git-2@plane.gmane.org; Thu, 15 Oct 2015 18:43:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752717AbbJOQnw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Oct 2015 12:43:52 -0400
Received: from mx1.imag.fr ([129.88.30.5]:38170 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751374AbbJOQnw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Oct 2015 12:43:52 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t9FGhhTJ014030
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Thu, 15 Oct 2015 18:43:43 +0200
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t9FGhir2023259;
	Thu, 15 Oct 2015 18:43:44 +0200
In-Reply-To: <1444911524-14504-2-git-send-email-tklauser@distanz.ch> (Tobias
	Klauser's message of "Thu, 15 Oct 2015 14:18:42 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 15 Oct 2015 18:43:43 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t9FGhhTJ014030
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1445532224.06907@k+NR4uuujEi5eu1IJzJNMw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279672>

Tobias Klauser <tklauser@distanz.ch> writes:

> [1] https://git.wiki.kernel.org/index.php/SmallProjectsIdeas#make_.27stripspace.28.29.27_part_of_strbuf

I don't think we want such references in the commit message. It does
make sense in a "below ---" comment, but commit messages are here to
stay forever, while the SmallProjectsIdeas entries are meant to be
deleted when they are completed.

(Same in other patches)

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
