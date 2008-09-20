From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 01/14] Extend index to save more flags
Date: Sat, 20 Sep 2008 15:26:27 -0700
Message-ID: <7vr67e1mjw.fsf@gitster.siamese.dyndns.org>
References: <1221904913-25887-1-git-send-email-pclouds@gmail.com>
 <1221904913-25887-2-git-send-email-pclouds@gmail.com>
 <m3skrulbrd.fsf@localhost.localdomain>
 <7vvdwq1moh.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 21 00:27:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KhAvX-0005GS-M5
	for gcvg-git-2@gmane.org; Sun, 21 Sep 2008 00:27:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751579AbYITW0f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Sep 2008 18:26:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751510AbYITW0f
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Sep 2008 18:26:35 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:48180 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751470AbYITW0f (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Sep 2008 18:26:35 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id CBAE965C3B;
	Sat, 20 Sep 2008 18:26:33 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id EC45A65C29; Sat, 20 Sep 2008 18:26:29 -0400 (EDT)
In-Reply-To: <7vvdwq1moh.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sat, 20 Sep 2008 15:23:42 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 2E3CA260-8763-11DD-9C30-D0CFFE4BC1C1-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96373>

Junio C Hamano <gitster@pobox.com> writes:

> Jakub Narebski <jnareb@gmail.com> writes:
>
>> By the way: what was index version 1?
>
> It was the format used before ccc4feb (Convert the index file
> reading/writing to use network byte order., 2005-04-15)

Sorry, I dug that wrong.  The right one is:

ca9be05 (Make the sha1 of the index file go at the very end of the file., 2005-04-20)
