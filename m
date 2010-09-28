From: Kevin Ballard <kevin@sb.org>
Subject: Re: [PATCH] merge-recursive: option to specify rename threshold
Date: Mon, 27 Sep 2010 17:01:18 -0700
Message-ID: <385B97D7-03F5-4698-A659-15D5D1FA939B@sb.org>
References: <A0604F16-CA84-4A84-B74B-CE8AB455DF77@sb.org> <1285202724-52474-1-git-send-email-kevin@sb.org> <7vk4m7n7uo.fsf@alter.siamese.dyndns.org> <D5046A0E-7A35-421D-856F-5278FBE02914@sb.org> <7vocbj3gjk.fsf@alter.siamese.dyndns.org> <FFDB2371-6C96-472C-A650-412546636450@sb.org> <20100927235355.GG11957@burratino>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 28 02:01:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0NdP-0003N4-0t
	for gcvg-git-2@lo.gmane.org; Tue, 28 Sep 2010 02:01:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759729Ab0I1ABW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Sep 2010 20:01:22 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:62329 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754256Ab0I1ABV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Sep 2010 20:01:21 -0400
Received: by pwi1 with SMTP id 1so181865pwi.19
        for <git@vger.kernel.org>; Mon, 27 Sep 2010 17:01:21 -0700 (PDT)
Received: by 10.114.110.2 with SMTP id i2mr9285148wac.142.1285632081228;
        Mon, 27 Sep 2010 17:01:21 -0700 (PDT)
Received: from [10.8.0.89] ([69.170.160.74])
        by mx.google.com with ESMTPS id s5sm11398989wak.12.2010.09.27.17.01.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 27 Sep 2010 17:01:19 -0700 (PDT)
In-Reply-To: <20100927235355.GG11957@burratino>
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157379>

On Sep 27, 2010, at 4:53 PM, Jonathan Nieder wrote:

> Kevin Ballard wrote:
> 
>> After taking a look at this, it raises another question. -B, -M, and
>> -C all have optional arguments, but the long-form names don't seem
>> to support that.
> [...]
>>                      if I make it support `git diff
>> --rename-threshold foo` that would also work, but the name doesn't
>> seem appropriate without the argument.
> 
> Right --- with merge-recursive the argument doesn't need to be
> optional, but with git diff it does.
> 
> How about
> 
> 	--detect-renames=<threshold>
> 	--detect-copies=<threshold>
> 	--detect-rewrites=<threshold>/<threshold>

Good timing, I just sent out a patch that does almost exactly this, though I went with --break-rewrites instead of --detect-rewrites.

-Kevin Ballard