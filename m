From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH v7 04/12] revert/cherry-pick: add --skip option
Date: Thu, 24 Apr 2014 18:50:38 -0400
Message-ID: <CALkWK0krxvsGY=n4rXfo3SsHPpimqh4LMjxCjsy=YcNQ5b_p9Q@mail.gmail.com>
References: <1398307491-21314-1-git-send-email-felipe.contreras@gmail.com> <1398307491-21314-5-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Martin von Zweigbergk <martinvonz@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 25 00:52:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WdSUs-0007FD-PX
	for gcvg-git-2@plane.gmane.org; Fri, 25 Apr 2014 00:52:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759183AbaDXWv1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Apr 2014 18:51:27 -0400
Received: from mail-ig0-f180.google.com ([209.85.213.180]:64457 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759174AbaDXWvT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Apr 2014 18:51:19 -0400
Received: by mail-ig0-f180.google.com with SMTP id c1so1522554igq.1
        for <git@vger.kernel.org>; Thu, 24 Apr 2014 15:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=cmr2qBbak99OnMdLwddJsVqk6USWNBhOTPHFtEauflw=;
        b=NXlqPK/sPs6d8Wnim0YGb3cz34s6Myp3FQ/tcQWzEpWQvht0iL4boY7Q9JDPM7LaDF
         2u6mU/phKUdx4zdarTM5Ay6bUCIBIK1lBFg+Pj3WpdRAxtEpn7pHuzb0yUuejdAffKtv
         EdmAKCxZ0NMHPskL+V0xYIwClcRmPrDiJM25F2dI6JZ4cpV8vgFGBDwUu7H/sU3QiJdA
         5Zw64naRhYAuZK9xrP+UTJUHLbKTginl+Sc1LK/lRWUexgMIQQtwopgfhIDeMhRI9VpQ
         dPc9NSYPzEbw1iW+/Mi3BCA465++UysMzyFGCuty6WP/nH00fQ5ix/ecWjJRrRLQXNfe
         6Cvw==
X-Received: by 10.50.49.8 with SMTP id q8mr1379878ign.47.1398379878436; Thu,
 24 Apr 2014 15:51:18 -0700 (PDT)
Received: by 10.64.10.39 with HTTP; Thu, 24 Apr 2014 15:50:38 -0700 (PDT)
In-Reply-To: <1398307491-21314-5-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247019>

Felipe Contreras wrote:
> Akin to 'am --skip' and 'rebase --skip'.

I don't recall why my original sequencer series didn't include this
option. Perhaps Jonathan remembers?
