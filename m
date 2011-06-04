From: Matt McCutchen <matt@mattmccutchen.net>
Subject: Prevalence of $prevent_xss
Date: Sat, 04 Jun 2011 17:15:01 -0400
Message-ID: <1307222101.5994.13.camel@localhost>
References: <1307177015-880-1-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 04 23:17:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QSyDo-0003IX-6m
	for gcvg-git-2@lo.gmane.org; Sat, 04 Jun 2011 23:17:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753011Ab1FDVPp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Jun 2011 17:15:45 -0400
Received: from hapkido.dreamhost.com ([66.33.216.122]:50148 "EHLO
	hapkido.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752826Ab1FDVPp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Jun 2011 17:15:45 -0400
Received: from homiemail-a62.g.dreamhost.com (caiajhbdcaib.dreamhost.com [208.97.132.81])
	by hapkido.dreamhost.com (Postfix) with ESMTP id 485C0178F21
	for <git@vger.kernel.org>; Sat,  4 Jun 2011 14:15:44 -0700 (PDT)
Received: from homiemail-a62.g.dreamhost.com (localhost [127.0.0.1])
	by homiemail-a62.g.dreamhost.com (Postfix) with ESMTP id E92FB634073;
	Sat,  4 Jun 2011 14:15:03 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; c=nofws; d=mattmccutchen.net; h=subject:from
	:to:cc:in-reply-to:references:content-type:date:message-id
	:mime-version:content-transfer-encoding; q=dns; s=
	mattmccutchen.net; b=jCaY8jWRRsEepYWTyrZP1lTVSMzhmlesUEWhs1TonXG
	1abGO0+J2b3EHPp/A8NuQAtV8K5lZaoy8+2vKtVPmh8yd7F0732wnDgMPfvur5AJ
	PnnGN6HlYX6QwXWJrS9dg0eRZ6h4u3AVCTt7LX2o3b/k6yUdTr+quGOTuZxkyjKg
	=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=mattmccutchen.net; h=
	subject:from:to:cc:in-reply-to:references:content-type:date
	:message-id:mime-version:content-transfer-encoding; s=
	mattmccutchen.net; bh=zFPOkWhqfQycBp+/FQ0ezyDY3JQ=; b=p5LGFkSiPW
	f8x8hWhTrnkcIpWq0u/3zPtkxlxdQJlVEmt8HNJBJ4H1pqE7UV7JX5TbpOqC62go
	2nICEhJ0eF7KI6l2SOY8SKmzkgc4TyXV3UKmszhZeuipxWrKN5UyFwEely/jGxo0
	FIEOPdidIMs+1dUKDxyQJHrMr45uHcDwo=
Received: from [192.168.1.40] (pool-74-96-127-26.washdc.east.verizon.net [74.96.127.26])
	(using SSLv3 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: matt@mattmccutchen.net)
	by homiemail-a62.g.dreamhost.com (Postfix) with ESMTPSA id 7F97F63406C;
	Sat,  4 Jun 2011 14:15:03 -0700 (PDT)
In-Reply-To: <1307177015-880-1-git-send-email-jnareb@gmail.com>
X-Mailer: Evolution 2.32.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175064>

On Sat, 2011-06-04 at 10:43 +0200, Jakub Narebski wrote:
> The fact that it this buglet was present for so long, since its
> introduction by Matt McCutchen in 7e1100e (gitweb: add $prevent_xss
> option to prevent XSS by repository content, 2009-02-07) without
> complaint shows that not many people are using this feature...

Yes.  Well, I'm still using it, and I found a few mentions on the web:

https://android.git.kernel.org/?p=tools/gerrit.git;a=blob;f=gerrit-httpd/src/main/java/com/google/gerrit/httpd/gitweb/GitWebServlet.java;h=947fbb423f1f8cf46db9876f4b80c600cdf9ee41;hb=HEAD#l193
http://ao2.it/wiki/How_to_setup_a_GIT_server_with_gitosis_and_gitweb
http://www.digitalfoo.net/posts/2009/11/git,_gitosis,_gitweb_on_FreeBSD/

And there are probably others who did their own custom things (GitHub?)
before the feature was added upstream.

-- 
Matt
