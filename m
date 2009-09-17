From: Rustom Mody <rustompmody@gmail.com>
Subject: Re: git workflow for fully distributed mini-teams
Date: Thu, 17 Sep 2009 19:22:23 +0530
Message-ID: <f46c52560909170652t54f68c31hfbb8ae6472190ac1@mail.gmail.com>
References: <f46c52560909160035o6b09800eh5219d49e7569cf23@mail.gmail.com>
	 <20090916164356.GB24893@vidovic>
	 <f46c52560909170003l61a2e1a3kf62c94ffd7ed9710@mail.gmail.com>
	 <4AB1E514.9030501@viscovery.net>
	 <f46c52560909170538q4d316d00jcccad8ec9f563574@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Sep 17 15:52:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MoHPT-0002Fy-A5
	for gcvg-git-2@lo.gmane.org; Thu, 17 Sep 2009 15:52:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755336AbZIQNwV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Sep 2009 09:52:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754494AbZIQNwV
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Sep 2009 09:52:21 -0400
Received: from mail-px0-f202.google.com ([209.85.216.202]:36292 "EHLO
	mail-px0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755277AbZIQNwU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Sep 2009 09:52:20 -0400
Received: by pxi40 with SMTP id 40so37875pxi.5
        for <git@vger.kernel.org>; Thu, 17 Sep 2009 06:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type;
        bh=NHNnZajPBGAbzeHgVus5xaBuU0oq1+4j718o/urZcDE=;
        b=GPuA/gMrgqTPriEtz4E55ZsVRYqWr6+1t1TE7bAE+tLvmGlPaHCq91A8W3mtYYYfap
         AVl80yzWF4ee3Gfh7JytOBj8p7jRBVkd60x5uCvzT301k93lmWSGtSD+6+jarXDUgMmZ
         BopM8E3MkKvsjR9pagfjvS2OKYwDg4XyhH+gk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        b=GtHuhI+9Lv8PwASMlA/+5nsrHIML0KPF8yz57SwMf+6VgIEIZxiyZ1w2jG7lbXk4SU
         BRfstgK5DlxIg37KRjtomGs2wmTEvwn01e9ZC/atF5xSZckATpuLA4uTYFEdmPDjls2X
         fQXk9eLWhVo4K7HA9dny2CEwGEGz1IDxcSpU4=
Received: by 10.115.24.10 with SMTP id b10mr59817waj.127.1253195543803; Thu, 
	17 Sep 2009 06:52:23 -0700 (PDT)
In-Reply-To: <f46c52560909170538q4d316d00jcccad8ec9f563574@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128758>

On Thu, Sep 17, 2009 at 6:08 PM, Rustom Mody <rustompmody@gmail.com> wrote:
> On Thu, Sep 17, 2009 at 12:58 PM, Johannes Sixt <j.sixt@viscovery.net> wrote:
>> I think the most important thing would be that you send bundles around,
>> not patches, so that you all can work with and talk about unique object names.
>>
>> -- Hannes

I started looking at git bundle and find things like master\~10.
Whats the backslash doing?

Tried running git bundle create with and without the backslash -- it
produced the same bundle.

Looked up tilde-expansion in bash and I gather bash does things to the
~ only on beginning of words whereas as far as I can see git uses ~
only at the end of words like master.

What am I missing?
