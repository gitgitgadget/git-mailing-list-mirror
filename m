From: Kevin Ballard <kevin@sb.org>
Subject: Re: [RFC] Using gitrevisions :/search style with other operators
Date: Tue, 9 Nov 2010 00:06:47 -0800
Message-ID: <13A8F1B3-39B0-4D11-8763-9C458F75487D@sb.org>
References: <20101109083023.783fad9b@chalon.bertin.fr>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git list <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: Yann Dirson <dirson@bertin.fr>
X-From: git-owner@vger.kernel.org Tue Nov 09 09:07:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFjEP-0006U4-E6
	for gcvg-git-2@lo.gmane.org; Tue, 09 Nov 2010 09:07:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753440Ab0KIIGv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Nov 2010 03:06:51 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:42913 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753435Ab0KIIGu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Nov 2010 03:06:50 -0500
Received: by iwn10 with SMTP id 10so922329iwn.19
        for <git@vger.kernel.org>; Tue, 09 Nov 2010 00:06:49 -0800 (PST)
Received: by 10.231.34.6 with SMTP id j6mr4902587ibd.93.1289290009813;
        Tue, 09 Nov 2010 00:06:49 -0800 (PST)
Received: from [10.0.1.14] (c-24-130-32-253.hsd1.ca.comcast.net [24.130.32.253])
        by mx.google.com with ESMTPS id gy41sm958788ibb.11.2010.11.09.00.06.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 09 Nov 2010 00:06:49 -0800 (PST)
In-Reply-To: <20101109083023.783fad9b@chalon.bertin.fr>
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161022>

On Nov 8, 2010, at 11:30 PM, Yann Dirson wrote:

> Kevin wrote:
>> Junio wrote:
>>>   $ git log 'HEAD..:( :/Merge branch 'kb/blame-author-email' )^2'
> [...]
>> 
>> Interesting idea. It certainly solves the problem of being able to
>> embed it within other operations (though you do then have to worry
>> about escaping any embedded close-parens in the search), though it
>> does mean my suggestion for being able to select the 2nd (or nth)
>> match won't work.
> 
> Syntax like origin/pu^{/Merge 'kb/blame-author-email'}2 would be
> somewhat consistent with the commit^2 case, and would seem unambiguous
> as well - a bit weird, though.

This violates the idea that once you reach the end of a ^{} structure,
it resolves to a commit that can then be modified by subsequent operations.

-Kevin Ballard
