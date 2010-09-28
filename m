From: Kevin Ballard <kevin@sb.org>
Subject: Re: [PATCH] merge-recursive: option to specify rename threshold
Date: Mon, 27 Sep 2010 17:14:55 -0700
Message-ID: <7FEED963-13E1-4A77-959A-FFD06669ED13@sb.org>
References: <A0604F16-CA84-4A84-B74B-CE8AB455DF77@sb.org> <1285202724-52474-1-git-send-email-kevin@sb.org> <7vk4m7n7uo.fsf@alter.siamese.dyndns.org> <D5046A0E-7A35-421D-856F-5278FBE02914@sb.org> <7vocbj3gjk.fsf@alter.siamese.dyndns.org> <FFDB2371-6C96-472C-A650-412546636450@sb.org> <20100927235355.GG11957@burratino> <385B97D7-03F5-4698-A659-15D5D1FA939B@sb.org> <20100928000837.GH11957@burratino>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 28 02:15:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0Nqa-0006oB-4z
	for gcvg-git-2@lo.gmane.org; Tue, 28 Sep 2010 02:15:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759793Ab0I1AO7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Sep 2010 20:14:59 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:35568 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759403Ab0I1AO6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Sep 2010 20:14:58 -0400
Received: by pzk34 with SMTP id 34so1396107pzk.19
        for <git@vger.kernel.org>; Mon, 27 Sep 2010 17:14:58 -0700 (PDT)
Received: by 10.142.69.9 with SMTP id r9mr7166423wfa.147.1285632898297;
        Mon, 27 Sep 2010 17:14:58 -0700 (PDT)
Received: from [10.8.0.89] ([69.170.160.74])
        by mx.google.com with ESMTPS id 9sm8060261wfd.12.2010.09.27.17.14.56
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 27 Sep 2010 17:14:57 -0700 (PDT)
In-Reply-To: <20100928000837.GH11957@burratino>
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157381>

On Sep 27, 2010, at 5:08 PM, Jonathan Nieder wrote:

> Kevin Ballard wrote:
> 
>> Good timing, I just sent out a patch that does almost exactly this,
>> though I went with --break-rewrites instead of --detect-rewrites.
> 
> Both new patches look good to me, for what it's worth (though it
> would be nicer to have tests, of course :)).

I considered tests, and I looked at the existing ones. I am unable to find any tests that actually test setting the rename/copy score to anything other than the default, and I was a bit hesitant to add tests that simply checked to make sure the long-form option was parsed correctly, as that would just be duplicating existing tests that use the short-form arguments.

-Kevin Ballard