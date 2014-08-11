From: Fabian Ruch <bafain@gmail.com>
Subject: Re: [PATCH v2 08/23] rebase -i: reword executes pre-commit hook on
 interim commit
Date: Mon, 11 Aug 2014 10:45:44 +0200
Message-ID: <53E882B8.4070209@gmail.com>
References: <53A258D2.7080806@gmail.com>	<cover.1407368621.git.bafain@gmail.com>	<03febc7259c741a0891183bf578c93600ab0d68d.1407368621.git.bafain@gmail.com> <87wqaiajcs.fsf@thomasrast.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
	Jeff King <peff@peff.net>
To: Thomas Rast <tr@thomasrast.ch>
X-From: git-owner@vger.kernel.org Mon Aug 11 10:45:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XGlEm-0004wu-1N
	for gcvg-git-2@plane.gmane.org; Mon, 11 Aug 2014 10:45:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752208AbaHKIps (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Aug 2014 04:45:48 -0400
Received: from mail-we0-f171.google.com ([74.125.82.171]:54194 "EHLO
	mail-we0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751464AbaHKIpr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Aug 2014 04:45:47 -0400
Received: by mail-we0-f171.google.com with SMTP id p10so8315930wes.16
        for <git@vger.kernel.org>; Mon, 11 Aug 2014 01:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=7P36QTUhj77vvaGYTPgLvhOlvJDYwjwZAxabKHSNcNw=;
        b=wqdzeLbR76m3L+jaSKaHyIq2IVZgieMpRwX5azQihHWUg9kuVcw80lxHTo2Gm7kmPi
         yaO9Bp66PpaICnT50q6KgYn8ZpJGQBlRiK4tuPplmnlDrsqH2pTleGoIc8c7FTamfD0f
         AlrDhFEeiOupUowaL5doNf4zJdRhBzrmKWTkD7iEKQla9Ox5L28+NY0AH7GUHg/7/t1j
         CHhCYs7T7m+bqf8/FXBQw9QXzbDTAr5BuzaXHR30IgI36ep6Q13pSOd8dipePjUlDNkw
         Cd12KGvpWdyOafdjPNPa9i4Qctj/ErfxPvt3iRa6f4BPlJzg1tcWo+bCVr6kQI3YGy0n
         StMQ==
X-Received: by 10.180.97.102 with SMTP id dz6mr23469733wib.61.1407746746343;
        Mon, 11 Aug 2014 01:45:46 -0700 (PDT)
Received: from client.googlemail.com (nat-wh-nan.rz.uni-karlsruhe.de. [141.70.81.135])
        by mx.google.com with ESMTPSA id mw4sm41188128wic.20.2014.08.11.01.45.44
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 11 Aug 2014 01:45:45 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <87wqaiajcs.fsf@thomasrast.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255119>

Hi Thomas,

Thomas Rast writes:
> Fabian Ruch <bafain@gmail.com> writes:
>> Subject: Re: [PATCH v2 08/23] rebase -i: reword executes pre-commit hook on interim commit
> 
> I think the change makes sense, but can you reword the subjects that it
> describes the state after the commit (i.e. what you are doing), instead
> of before the commit?

The log message subject now reads as follows:

> rebase -i: do not verify reworded patches using pre-commit

   Fabian
