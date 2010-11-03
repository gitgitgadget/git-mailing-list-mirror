From: Kevin Ballard <kevin@sb.org>
Subject: Re: [PATCH 1/2] submodule: preserve all arguments exactly when recursing
Date: Tue, 2 Nov 2010 22:36:25 -0700
Message-ID: <B581ED92-DC3D-4F62-99B1-3D02C95471DE@sb.org>
References: <1288758882-77286-1-git-send-email-kevin@sb.org> <20101103053019.GC10631@burratino>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 03 06:36:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDW1R-0008SF-2K
	for gcvg-git-2@lo.gmane.org; Wed, 03 Nov 2010 06:36:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752554Ab0KCFg3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Nov 2010 01:36:29 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:44590 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751007Ab0KCFg2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Nov 2010 01:36:28 -0400
Received: by pwj3 with SMTP id 3so95205pwj.19
        for <git@vger.kernel.org>; Tue, 02 Nov 2010 22:36:27 -0700 (PDT)
Received: by 10.142.186.13 with SMTP id j13mr6338266wff.76.1288762587589;
        Tue, 02 Nov 2010 22:36:27 -0700 (PDT)
Received: from [10.8.0.89] ([69.170.160.74])
        by mx.google.com with ESMTPS id e14sm12614097wfg.8.2010.11.02.22.36.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 02 Nov 2010 22:36:26 -0700 (PDT)
In-Reply-To: <20101103053019.GC10631@burratino>
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160582>

On Nov 2, 2010, at 10:30 PM, Jonathan Nieder wrote:

> Kevin Ballard wrote:
> 
>> I tried to write tests for this, but there are only two ways to get args
>> with spaces to be accepted and passed to the recursive invocation.
>> The first is via the --reference flag, but I don't think it really makes
>> sense to use that flag in connection with --recursive and was not comfortable
>> using it in a test.
> 
> Could you explain this further?  I think --reference pointing to a
> repository with objects shared by multiple (sub)projects makes a lot
> of sense.

I hadn't given it a lot of thought, but I suppose you're right. I'm used to
using submodules to pull in disparate projects that don't share objects, but
I can imagine having repos that do share objects. I will try to write a test
for this using --reference.

-Kevin Ballard