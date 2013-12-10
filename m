From: Monte Goulding <monte@sweattechnologies.com>
Subject: Re: Refspec wildcards for remotes require trailing slash
Date: Wed, 11 Dec 2013 06:59:45 +1100
Message-ID: <569D9126-F0FB-41A2-AB83-D002C2C2B679@sweattechnologies.com>
References: <3B290FD1-EF2B-4419-8845-45C5A3B4A3D3@sweattechnologies.com> <xmqqzjo8tt5y.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0 (Mac OS X Mail 6.5 \(1508\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 10 20:59:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VqTTH-00070H-K9
	for gcvg-git-2@plane.gmane.org; Tue, 10 Dec 2013 20:59:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750856Ab3LJT7v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Dec 2013 14:59:51 -0500
Received: from pancake.on-rev.com ([37.59.34.226]:51401 "EHLO
	pancake.on-rev.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750743Ab3LJT7u (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Dec 2013 14:59:50 -0500
Received: from [120.29.242.42] (port=50812 helo=[192.168.2.6])
	by pancake.on-rev.com with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.80.1)
	(envelope-from <monte@sweattechnologies.com>)
	id 1VqTTB-0000iW-7t; Tue, 10 Dec 2013 20:59:49 +0100
In-Reply-To: <xmqqzjo8tt5y.fsf@gitster.dls.corp.google.com>
X-Mailer: Apple Mail (2.1508)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - pancake.on-rev.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - sweattechnologies.com
X-Get-Message-Sender-Via: pancake.on-rev.com: authenticated_id: monte+sweattechnologies.com/only user confirmed/virtual account not confirmed
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239155>


On 11/12/2013, at 6:14 AM, Junio C Hamano <gitster@pobox.com> wrote:

> But it is debatable if such a change should allow "refs/a/b*" to
> match "refs/a/b/2".  Arguments can be made in both ways, and my
> knee-jerk reaction is it shouldn't.

Hmm.. for-each-ref doesn't match it but ls-remote does

Sorry: forgot to CC the list
