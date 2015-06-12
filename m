From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/8] object_id part 2
Date: Fri, 12 Jun 2015 15:14:25 -0700
Message-ID: <xmqqvbesbmm6.fsf@gitster.dls.corp.google.com>
References: <1433867316-663554-1-git-send-email-sandals@crustytoothpaste.net>
	<xmqq381zi3ev.fsf@gitster.dls.corp.google.com>
	<20150610235114.GA786544@vauxhall.crustytoothpaste.net>
	<20150611000251.GB786544@vauxhall.crustytoothpaste.net>
	<xmqqpp53gkmq.fsf@gitster.dls.corp.google.com>
	<xmqq4mmef22j.fsf@gitster.dls.corp.google.com>
	<20150612203054.GA29305@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	=?utf-8?B?Tmd1eQ==?= =?utf-8?B?4buFbiBUaMOhaSBOZ+G7jWM=?= Duy 
	<pclouds@gmail.com>, Michael Haggerty <mhagger@alum.mit.edu>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Sat Jun 13 00:14:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z3XDc-0007s6-Lu
	for gcvg-git-2@plane.gmane.org; Sat, 13 Jun 2015 00:14:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752285AbbFLWO2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jun 2015 18:14:28 -0400
Received: from mail-ie0-f178.google.com ([209.85.223.178]:35980 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752436AbbFLWO1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jun 2015 18:14:27 -0400
Received: by iecrd14 with SMTP id rd14so895917iec.3
        for <git@vger.kernel.org>; Fri, 12 Jun 2015 15:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=+YfobwMNCewlnjx0670ijnEbJYh1wzdaOSwUtbW2Rbo=;
        b=ajRwzord1u9ApQKr6GP9S8veJ1nrGsAtS6tNHoDzPo4ypRdzr8zeMIXomaHumKMFiu
         erMTKUintuypxUsGDsvOLTCKqIcUd8fdDVk8SeoGx/LF+XzkG5mt3RSGUZJZwr5chu88
         PcFfjv5kbZKPPV60xWgxoudyRfvWYLx6vK/cetCN+2X7rK/PEWx0golUwrGxa6tZZoZ3
         2voC2NymzMKbeWlHvK7GTgeAcpANl29fFz9y0uYkqkJ0WbU+FhDc8+0piuWwxzla+18s
         /hseV7kyck/cg5SiYo9ZME/699bfHfGO0GqRyyAgGuC/fiEaBAGpf5lwj5yboZJNncI8
         fBvA==
X-Received: by 10.42.144.131 with SMTP id b3mr18850713icv.35.1434147267099;
        Fri, 12 Jun 2015 15:14:27 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:a12d:7c00:b954:bc66])
        by mx.google.com with ESMTPSA id eg3sm2347844igb.0.2015.06.12.15.14.26
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 12 Jun 2015 15:14:26 -0700 (PDT)
In-Reply-To: <20150612203054.GA29305@vauxhall.crustytoothpaste.net> (brian
	m. carlson's message of "Fri, 12 Jun 2015 20:30:54 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271534>

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> While I did run the tests between each commit, I hadn't noticed they
> were failing because I don't have Apache installed on my laptop, so they
> were silently skipped.  I'll resubmit with that fixed.

It is somewhat strange that _only_ http part had failures like this,
and is unnerving, too, given that a few people seem to have given at
least a cursory read over the patches and didn't spot anything
obviously wrong.

Was that because there was a single manual botch, or was that merely
that other parts of the system do not have sufficient test coverage?
