From: "Tom G. Christensen" <tgc@jupiterrise.com>
Subject: Re: git segfaults on older Solaris releases
Date: Sat, 9 Apr 2016 22:17:56 +0200
Message-ID: <57096374.6030608@jupiterrise.com>
References: <5706A489.7070101@jupiterrise.com>
 <xmqqoa9lz2uw.fsf@gitster.mtv.corp.google.com>
 <xmqqk2k9z20p.fsf@gitster.mtv.corp.google.com>
 <5706C0D4.9030707@jupiterrise.com> <5708A90E.1050705@jupiterrise.com>
 <20160409173904.GA5127@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Apr 09 22:18:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aozKd-00032V-BX
	for gcvg-git-2@plane.gmane.org; Sat, 09 Apr 2016 22:18:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754664AbcDIUSG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Apr 2016 16:18:06 -0400
Received: from sub4.mail.dreamhost.com ([69.163.253.135]:43445 "EHLO
	homiemail-a111.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752641AbcDIUSE (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 9 Apr 2016 16:18:04 -0400
Received: from homiemail-a111.g.dreamhost.com (localhost [127.0.0.1])
	by homiemail-a111.g.dreamhost.com (Postfix) with ESMTP id 2922E2005D935;
	Sat,  9 Apr 2016 13:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jupiterrise.com; h=subject
	:to:references:cc:from:message-id:date:mime-version:in-reply-to
	:content-type:content-transfer-encoding; s=jupiterrise.com; bh=S
	NocFKaWqz9zp3VQxfPStfHUqro=; b=WZQhXiazhCRkm+lc3fk9Eg72G4gnBX3kq
	hFggvUdmNjyj6ivaOVSWSIlZGnEq8qFw/ABxH5kKKB533ox6GmeqxA9nu2mxGRY2
	/B5tko6GzFHN2CSeDHPoZaSYlwHAVdB0Y3RQEOxJyU2DLuG0wWJXm2BFrqCCRzS1
	3NLDHXB50U=
Received: from localhost6.localdomain6 (2-106-159-182-static.dk.customer.tdc.net [2.106.159.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: tgc99@jupiterrise.com)
	by homiemail-a111.g.dreamhost.com (Postfix) with ESMTPSA id B59842005D901;
	Sat,  9 Apr 2016 13:18:02 -0700 (PDT)
Received: from [127.0.0.1] (localhost.localdomain [127.0.0.1])
	by localhost6.localdomain6 (8.14.4/8.14.4) with ESMTP id u39KHvH3030748;
	Sat, 9 Apr 2016 22:17:57 +0200
Newsgroups: gmane.comp.version-control.git
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.0
In-Reply-To: <20160409173904.GA5127@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291124>

On 09/04/16 19:39, Jeff King wrote:

>    [1/3]: config: lower-case first word of error strings
>    [2/3]: git_config_set_multivar_in_file: all non-zero returns are errors
>    [3/3]: git_config_set_multivar_in_file: handle "unset" errors
>

I applied them to 2.8.1 and ran the testsuite again on Solaris 8/x86 and 
the segfault is gone.

-tgc
