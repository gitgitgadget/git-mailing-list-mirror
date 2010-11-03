From: Kevin Ballard <kevin@sb.org>
Subject: Re: [PATCH 1/2] submodule: preserve all arguments exactly when recursing
Date: Tue, 2 Nov 2010 22:49:52 -0700
Message-ID: <4938B399-3872-4352-9A78-BACAF5ECE38B@sb.org>
References: <1288758882-77286-1-git-send-email-kevin@sb.org> <20101103043725.GA10311@burratino> <5BE96A08-B8AB-4041-ABF2-7095EB5DD585@sb.org> <20101103054751.GE10631@burratino>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 03 06:50:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDWES-0006fU-2v
	for gcvg-git-2@lo.gmane.org; Wed, 03 Nov 2010 06:50:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752829Ab0KCFt4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Nov 2010 01:49:56 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:55079 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752404Ab0KCFtz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Nov 2010 01:49:55 -0400
Received: by pvb32 with SMTP id 32so83915pvb.19
        for <git@vger.kernel.org>; Tue, 02 Nov 2010 22:49:54 -0700 (PDT)
Received: by 10.142.246.13 with SMTP id t13mr7002862wfh.446.1288763394700;
        Tue, 02 Nov 2010 22:49:54 -0700 (PDT)
Received: from [10.8.0.89] ([69.170.160.74])
        by mx.google.com with ESMTPS id w14sm12641038wfd.18.2010.11.02.22.49.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 02 Nov 2010 22:49:54 -0700 (PDT)
In-Reply-To: <20101103054751.GE10631@burratino>
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160586>

On Nov 2, 2010, at 10:47 PM, Jonathan Nieder wrote:

> Kevin Ballard wrote:
>> On Nov 2, 2010, at 9:37 PM, Jonathan Nieder wrote:
> 
>>> Have you looked into "git rev-parse --sq-quote"?
>> 
>> Well crud, I wish I'd seen that before. Looks like it does pretty much the
>> exact same thing as my quote_words function. I'll send out another patch
>> that uses this instead of quote_words. Thanks for the info!
> 
> Incidentally, if you still remember where it might have been useful
> to find this advertised (git-sh-setup?), maybe we can find a way to document
> it better.

It might make sense to mention it in CodingGuidelines. That's where I always
look when writing shell code in order to make sure I'm not using any bashisms.

-Kevin Ballard