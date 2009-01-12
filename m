From: Cesar Eduardo Barros <cesarb@cesarb.net>
Subject: Re: [PATCH] Teach format-patch to handle output directory relative
 to cwd
Date: Mon, 12 Jan 2009 21:12:21 -0200
Message-ID: <496BCE55.8030407@cesarb.net>
References: <496BBE70.9060405@cesarb.net> <7vab9wgmwe.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 13 00:13:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMVyg-0005jC-L0
	for gcvg-git-2@gmane.org; Tue, 13 Jan 2009 00:13:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755496AbZALXM0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jan 2009 18:12:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752255AbZALXM0
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jan 2009 18:12:26 -0500
Received: from smtp-03.mandic.com.br ([200.225.81.143]:57441 "EHLO
	smtp-03.mandic.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752382AbZALXMZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jan 2009 18:12:25 -0500
Received: (qmail 28569 invoked from network); 12 Jan 2009 23:12:22 -0000
Received: from grumari.nitnet.com.br (HELO [192.168.96.4]) (zcncxNmDysja2tXBpdiToZWJlF6Wp6IuYnI=@[200.157.204.13])
          (envelope-sender <cesarb@cesarb.net>)
          by smtp-03.mandic.com.br (qmail-ldap-1.03) with AES256-SHA encrypted SMTP
          for <gitster@pobox.com>; 12 Jan 2009 23:12:22 -0000
User-Agent: Thunderbird 2.0.0.19 (X11/20090105)
In-Reply-To: <7vab9wgmwe.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105413>

Junio C Hamano escreveu:
> Without any explicit -o parameter, we correctly avoided putting the
> resulting patch output to the toplevel.  We should do the same when
> the user gave a relative pathname to be consistent with this case and also
> with how other commands handle relative pathnames.

Works great, only the resulting output to the screen is a bit 
ugly/confusing:

drivers/net/../../../0001-sc92031-more-useful-banner-in-kernel-log.patch
drivers/net/../../../0002-sc92031-remove-meaningless-version-string.patch
drivers/net/../../../0003-sc92031-inline-SC92031_DESCRIPTION.patch
drivers/net/../../../0004-sc92031-use-device-id-directly-instead-of-made-up-n.patch
drivers/net/../../../0005-sc92031-add-a-link-to-the-datasheet.patch

I would expect:

../../../0001-sc92031-more-useful-banner-in-kernel-log.patch
../../../0002-sc92031-remove-meaningless-version-string.patch
../../../0003-sc92031-inline-SC92031_DESCRIPTION.patch
../../../0004-sc92031-use-device-id-directly-instead-of-made-up-n.patch
../../../0005-sc92031-add-a-link-to-the-datasheet.patch

(after all, I am still inside the drivers/net directory)

-- 
Cesar Eduardo Barros
cesarb@cesarb.net
cesar.barros@gmail.com
