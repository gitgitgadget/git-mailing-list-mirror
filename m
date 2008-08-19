From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation: setup-git-server-over-http: Mention
 davfs2
Date: Tue, 19 Aug 2008 00:48:21 -0700
Message-ID: <7vtzdhfnsq.fsf@gitster.siamese.dyndns.org>
References: <48A9E8BE.9040807@gmail.com>
 <1219095967-15971-1-git-send-email-gafunchal@gmail.com>
 <7vwsidh7hi.fsf@gitster.siamese.dyndns.org>
 <c475e2e60808190023r2984cea3r11bd27fd331234b4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johannes.Schindelin@gmx.de,
	git@wingding.demon.nl, Matthieu.Moy@imag.fr
To: "Giovanni Funchal" <gafunchal@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 19 09:49:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVLyB-0006jj-4e
	for gcvg-git-2@gmane.org; Tue, 19 Aug 2008 09:49:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752838AbYHSHsc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2008 03:48:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752062AbYHSHsc
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Aug 2008 03:48:32 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:34146 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752697AbYHSHsb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2008 03:48:31 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id A9E315A052;
	Tue, 19 Aug 2008 03:48:29 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id DB8F75A051; Tue, 19 Aug 2008 03:48:23 -0400 (EDT)
In-Reply-To: <c475e2e60808190023r2984cea3r11bd27fd331234b4@mail.gmail.com>
 (Giovanni Funchal's message of "Tue, 19 Aug 2008 09:23:39 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 36D2F49C-6DC3-11DD-83C9-B29498D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92825>

"Giovanni Funchal" <gafunchal@gmail.com> writes:

>> In addition, testing with davfs2 requires you to have root access.
>
> When davfs2 is properly configured, the file system can be mounted in
> user space by non-root users. Root access is needed only when
> installing.

Ok, then I misread your description.  This part should be clarified:

>>> +An alternative is to use davfs2, a driver that allows mounting a WebDAV
>>> +resource into the system tree. This requires root access and kernel

s/This/Installing this module/;

>>> +support (probably your kernel includes this).
>>> +
>>> +  $ apt-get install davfs2

s/\$ /# /;

>>> +  $ mkdir -p /mnt/webdav

ditto.

>>> +  $ mount -t davfs http://<servername>/ /mnt/webdav
>>> +  $ ls /mnt/webdav
>>> +  $ umount /mnt/webdav
