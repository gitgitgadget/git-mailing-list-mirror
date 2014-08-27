From: David Turner <dturner@twopensource.com>
Subject: Re: revert top most commit
Date: Wed, 27 Aug 2014 18:15:38 -0400
Organization: Twitter
Message-ID: <1409177738.15185.5.camel@leckie>
References: <1409174048.2715.12.camel@jekeller-desk1.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: "Keller, Jacob E" <jacob.e.keller@intel.com>
X-From: git-owner@vger.kernel.org Thu Aug 28 00:15:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XMlVO-0007s9-9m
	for gcvg-git-2@plane.gmane.org; Thu, 28 Aug 2014 00:15:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935886AbaH0WPp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2014 18:15:45 -0400
Received: from mail-qg0-f50.google.com ([209.85.192.50]:62914 "EHLO
	mail-qg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932246AbaH0WPp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2014 18:15:45 -0400
Received: by mail-qg0-f50.google.com with SMTP id q108so32675qgd.9
        for <git@vger.kernel.org>; Wed, 27 Aug 2014 15:15:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=IWn7nWYxQD+LyxqkU31EIIXB0AvCusGf5pTgaz1mTe4=;
        b=Qe3CtkcCMP7zmbOkLmzD+003EMqqoXRVmZJEzQoJt8ZCCMGz9815BOTCqjAA8aKj/u
         i97ktNrAPuNiPKdiFWslx8q8kad5AeI0LE1QtYKqVWOoMrtqdC94a9+xo36EEtvtCl39
         cgAzX3NnIF4D9eLMnySE1Wpb5ueGpbYa/u7UbVkMRbIJJL/gx9NwePAj10ByAt2k/Xm4
         rseiSdD+sfCBcI3LZHENHgucJagfaI6RU0NBr6LN8QFVVgTe/eLNi4y9Tv15/TkD/4F7
         IzbSRbP2eJN2mMKf/T08YK991TjtKTlr8yFaKPCD3i/11qPmEyQmNBh3hhZV9hiwEO62
         mlDA==
X-Gm-Message-State: ALoCoQmURHrh8SOhXhBQbQYskJhEMOD6fJITtK4b6AcFr3q2KLAlCXZ7KjK3UsxLUoLA7P6PoAhc
X-Received: by 10.140.104.213 with SMTP id a79mr58753531qgf.46.1409177741764;
        Wed, 27 Aug 2014 15:15:41 -0700 (PDT)
Received: from [172.17.131.24] (ip-66-9-26-66.autorev.intellispace.net. [66.9.26.66])
        by mx.google.com with ESMTPSA id w9sm4952748qad.31.2014.08.27.15.15.40
        for <multiple recipients>
        (version=SSLv3 cipher=RC4-SHA bits=128/128);
        Wed, 27 Aug 2014 15:15:40 -0700 (PDT)
In-Reply-To: <1409174048.2715.12.camel@jekeller-desk1.amr.corp.intel.com>
X-Mailer: Evolution 3.10.4-0ubuntu2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256054>

On Wed, 2014-08-27 at 21:14 +0000, Keller, Jacob E wrote:
> Hi,
> 
> I am having trouble using revert. If I attempt to
> 
> $ git revert <sha1id>
> 
> where sha1id is the same as the HEAD commit, I instead get the output of
> what looks like git status.
> 
> Is there anything specific about git revert that prevents it from
> reverting the most recent commit?

Works for me.  What version of git?  Is there a public repo that someone
could test this out on?
