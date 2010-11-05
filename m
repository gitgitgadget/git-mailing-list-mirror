From: Kevin Ballard <kevin@sb.org>
Subject: Re: [PATCH] git-rebase--interactive.sh: Add new command "shell"
Date: Fri, 5 Nov 2010 01:39:37 -0700
Message-ID: <9290474C-CD01-4C28-8B3B-3A577D569FC7@sb.org>
References: <9C0BAFB4-299E-459B-A64A-54D480C5445D@sb.org> <20101104112530.5c0e444a@chalon.bertin.fr> <4CD2E7B4.3000908@nextest.com> <vpq62wddmc0.fsf@bauges.imag.fr> <20101104181020.GB16431@burratino> <20101104205307.GA8911@home.lan> <4CD3B35B.3010404@viscovery.net>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Yann Dirson <ydirson@free.fr>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Eric Raible <raible@nextest.com>,
	Yann Dirson <dirson@bertin.fr>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Nov 05 09:39:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PEHps-0005Lv-Hr
	for gcvg-git-2@lo.gmane.org; Fri, 05 Nov 2010 09:39:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753431Ab0KEIjo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Nov 2010 04:39:44 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:58297 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752043Ab0KEIjm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Nov 2010 04:39:42 -0400
Received: by ywc21 with SMTP id 21so1997316ywc.19
        for <git@vger.kernel.org>; Fri, 05 Nov 2010 01:39:42 -0700 (PDT)
Received: by 10.151.157.19 with SMTP id j19mr2402687ybo.256.1288946381974;
        Fri, 05 Nov 2010 01:39:41 -0700 (PDT)
Received: from [10.0.1.14] (c-24-130-32-253.hsd1.ca.comcast.net [24.130.32.253])
        by mx.google.com with ESMTPS id q4sm2350632yba.14.2010.11.05.01.39.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 05 Nov 2010 01:39:40 -0700 (PDT)
In-Reply-To: <4CD3B35B.3010404@viscovery.net>
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160806>

On Nov 5, 2010, at 12:33 AM, Johannes Sixt wrote:

> Am 11/4/2010 21:53, schrieb Yann Dirson:
>> #  e, edit = use commit (if specified) but pause to amend/examine/test
> 
> That's fine. But how would you determine the "if specified"? In
> particular, I like to replace the commit subject by instructions that
> remember me what I intended to do after rebase stopped, and I would like
> to do that in either of these two forms:
> 
> e merge foo-topic!
> 
> or
> 
> e - merge foo-topic!

This was my complaint about overriding "edit" as well, but I kind of like
your second example. Can you come up with a simple way to explain it in
the instructions?

-Kevin Ballard
