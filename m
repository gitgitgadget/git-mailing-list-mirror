From: Lea Wiemann <lewiemann@gmail.com>
Subject: Re: [PATCH] perl/Git.pm: add parse_rev method
Date: Sat, 31 May 2008 00:05:43 +0200
Message-ID: <48407A37.4080603@gmail.com>
References: <20080530095047.GD18781@machine.or.cz>	<1212179270-26170-1-git-send-email-LeWiemann@gmail.com>	<20080530210531.GH18781@machine.or.cz>	<7vd4n3iivt.fsf@gitster.siamese.dyndns.org>	<86r6bjmpqc.fsf@blue.stonehenge.com> <484078C7.7020008@gmail.com> <86mym7mov6.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Petr Baudis <pasky@suse.cz>,
	git@vger.kernel.org
To: "Randal L. Schwartz" <merlyn@stonehenge.com>
X-From: git-owner@vger.kernel.org Sat May 31 00:06:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K2Cjv-0007kg-Ps
	for gcvg-git-2@gmane.org; Sat, 31 May 2008 00:06:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753931AbYE3WFc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 May 2008 18:05:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753949AbYE3WFc
	(ORCPT <rfc822;git-outgoing>); Fri, 30 May 2008 18:05:32 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:61105 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753931AbYE3WFb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 May 2008 18:05:31 -0400
Received: by fg-out-1718.google.com with SMTP id 19so203290fgg.17
        for <git@vger.kernel.org>; Fri, 30 May 2008 15:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        bh=/fVqfSHjucBn7YDNKR0EWJgLjKgMJhc+0d3czPNJIbc=;
        b=oRYpX2DyvbcvtZOYLHuQyvqkv5qQCPdVxPMvx7eD7zdqijA07lBW9Cs42azxXYeldkZfTRieD0n8JyjQWO1KPxJXwafifeIPHfGF1N38YX+Yh9QWotEsoTEgMINy8xnHYxToHaaDU/jCFRc3rNwJP28QtVH7A+jmJbtLqHY8RGI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=FB7i2wMd/PoHwa1uvpP6m2+czHNmPzLVm+yZIeCCfN9y5tAskw12LOaLehinTO6Ld9PhP6sJp33lxRJxsNXbsVQzKJtqITssWbVlcQTRak/V6XkeiMVYSH15EgFS1FfmyDnWjCTBAgTVqvjYFhp6PWnt4I10WKBoNDmt0ZDErpg=
Received: by 10.86.90.13 with SMTP id n13mr4625485fgb.3.1212185128582;
        Fri, 30 May 2008 15:05:28 -0700 (PDT)
Received: from ?192.168.23.50? ( [91.33.213.54])
        by mx.google.com with ESMTPS id e32sm2669086fke.15.2008.05.30.15.05.26
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 30 May 2008 15:05:27 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.14 (X11/20080421)
In-Reply-To: <86mym7mov6.fsf@blue.stonehenge.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83349>

Randal L. Schwartz wrote:
> "eval/die" *means* try/catch from other languages.
> 
> The extra layer of syntactic sugar is *not* worth it.  It merely obfuscates.

Cool, thanks for clarifying this.  As Petr suggested, this should 
probably be fixed in a separate patch.  (Perhaps after we have a test 
suite, to avoid regressions.)

-- Lea
