From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: make test
Date: Mon, 15 Oct 2012 14:09:39 +0200
Message-ID: <507BFD03.7060208@viscovery.net>
References: <k5gov5$fe1$1@ger.gmane.org> <507BEB12.9040101@viscovery.net> <003101cdaac4$430b7a30$c9226e90$@schmitz-digital.de> <507BF0EA.7000805@viscovery.net> <003801cdaac9$81d5bff0$85813fd0$@schmitz-digital.de> <507BF8FE.1060502@viscovery.net> <003901cdaacc$6f87e640$4e97b2c0$@schmitz-digital.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Joachim Schmitz <jojo@schmitz-digital.de>
X-From: git-owner@vger.kernel.org Mon Oct 15 14:09:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNjUX-0007G3-Et
	for gcvg-git-2@plane.gmane.org; Mon, 15 Oct 2012 14:09:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752629Ab2JOMJn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Oct 2012 08:09:43 -0400
Received: from so.liwest.at ([212.33.55.24]:53290 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752262Ab2JOMJm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2012 08:09:42 -0400
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.77)
	(envelope-from <j.sixt@viscovery.net>)
	id 1TNjUJ-00042q-H9; Mon, 15 Oct 2012 14:09:39 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 35E671660F;
	Mon, 15 Oct 2012 14:09:39 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:16.0) Gecko/20121010 Thunderbird/16.0.1
In-Reply-To: <003901cdaacc$6f87e640$4e97b2c0$@schmitz-digital.de>
X-Enigmail-Version: 1.4.5
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207742>

Am 10/15/2012 13:58, schrieb Joachim Schmitz:
> ++ mkdir failing-cleanup
> ++ cd failing-cleanup
> ++ cat
> ++ chmod +x failing-cleanup.sh
> ++ test_must_fail ./failing-cleanup.sh
> + eval_ret=1

I wonder why the log does not show the commands of function
test_must_fail. Is there a 'set +x' hidden somewhere? Run
./failing-cleanup.sh manually. Check its exit code (it should be non-zero,
but not something strange like 127 and above; see test_must_fail()) and
dig further from there. I'll stop here.

-- Hannes
