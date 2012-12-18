From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: What's cooking in git.git (Dec 2012, #04; Sun, 16)
Date: Tue, 18 Dec 2012 09:38:50 +0100
Message-ID: <50D02B9A.1040906@viscovery.net>
References: <20121217213730.GA17212@ftbfs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 18 09:39:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tkshm-0004DL-IR
	for gcvg-git-2@plane.gmane.org; Tue, 18 Dec 2012 09:39:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754546Ab2LRIi5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Dec 2012 03:38:57 -0500
Received: from so.liwest.at ([212.33.55.24]:8975 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754390Ab2LRIi5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2012 03:38:57 -0500
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.77)
	(envelope-from <j.sixt@viscovery.net>)
	id 1TkshP-0006d0-5w; Tue, 18 Dec 2012 09:38:51 +0100
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id C58E31660F;
	Tue, 18 Dec 2012 09:38:50 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <20121217213730.GA17212@ftbfs.org>
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211740>

> Junio C Hamano wrote:
>> It could turn out that we may be able to get rid of sys/param.h
>> altogether, but one step at a time.  Inputs from people on minority
>> platforms are very much appreciated---does your platform build fine
>> when the inclusion of the file is removed from git-compat-util.h?

MinGW works fine with sys/param.h removed from git-compat-util.h.

-- Hannes
