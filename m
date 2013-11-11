From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC/PATCH 0/4] Remove deprecated commands
Date: Mon, 11 Nov 2013 11:13:45 -0800
Message-ID: <20131111191345.GL10302@google.com>
References: <cover.1384098226.git.john@keeping.me.uk>
 <xmqq4n7in6c0.fsf@gitster.dls.corp.google.com>
 <20131111183853.GP24023@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Mon Nov 11 20:13:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vfwvp-0005TQ-T2
	for gcvg-git-2@plane.gmane.org; Mon, 11 Nov 2013 20:13:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754265Ab3KKTNv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Nov 2013 14:13:51 -0500
Received: from mail-pd0-f174.google.com ([209.85.192.174]:34430 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753840Ab3KKTNt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Nov 2013 14:13:49 -0500
Received: by mail-pd0-f174.google.com with SMTP id z10so5610760pdj.19
        for <git@vger.kernel.org>; Mon, 11 Nov 2013 11:13:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=xnTetm6tNCjtDD/6XyhnfkeFqWWS9iHl1pHMgflNP3c=;
        b=mcEJ5s1dowue8mmwUUjr1+kEMWCVCRalRDf35UMHifqcp+tnKDAZZQBSg2GEJ4wjFn
         sqT2cU1wq3yYEIy5agum1ZYOLntKIVte+iCyGUbKBqRsrAbrqZW9+Un3b26E07Wf1tWv
         F9a5+a5qFWS2mNVa9NVu/9vER59Ur2ZpBixseVOLS27tzM0e+AANw/akXEGu3dLkvtoB
         8e06HMkYQEjMjfcYI5qnnS7UNdX2zUY27OzibW7VrM/MY+DrrQhjvyrzboAcO0scv46O
         V/OQYy+5l7Zp59Rwm25zT0AElsHp+i0CHKkqMQDKSttin/1rfXlIsRXi/f8GglMUTRVA
         A5+Q==
X-Received: by 10.68.137.138 with SMTP id qi10mr31127978pbb.113.1384197228889;
        Mon, 11 Nov 2013 11:13:48 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id qf7sm37922405pac.14.2013.11.11.11.13.47
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 11 Nov 2013 11:13:48 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20131111183853.GP24023@serenity.lan>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237634>

John Keeping wrote:
> On Mon, Nov 11, 2013 at 10:25:51AM -0800, Junio C Hamano wrote:
>> John Keeping <john@keeping.me.uk> writes:

>>> "git repo-config", "git tar-tree", "git lost-found" and "git
>>> peek-remote" have all been deprecated since at least Git 1.5.4.
[...]
>> Probably good material to discuss during the next cycle.
[...]
> I was assuming these would be queued as a "held until 2.0" branch, but

Please no. :)  We already have a nice set of features for 2.0 and I
hope people have as few excuses not to upgrade as possible.  Anything
that actually needs the same kind of treatment that is introduced now
should wait for 3.0.

Removing repo-config, tar-tree, and peek-remote sounds fine to me
(though I haven't thought much about it either way) and I agree that
it wouldn't need to wait for an x.0 release.

Thanks,
Jonathan
