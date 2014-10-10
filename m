From: Charles Bailey <charles@hashpling.org>
Subject: Re: [PATCH] mergetool: use more conservative temporary filenames
Date: Fri, 10 Oct 2014 10:07:20 +0100
Message-ID: <2DA99335-66B9-438E-A445-EB54B81EBE7A@hashpling.org>
References: <1412758562-25402-1-git-send-email-davvid@gmail.com> <xmqq8ukp6qgf.fsf@gitster.dls.corp.google.com> <20141010081034.GA44749@gmail.com>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Sergio Ferrero <sferrero@ensoftcorp.com>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 10 11:07:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XcWAa-0004xd-Df
	for gcvg-git-2@plane.gmane.org; Fri, 10 Oct 2014 11:07:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751916AbaJJJHZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Oct 2014 05:07:25 -0400
Received: from host02.zombieandprude.com ([80.82.119.138]:48872 "EHLO
	host02.zombieandprude.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751744AbaJJJHY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Oct 2014 05:07:24 -0400
X-Greylist: delayed 320 seconds by postgrey-1.27 at vger.kernel.org; Fri, 10 Oct 2014 05:07:23 EDT
Received: from [62.189.9.199] (port=36942 helo=[10.255.82.95])
	by host02.zombieandprude.com with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:256)
	(Exim 4.80)
	(envelope-from <charles@hashpling.org>)
	id 1XcWAS-0004Pt-4w; Fri, 10 Oct 2014 10:07:20 +0100
X-Mailer: iPhone Mail (12A405)
In-Reply-To: <20141010081034.GA44749@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While you have the lid of this section of code, should we consider (optionally?) using a tmpdir to alleviate the eclipse issue where it wants temporary merge files to be the canonical locations for definitions of things that it finds when scanning source files in the project tree?

[Apologies for this email client's long lines.]