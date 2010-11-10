From: Kevin Ballard <kevin@sb.org>
Subject: Re: [RFC] Using gitrevisions :/search style with other operators
Date: Tue, 9 Nov 2010 23:46:59 -0800
Message-ID: <23523534-F7A7-4D61-A899-8B3B28566EA7@sb.org>
References: <20101109083023.783fad9b@chalon.bertin.fr> <13A8F1B3-39B0-4D11-8763-9C458F75487D@sb.org> <20101109102428.5ba8dc13@chalon.bertin.fr> <7vlj52jakh.fsf@alter.siamese.dyndns.org> <050F42EE-34FE-499F-B632-471597EB4881@sb.org> <20101110083209.6a1252ef@chalon.bertin.fr>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git list <git@vger.kernel.org>,
	Jeff King <peff@peff.net>
To: Yann Dirson <dirson@bertin.fr>
X-From: git-owner@vger.kernel.org Wed Nov 10 08:47:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PG5Og-0000aD-T8
	for gcvg-git-2@lo.gmane.org; Wed, 10 Nov 2010 08:47:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754455Ab0KJHrF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Nov 2010 02:47:05 -0500
Received: from mail-gw0-f46.google.com ([74.125.83.46]:47079 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752881Ab0KJHrE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Nov 2010 02:47:04 -0500
Received: by gwj21 with SMTP id 21so158830gwj.19
        for <git@vger.kernel.org>; Tue, 09 Nov 2010 23:47:03 -0800 (PST)
Received: by 10.151.150.7 with SMTP id c7mr12374731ybo.304.1289375223779;
        Tue, 09 Nov 2010 23:47:03 -0800 (PST)
Received: from [10.0.1.14] ([24.130.32.253])
        by mx.google.com with ESMTPS id q14sm354589ybk.19.2010.11.09.23.47.01
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 09 Nov 2010 23:47:02 -0800 (PST)
In-Reply-To: <20101110083209.6a1252ef@chalon.bertin.fr>
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161135>

On Nov 9, 2010, at 11:32 PM, Yann Dirson wrote:

>> Another thing to consider - the current :/foo syntax searches for the
>> newest commit reachable from any ref. Using the ^{} syntax will
>> require specifying a ref first. I'm not sure this is a problem
>> though, as I'm not really sure why :/foo searches from all refs to
>> begin with.
> 
> The syntax could be extended so that ^{whatever} starts looking at
> current commit (ie. HEAD), somewhat like @{whatever} looks at reflog for
> current branch.

:/foo doesn't start from the current commit - it searches all refs. However,
making ^{} search all refs if not given one doesn't make sense for any
operator except :/foo, so I don't think it's worth doing

-Kevin Ballard
