From: Adam Brewster <adambrewster@gmail.com>
Subject: Re: Trying to split repository
Date: Thu, 1 Oct 2009 12:49:03 -0400
Message-ID: <c376da900910010949p197aa311l9c91ef711beffdf7@mail.gmail.com>
References: <20091001160335.GA26068@raven.wolf.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Josef Wolf <jw@raven.inka.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 01 18:49:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MtOq6-00045q-Uy
	for gcvg-git-2@lo.gmane.org; Thu, 01 Oct 2009 18:49:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755238AbZJAQtB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Oct 2009 12:49:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754945AbZJAQtA
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Oct 2009 12:49:00 -0400
Received: from mail-ew0-f211.google.com ([209.85.219.211]:63271 "EHLO
	mail-ew0-f211.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752822AbZJAQtA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Oct 2009 12:49:00 -0400
Received: by ewy7 with SMTP id 7so382959ewy.17
        for <git@vger.kernel.org>; Thu, 01 Oct 2009 09:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type;
        bh=Q5WxS0PFfB5oGeteXRaW0vJ6sxLyGlikxUbhjwwpXcc=;
        b=eZ+VzIX/TXb5FMdWnHq+Dak9I4VVLuUsgEJ/8mzqDyiwp/Y0eJXZ0ipOPhR38oebe+
         GKIJ6FOtkAooexykaQp10U9DohKxfhYVXCb9VWDIPUDYWOaKN6obsd+OoKGslPqnvIa6
         r8SWQM2CKUlhV9svwkxOM44AemWTo8rlehM80=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        b=sIhp4YmTnK9mdKvpum8P3vdwh7BitB2JQTQgRskVrQqAyMhsSz6mYczqUTGpT0WvOw
         zB5ZyB1+sXp9M08pc2WgwuOZuaf/kcqdE96SQmuM8CMMz9N3kZnQEXLDgKqiQ+JpmqxP
         Jc7k3NhX8NoKIz4JNdaeuLBUaAoxZMtVh7BUk=
Received: by 10.216.21.2 with SMTP id q2mr347213weq.78.1254415743400; Thu, 01 
	Oct 2009 09:49:03 -0700 (PDT)
In-Reply-To: <20091001160335.GA26068@raven.wolf.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129400>

>
> Any hints how to get rid of those log entries?

git-filter-branch accepts a --prune-empty option that does what I
think you're looking for.

Adam
