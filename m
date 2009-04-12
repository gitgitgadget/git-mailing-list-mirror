From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] http-push.c: DAV must support olny http and https scheme
Date: Sun, 12 Apr 2009 11:45:01 -0700
Message-ID: <7vprfh7lua.fsf@gitster.siamese.dyndns.org>
References: <1239371060-3978-1-git-send-email-catap@catap.ru>
 <7vd4bi9s1m.fsf@gitster.siamese.dyndns.org>
 <20090412090053.GA9920@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Kirill A. Korinskiy" <catap@catap.ru>, git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Sun Apr 12 20:47:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lt4hq-0000X2-AO
	for gcvg-git-2@gmane.org; Sun, 12 Apr 2009 20:47:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751336AbZDLSpM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Apr 2009 14:45:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751206AbZDLSpL
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Apr 2009 14:45:11 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:44534 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750855AbZDLSpJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Apr 2009 14:45:09 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 46886AA563;
	Sun, 12 Apr 2009 14:45:08 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 02BDBAA560; Sun,
 12 Apr 2009 14:45:03 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 0BB191C2-2792-11DE-9BE4-C121C5FC92D5-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116385>

Mike Hommey <mh@glandium.org> writes:

>> http-push.c: In function 'handle_remote_ls_ctx':
>> http-push.c:1466: error: 'remote' undeclared (first use in this function)
>> http-push.c:1466: error: (Each undeclared identifier is reported only once
>> http-push.c:1466: error: for each function it appears in.)
>> 
>> Ah, crap.
>
> s/remote/repo/. He must have done his patch before 7b5201a and rebased
> afterwards without checking.

Oh, I know that.

The "crap" was about "sent without checking" part.
