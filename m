From: Luke Diamand <luke@diamand.org>
Subject: Re: [PATCHv2 01/12] git p4 test: remove bash-ism of combined export/assignment
Date: Sun, 16 Sep 2012 10:38:16 +0100
Message-ID: <50559E08.5020500@diamand.org>
References: <1347221773-12773-1-git-send-email-pw@padd.com> <1347221773-12773-2-git-send-email-pw@padd.com> <5054F22D.2020909@diamand.org> <7vfw6izenb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Pete Wyckoff <pw@padd.com>, git@vger.kernel.org,
	Johannes Sixt <j.sixt@viscovery.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 16 11:39:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDBJp-0001hT-7o
	for gcvg-git-2@plane.gmane.org; Sun, 16 Sep 2012 11:39:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751605Ab2IPJiV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Sep 2012 05:38:21 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:58224 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751289Ab2IPJiU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Sep 2012 05:38:20 -0400
Received: by wgbdr13 with SMTP id dr13so4879537wgb.1
        for <git@vger.kernel.org>; Sun, 16 Sep 2012 02:38:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=pb/foYtbzHLyyi8TVLd1OySy4Rp3JDMxUfnisw/NpSk=;
        b=BZMEZfMomcBOP5LdB72CoQ/gEp8Pr72LFqwww7TNLjUM/j0seIycaF+mKZwfl8KdjJ
         4NfH2IG4ZZPRz7NwgofeCQfeNTISEwpnbnpMo02FCTV9+7RtP3glUVGXPABNP7P7gZ4e
         MoOK/FppOFCn34l5UdfmpGAS9+WZFOGQgSMTAEq1iBgZ0oAYTkDMWoBb0j1VTfemI+l5
         Mr/et8r/PUhkf0sRUX74p3uSs8OdaWF/NrpDwhRx71EwNRoiAbWXzaKhzXt30gzHQ5IC
         GnOKgAoOi1Hoj9Yx5IXdZI4ejROdQQtWtnvQeWwgcMUD6BRgpSBvTosoD/7gaUXfCD6L
         SbMQ==
Received: by 10.216.132.18 with SMTP id n18mr4465288wei.194.1347788298660;
        Sun, 16 Sep 2012 02:38:18 -0700 (PDT)
Received: from [86.6.26.120] (cpc21-cmbg14-2-0-cust119.5-4.cable.virginmedia.com. [86.6.26.120])
        by mx.google.com with ESMTPS id t8sm10638625wiy.3.2012.09.16.02.38.17
        (version=SSLv3 cipher=OTHER);
        Sun, 16 Sep 2012 02:38:17 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.4) Gecko/20120510 Icedove/10.0.4
In-Reply-To: <7vfw6izenb.fsf@alter.siamese.dyndns.org>
X-Gm-Message-State: ALoCoQltbE6z/2/AWQ82uFOBdBNMFkcBOkag3Qzhxm+Mn85zNSphp6dNDuC8fauHPXE1ssp3KLzu
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205602>

On 16/09/12 07:05, Junio C Hamano wrote:
> Luke Diamand<luke@diamand.org>  writes:
>
>> Looks good to me, ack.
>
> Thanks; is this an ack for the entire series, or are you expecting
> further back-and-forth with Pete before the whole thing is ready?

An ack for the whole series. I'm just going through the rest of the 
patches now but I don't expect to find any issues.
