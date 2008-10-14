From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: retrieving a diff from git
Date: Tue, 14 Oct 2008 19:29:03 +0200
Message-ID: <81b0412b0810141029l7f37426axfc0646fa114fd3b5@mail.gmail.com>
References: <20081014145112.GR22427@vanheusden.com>
	 <81b0412b0810141001w46227afam70123237025a2d4d@mail.gmail.com>
	 <20081014172048.GW22427@vanheusden.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Folkert van Heusden" <folkert@vanheusden.com>
X-From: git-owner@vger.kernel.org Tue Oct 14 19:30:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kpniu-0008O0-EP
	for gcvg-git-2@gmane.org; Tue, 14 Oct 2008 19:30:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752609AbYJNR3I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Oct 2008 13:29:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752569AbYJNR3H
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Oct 2008 13:29:07 -0400
Received: from mail-gx0-f16.google.com ([209.85.217.16]:53456 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752281AbYJNR3G (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Oct 2008 13:29:06 -0400
Received: by gxk9 with SMTP id 9so5529861gxk.13
        for <git@vger.kernel.org>; Tue, 14 Oct 2008 10:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=uq+3QYBiEPi8Cm8tvynnFC9Nipab9YhIyXjrP1hA20g=;
        b=b/SMoQAcdZl4d9CLeiSGYtPe+NBxl3mNTKLb01xDAxlxoIFS2rJAha72WxL3f7Lr74
         AWRyWraxdUT4Kof1wptW2zSBhTVglC/FJlO80/6rAeQuwKetGwrYjW9wK1Ar1SDLrEh6
         MlrYrFXdVEc8C/4wRhlzELEL3HXnAJ12RLgIg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=QVyTcnuiKTqaAU9VHkBEAVUc5Q9uwh80ncEWVb8ArzuyhzbsegxtUaMXZ7OS8USNGp
         iTLM0LAZoEIzVxH7JWXRCpP9gKzzUmtiSbxVHSuOYo15+pkzRxoR5/YGDS6D5SRrI8V5
         RByQclnFaewcn+7B9IJe9jgjvZGAIe2b5pqQ0=
Received: by 10.100.198.13 with SMTP id v13mr7729526anf.123.1224005343253;
        Tue, 14 Oct 2008 10:29:03 -0700 (PDT)
Received: by 10.100.91.8 with HTTP; Tue, 14 Oct 2008 10:29:03 -0700 (PDT)
In-Reply-To: <20081014172048.GW22427@vanheusden.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98204>

2008/10/14 Folkert van Heusden <folkert@vanheusden.com>:
>> > How would I retrieve the 'kmemcheck' patches from git for the 2.6.27
>> > kernel? I browsed to the url
>> > http://git.kernel.org/?p=linux%2Fkernel%2Fgit%2Fx86%2Flinux-2.6-tip.git...
>> > but could not find how to retrieve that diff.
>> Well, you can of course just click on "commitdiff" (and "raw" afterwords)
>> for every commit,
>
> Hmmm the outcome does not apply cleanly to 2.6.27.

That's because the patches are not based on 2.6.27.

>> but ... Have you considered using Git for that?
>
> and check out the whole tree using Git? I did consider but then I would
> not have all bells and whistles to generate a Debian kernel package.

I afraid, that in this particular case you have no other choice, but ask Ingo.
