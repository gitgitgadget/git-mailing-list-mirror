From: David Turner <dturner@twopensource.com>
Subject: Re: Git autocorrect bug
Date: Thu, 05 Jun 2014 04:28:23 -0400
Organization: Twitter
Message-ID: <1401956903.18134.173.camel@stross>
References: <1401940145.18134.170.camel@stross>
	 <CACsJy8BSHAUiF_BR_Vi4_LOW0CSP-N09UpAg-UJvZJ1fvipejg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git mailing list <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 05 10:28:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WsT2I-0004Gh-JZ
	for gcvg-git-2@plane.gmane.org; Thu, 05 Jun 2014 10:28:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751126AbaFEI23 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2014 04:28:29 -0400
Received: from mail-qg0-f45.google.com ([209.85.192.45]:37268 "EHLO
	mail-qg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750840AbaFEI21 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2014 04:28:27 -0400
Received: by mail-qg0-f45.google.com with SMTP id z60so1025074qgd.32
        for <git@vger.kernel.org>; Thu, 05 Jun 2014 01:28:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:content-transfer-encoding
         :mime-version;
        bh=4B5y1KsMVCm+uaF5KccKnyt1oTw5tdhT+0s/HcLzwtc=;
        b=HZLCGJAZJSekUgKLTKda3mYnmqWkRv52evFVCorml6CuOgDYeCQY0tmORt7YpRLez/
         FxK7kwNI0b9mPlGHF4794E87osOQtpXQSdb4F1dA21V7Jv8pEBDOeIDJUr7clKAkKNwd
         qrJB+y3ZsmLp91gi3/i/yemEpQF0OpvpDkoTbiVp/3fcnDzeVjJgSHDbpCD2wBCwbdKz
         l9wKxZm8jsc1MT9vN0tFB01qCxMGawxC46lJ8eV6YGs49e6ICtPtFxNVNRtXqDkmuzBt
         M8t4at1+Un6P2pn3NHoHN0IyXuFnZmK+DLqSgbs22D8mSHtUmo2hMLucQzliXrJYAFOe
         h2vg==
X-Gm-Message-State: ALoCoQnM1cMRpo+7UXejrlEN9NfDOpRs/cf6EpRonRGPaq/VXyq7N1m2/iBOU9YI6DdtvHns064V
X-Received: by 10.224.165.148 with SMTP id i20mr14787973qay.41.1401956906770;
        Thu, 05 Jun 2014 01:28:26 -0700 (PDT)
Received: from [172.18.24.70] ([8.25.196.25])
        by mx.google.com with ESMTPSA id o88sm3318696qge.19.2014.06.05.01.28.25
        for <multiple recipients>
        (version=SSLv3 cipher=RC4-SHA bits=128/128);
        Thu, 05 Jun 2014 01:28:25 -0700 (PDT)
In-Reply-To: <CACsJy8BSHAUiF_BR_Vi4_LOW0CSP-N09UpAg-UJvZJ1fvipejg@mail.gmail.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250824>

On Thu, 2014-06-05 at 13:29 +0700, Duy Nguyen wrote:
> On Thu, Jun 5, 2014 at 10:49 AM, David Turner <dturner@twopensource.com> wrote:
> > fatal: internal error: work tree has already been set
> > Current worktree: /home/dturner/git
> > New worktree: /home/dturner/git/foo
> 
> This is the part you complain about, right? 

Yes.

> I think I might know
> what's going on here. But do you expect "git git foo" to turn to "git
> init foo" in the first place?

Yes.  That is, I generally expect autocorrect to work without internal
errors.  This one was a genuine typo (I typed git, got distracted, and
typed it again).  

(I actually think "git git" should just be "git", and I know some people
have a command for that; I should set that up)
