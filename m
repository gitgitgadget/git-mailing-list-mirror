From: Ralph Seichter <git-ml@seichter.de>
Subject: Re: How to limit bandwidth used by git over SSH ?
Date: Wed, 20 Jul 2011 21:18:56 +0200
Message-ID: <4E272A20.8080904@seichter.de>
References: <4E22B7F7.4020701@seichter.de> <1311064940.3945.11.camel@bee.lab.cmartin.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?Q2FybG9zIE1hcnTDrW4gTmlldG8=?= <cmn@elego.de>
X-From: git-owner@vger.kernel.org Wed Jul 20 21:19:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QjcId-00045s-55
	for gcvg-git-2@lo.gmane.org; Wed, 20 Jul 2011 21:19:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752327Ab1GTTTJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 Jul 2011 15:19:09 -0400
Received: from seth.horus-it.com ([178.63.73.87]:52981 "EHLO seth.horus-it.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751868Ab1GTTTG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Jul 2011 15:19:06 -0400
Received: from localhost (localhost [127.0.0.1])
	by seth.horus-it.com (Postfix) with ESMTP id 9B252334034;
	Wed, 20 Jul 2011 21:19:04 +0200 (CEST)
Authentication-Results: seth.horus-it.com (amavisd-new);
	dkim=pass (1024-bit key) reason="pass (just generated, assumed good)"
	header.d=seichter.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=seichter.de; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:references:subject:subject:mime-version:user-agent:from:from
	:date:date:message-id; s=jul2011; t=1311189543; x=1313781544;
	 bh=SJYwKpiDTiS8O6XxAnL/gwLvHxRU+Cie5XjIUjc0Xag=; b=buYa0ihxsHv9
	CW+mt+iQBUIT0bhbOEwTRB7NH2ZfaoxD9f1EYzdmxgvlyhsmEOAux7uHWdCi0avZ
	yRHJtmNvsixiaDWBR21A6Y0vdISeUlWnyEOwQvhHuFcrbuFjg8zEDQkhh8xN99X7
	sfTF2q//J+X1iMOPm0eYhtFyeeQK/94=
X-Virus-Scanned: at seth.horus-it.com
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:5.0) Gecko/20110624 Thunderbird/5.0
In-Reply-To: <1311064940.3945.11.camel@bee.lab.cmartin.tk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177545>

On 19.07.11 10:42, Carlos Mart=C3=ADn Nieto wrote:

> There is a tool called trickle which takes over the network functions
> and can be used to limit upload and download speeds [...]

Thanks for the hint, Carlos. I tried to compile trickle on OS X 10.6.8,
but without success. AFAIK, trickle has not been tested with OS X, and =
I
am not even sure it trickle could work at all. Members of the MacPorts
mailing list seem to confirm my suspicion. I've tried to contact the
author of trickle; hopefully he will reply.

The general idea to use a tool besides git or SSH to shape the bandwidt=
h
usage seems valid, though.

-Ralph
