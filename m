From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCHv2] Add --reference option to git submodule.
Date: Tue, 28 Apr 2009 16:51:00 +0200
Message-ID: <49F717D4.70708@viscovery.net>
References: <20090428123033.GA6839@redhat.com> <49F702C0.8030206@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Michael S. Tsirkin" <mst@redhat.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Apr 28 16:51:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lyoee-0000X9-1S
	for gcvg-git-2@gmane.org; Tue, 28 Apr 2009 16:51:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932098AbZD1OvQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Apr 2009 10:51:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761542AbZD1OvO
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Apr 2009 10:51:14 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:58706 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760566AbZD1OvN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Apr 2009 10:51:13 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1LyoeC-00031c-Uu; Tue, 28 Apr 2009 16:51:01 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 95D276B7; Tue, 28 Apr 2009 16:51:00 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <49F702C0.8030206@drmicha.warpmail.net>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117777>

Michael J Gruber schrieb:
> BTW, even dash has "test STRING" so portability doesn't require -n but I
> think it's OK either way.

It is not if STRING is user input; it could be, e.g., '-f', and then the
command gives a syntax error because of a missing argument.

It's safer to use test -z and test -n unless the string to test is
completely under the control of the script.

-- Hannes
