From: Jonathan Nieder <jrnieder@gmail.com>
Subject: jn/shell-disable-interactive (Re: What's cooking in git.git (Feb
 2013, #05; Tue, 12))
Date: Tue, 12 Feb 2013 16:12:13 -0800
Message-ID: <20130213001213.GA15246@google.com>
References: <7v621xdql8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 13 01:12:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U5Pxy-0006Gj-TV
	for gcvg-git-2@plane.gmane.org; Wed, 13 Feb 2013 01:12:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755183Ab3BMAMX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2013 19:12:23 -0500
Received: from mail-pa0-f43.google.com ([209.85.220.43]:41119 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753230Ab3BMAMW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2013 19:12:22 -0500
Received: by mail-pa0-f43.google.com with SMTP id bh2so386013pad.2
        for <git@vger.kernel.org>; Tue, 12 Feb 2013 16:12:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=f0HOAfBA4mPNsrZa4/3Fob8vm2SQ1HTPU0bHPxavj/Y=;
        b=wErskpxLP+tdpyqvcy/raHFeCW69GLJ0FmcJCKlRlfwnt3wvkVQm4qA8mCToPYOtT7
         8W0+lHqDfAgzshAqzvf4ECuJYloAKqo9xbGFM3HarPWmNjXYI1YMznzm4I5YfwoUrM0Z
         vZ8XtWsMUNyEqbTDxCPx28JXXV6X8RXy0cLLqpwen/R2n8Bt+OjE5dWd7AAIMxS1TyFj
         tUtUezGCrHbGWl1vYg8LUGIdcHyYJ3c7v4BVco2WfqMxuHCJtCDJNFH5nMVgP32f7E3D
         1R+sIqsLeAD+IuG90tcF79QbD5giVJES5rN4EKkxBdzbYnnedjiTwqv5bZkFp+SllW2+
         7MLw==
X-Received: by 10.66.87.8 with SMTP id t8mr57600414paz.28.1360714341475;
        Tue, 12 Feb 2013 16:12:21 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPS id y9sm78712284paw.1.2013.02.12.16.12.19
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 12 Feb 2013 16:12:20 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7v621xdql8.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216229>

Junio C Hamano wrote:

> * jn/shell-disable-interactive (2013-02-11) 2 commits
>  - shell: pay attention to exit status from 'help' command
>  - shell doc: emphasize purpose and security model
>
>  Will merge to 'next'.

Please hold off on merging the second patch.  I'd like to reroll
renaming the command to 'no-interactive-login' or some such, which
would be less disruptive to existing setups and should be easier to
explain.

Thanks,
Jonathan
