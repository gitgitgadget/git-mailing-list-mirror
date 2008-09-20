From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 01/14] Extend index to save more flags
Date: Sat, 20 Sep 2008 15:23:42 -0700
Message-ID: <7vvdwq1moh.fsf@gitster.siamese.dyndns.org>
References: <1221904913-25887-1-git-send-email-pclouds@gmail.com>
 <1221904913-25887-2-git-send-email-pclouds@gmail.com>
 <m3skrulbrd.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 21 00:25:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KhAsx-0004Xv-A5
	for gcvg-git-2@gmane.org; Sun, 21 Sep 2008 00:25:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751665AbYITWXy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Sep 2008 18:23:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751808AbYITWXy
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Sep 2008 18:23:54 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:47524 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751658AbYITWXx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Sep 2008 18:23:53 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 352B465BDB;
	Sat, 20 Sep 2008 18:23:51 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id CFB7C65BD8; Sat, 20 Sep 2008 18:23:44 -0400 (EDT)
In-Reply-To: <m3skrulbrd.fsf@localhost.localdomain> (Jakub Narebski's message
 of "Sat, 20 Sep 2008 14:59:20 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: CD4F4CDC-8762-11DD-B4B5-D0CFFE4BC1C1-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96372>

Jakub Narebski <jnareb@gmail.com> writes:

> By the way: what was index version 1?

It was the format used before ccc4feb (Convert the index file
reading/writing to use network byte order., 2005-04-15)
