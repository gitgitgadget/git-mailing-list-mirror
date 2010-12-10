From: Kevin Ballard <kevin@sb.org>
Subject: Re: [PATCH 0/2] [RFD] Using gitrevisions :/search style with other operators
Date: Fri, 10 Dec 2010 13:21:15 -0800
Message-ID: <66D6F30D-4707-4057-BB46-57B2DF01F479@sb.org>
References: <1291820319-12455-1-git-send-email-pclouds@gmail.com> <201012082051.09730.jnareb@gmail.com> <AANLkTimU6Bhx-2XsZ45_7BmT9fo9MpK8TJWB3zZ=j-i7@mail.gmail.com> <201012090254.24999.jnareb@gmail.com> <20101209015926.GA31119@burratino> <7vsjy7h3db.fsf@alter.siamese.dyndns.org> <AANLkTimg4Cy83gjzgC3fwg+t=B57b6gzOE98p-=2AR+K@mail.gmail.com> <20101210190332.GA6210@burratino>
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	Yann Dirson <dirson@bertin.fr>, Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 10 22:21:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PRAPO-0001OX-D6
	for gcvg-git-2@lo.gmane.org; Fri, 10 Dec 2010 22:21:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753744Ab0LJVVW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Dec 2010 16:21:22 -0500
Received: from mail-pz0-f46.google.com ([209.85.210.46]:38548 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753520Ab0LJVVV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Dec 2010 16:21:21 -0500
Received: by pzk6 with SMTP id 6so181688pzk.19
        for <git@vger.kernel.org>; Fri, 10 Dec 2010 13:21:21 -0800 (PST)
Received: by 10.142.128.18 with SMTP id a18mr857947wfd.267.1292016081030;
        Fri, 10 Dec 2010 13:21:21 -0800 (PST)
Received: from [10.8.0.89] ([69.170.160.74])
        by mx.google.com with ESMTPS id f5sm4533271wfg.14.2010.12.10.13.21.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 10 Dec 2010 13:21:19 -0800 (PST)
In-Reply-To: <20101210190332.GA6210@burratino>
X-Mailer: Apple Mail (2.1082)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163440>

On Dec 10, 2010, at 11:03 AM, Jonathan Nieder wrote:

> - What is the intended use for this family of modifiers?  I sort
>   of understand ^{:i/... } for people that forget what case they
>   have used, but why the :nth and others?

In my particular case, I was glancing through the logs, and I wanted to grab
the second branch that someone else had made that was merged into pu. I would
have loved to be able to run something like

  git merge origin/pu^{:nth(2)/nd/}

While we're speaking of modifiers, could we use one that says "only search
the first parent hierarchy", e.g. something equivalent to git log's --first-parent
flag?

-Kevin Ballard