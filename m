From: =?windows-1252?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH 7/7] fast-import: minor style fix
Date: Fri, 23 Jan 2015 13:22:36 +0100
Message-ID: <54C23D0C.8020207@web.de>
References: <1422011208-3832-1-git-send-email-kuleshovmail@gmail.com> <1422011323-4278-1-git-send-email-kuleshovmail@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Alexander Kuleshov <kuleshovmail@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 23 13:22:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YEdGD-000281-3r
	for gcvg-git-2@plane.gmane.org; Fri, 23 Jan 2015 13:22:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753058AbbAWMWp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jan 2015 07:22:45 -0500
Received: from mout.web.de ([212.227.15.3]:56849 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752810AbbAWMWo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2015 07:22:44 -0500
Received: from macce.local ([78.68.171.36]) by smtp.web.de (mrweb004) with
 ESMTPSA (Nemesis) id 0MNg5K-1YKes33pxS-007Cnb; Fri, 23 Jan 2015 13:22:37
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
In-Reply-To: <1422011323-4278-1-git-send-email-kuleshovmail@gmail.com>
X-Provags-ID: V03:K0:gwcKnV211HtBBXpGhHp7ehaLiaeI9C0Qqb+ZLajQN2BN60LkQk8
 qKfZtSrEnfACsYC1E6TrAhIMmiO2Y/6Jp4yOfR19e7OtGaHybvcfs8IFBoVL2TWBT25+kCw
 fO+2m7SfDhjkakzOGBJAHWbpKlCwEy7bBRjSoI8MqlpnLoAoa+XQfOH7KtwCyAAjoBPazyg
 hmDczMW02ZEUPjqyzCLgg==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262916>

On 2015-01-23 12.08, Alexander Kuleshov wrote:
..
Asterisk must be next with variable
..
But this is a function:
> -static char* make_fast_import_path(const char *path)
> +static char *make_fast_import_path(const char *path)

(Sorry when I need to read this:)

 - Fixing style violations while working on a real change as a
   preparatory clean-up step is good, but otherwise avoid useless code
   churn for the sake of conforming to the style.

   "Once it _is_ in the tree, it's not really worth the patch noise to
   go and fix it up."
   Cf. http://article.gmane.org/gmane.linux.kernel/943020
