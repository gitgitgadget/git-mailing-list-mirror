From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 03/11] git-cat-file: Make option parsing a little more
 flexible
Date: Fri, 25 Apr 2008 11:04:01 -0700
Message-ID: <7vod7xq0a6.fsf@gitster.siamese.dyndns.org>
References: <1208978273-98146-1-git-send-email-aroben@apple.com>
 <1208978273-98146-2-git-send-email-aroben@apple.com>
 <1208978273-98146-3-git-send-email-aroben@apple.com>
 <1208978273-98146-4-git-send-email-aroben@apple.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Adam Roben <aroben@apple.com>
X-From: git-owner@vger.kernel.org Fri Apr 25 20:05:57 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JpSJ0-0003pC-Gs
	for gcvg-git-2@gmane.org; Fri, 25 Apr 2008 20:05:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765665AbYDYSEK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Apr 2008 14:04:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765659AbYDYSEJ
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Apr 2008 14:04:09 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:61370 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765654AbYDYSEH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Apr 2008 14:04:07 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 538EB1703;
	Fri, 25 Apr 2008 14:04:06 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id CCFFC1700; Fri, 25 Apr 2008 14:04:03 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80341>

Adam Roben <aroben@apple.com> writes:

> This will make it easier to add newer options later.

Hmm.  Makes one wonder "why not parse-options"?...
