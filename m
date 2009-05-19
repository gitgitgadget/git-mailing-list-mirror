From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 2/3] Convert hash functions to char instead of struct
 object
Date: Tue, 19 May 2009 08:23:54 +0200
Message-ID: <4A12507A.3050307@viscovery.net>
References: <449c10960905182132h2c1b38b4jd28721adaeb38484@mail.gmail.com> <1242707644-29893-1-git-send-email-dpmcgee@gmail.com> <1242707644-29893-2-git-send-email-dpmcgee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Johannes.Schindelin@gmx.de, gitster@pobox.com
To: Dan McGee <dpmcgee@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 19 08:24:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6IkI-0002Fn-Qe
	for gcvg-git-2@gmane.org; Tue, 19 May 2009 08:24:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751422AbZESGYF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 May 2009 02:24:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751385AbZESGYC
	(ORCPT <rfc822;git-outgoing>); Tue, 19 May 2009 02:24:02 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:51001 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750759AbZESGYB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 May 2009 02:24:01 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1M6Ijy-0005kk-Js; Tue, 19 May 2009 08:23:54 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 520C654D; Tue, 19 May 2009 08:23:54 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <1242707644-29893-2-git-send-email-dpmcgee@gmail.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119494>

Dan McGee schrieb:
> -static unsigned int hash_obj(struct object *obj, unsigned int n)
> +static unsigned int hash_chars(const unsigned char *c, unsigned int n)

hash_chars suggests that this function hashes arbitrary character
sequences, but it doesn't do that. Wouldn't hash_object_id be a better
name? (And the parameter would then obviously be named sha1 or id.)

-- Hannes
