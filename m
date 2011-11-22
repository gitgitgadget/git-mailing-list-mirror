From: Vincent van Ravesteijn <vfr@lyx.org>
Subject: Re: [msysGit] [PATCH 1/2] MSVC: Do not close stdout to prevent a
 crash
Date: Tue, 22 Nov 2011 22:27:41 +0100
Message-ID: <4ECC13CD.5000608@lyx.org>
References: <1321710345-2299-1-git-send-email-vfr@lyx.org> <4EC80D84.2010202@kdbg.org> <4ECB4501.1060100@lyx.org> <4ECC04E3.70407@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, msysgit@googlegroups.com, gitster@pobox.com,
	kusmabite@gmail.com, Johannes.Schindelin@gmx.de
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Tue Nov 22 22:27:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RSxse-0000Q8-JL
	for gcvg-git-2@lo.gmane.org; Tue, 22 Nov 2011 22:27:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755932Ab1KVV1r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Nov 2011 16:27:47 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:50919 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752421Ab1KVV1r (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Nov 2011 16:27:47 -0500
Received: by ghrr1 with SMTP id r1so656772ghr.19
        for <git@vger.kernel.org>; Tue, 22 Nov 2011 13:27:46 -0800 (PST)
Received: by 10.213.21.201 with SMTP id k9mr1084258ebb.111.1321997265705;
        Tue, 22 Nov 2011 13:27:45 -0800 (PST)
Received: from [192.168.1.5] (j175101.upc-j.chello.nl. [24.132.175.101])
        by mx.google.com with ESMTPS id 54sm45497025eex.8.2011.11.22.13.27.43
        (version=SSLv3 cipher=OTHER);
        Tue, 22 Nov 2011 13:27:43 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:8.0) Gecko/20111105 Thunderbird/8.0
In-Reply-To: <4ECC04E3.70407@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185810>


>> Is there any argument to not redirect stdout to "/dev/null" on all
>> platforms ?
> You paper over a crack in the wall. You hide a bug.

Luckily I'm still trying to find the crack and not ready to tape 
anything yet.

Vincent
