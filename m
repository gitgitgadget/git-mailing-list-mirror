From: Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: Python version auditing followup
Date: Thu, 27 Dec 2012 22:57:12 +0100
Message-ID: <1356645432.5522.3.camel@localhost>
References: <20121220143411.BEA0744105@snark.thyrsus.com>
	 <7vobho60fs.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: "Eric S. Raymond" <esr@thyrsus.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 27 23:19:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ToLnd-0000sI-Q2
	for gcvg-git-2@plane.gmane.org; Thu, 27 Dec 2012 23:19:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751723Ab2L0WTU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Dec 2012 17:19:20 -0500
Received: from mail-wi0-f182.google.com ([209.85.212.182]:42241 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751532Ab2L0WTS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Dec 2012 17:19:18 -0500
X-Greylist: delayed 1322 seconds by postgrey-1.27 at vger.kernel.org; Thu, 27 Dec 2012 17:19:18 EST
Received: by mail-wi0-f182.google.com with SMTP id hn14so5610352wib.9
        for <git@vger.kernel.org>; Thu, 27 Dec 2012 14:19:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-type:x-mailer:mime-version
         :content-transfer-encoding:x-gm-message-state;
        bh=7CtkS/UwL/QeiWId8XLmwgkRWDIFech0q6ul7fHk0cM=;
        b=EiMQ/6+p+J9XTS3Wm3CTzl8dibH5An1c/ebqZUROMXdkWrUR5WhJKUvvvBF0lrUDaD
         LGRetkDLuswvggQfeXrlvz67YAMvtVbDvbLv2GqSCJv3gW26VqCLO8pUz3Ma4pCRxVxx
         ll1yV5EXeeaK2VgjF2dMbFqIZqMpdgtn2C9r7YQO/4b0jYMY4AmCcq8yTICD9MmIGpM7
         ViYNYdTAByk/RzoezO+rSOxwRDR+5Cih1uYqLSCRZ3tTVm3WqnMGsy+82km/U1AefhI2
         6AdTjCZXDve12CDdZdYFcVkcCU9ih/bVTarvLqpIU2yKZnXTVuNh3OOdOhg90P9Erdgz
         HIhw==
X-Received: by 10.180.33.44 with SMTP id o12mr42698772wii.28.1356645435504;
        Thu, 27 Dec 2012 13:57:15 -0800 (PST)
Received: from [10.42.1.4] (82-168-11-8.ip.telfort.nl. [82.168.11.8])
        by mx.google.com with ESMTPS id bd7sm51382651wib.8.2012.12.27.13.57.13
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 27 Dec 2012 13:57:14 -0800 (PST)
In-Reply-To: <7vobho60fs.fsf@alter.siamese.dyndns.org>
X-Mailer: Evolution 3.6.0-0ubuntu3 
X-Gm-Message-State: ALoCoQljzU5EoxlYCoQoBM99Rj/N+F6WeZYVJ5SYosdX6wNcco1OrN7Lnbe72IIq8hcwe1ULogAj
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212215>

On do, 2012-12-20 at 10:30 -0800, Junio C Hamano wrote:
> Which platforms that are long-term-maintained by their vendors still
> pin their Python at 2.4.X? 

RHEL 5.x and its clones still use python 2.4. It is supported by red hat
until at least 2017 (though end of production phase two, Q1 2014, seems
like a reasonable cut-off point).
-- 
Dennis Kaarsemaker
