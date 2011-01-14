From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: Git Rebase blows away GIT_AUTHOR_NAME
Date: Fri, 14 Jan 2011 09:56:01 +0100
Message-ID: <AANLkTimONqL4=E4Unrsj9PU5u57KGXrmO6xWUOCLorgs@mail.gmail.com>
References: <AANLkTinMX0yEPvSc-c=96R42SbFZTjW5Mnveuxk3ZHS=@mail.gmail.com>
 <20110112182150.GC31747@sigill.intra.peff.net> <AANLkTimanDRHwoqSj7i9sVCZkze1L3Qp-zFYwTwHAOHX@mail.gmail.com>
 <AANLkTimvK3p3M8kbGzLxyhchoFONiD4=FGPWxxs=i0GA@mail.gmail.com>
 <AANLkTikqfX3jhSdP5xhFj=VktqW2S6AeGL_MF18g8ZA_@mail.gmail.com>
 <AANLkTimf2rwKqyWwQbdj7cjS8YcQwCXYGRCvQbZ5HZ19@mail.gmail.com>
 <AANLkTik15iV9SOv6rRL5+DQkAZ4JwBGTS+gqS3nXy2hN@mail.gmail.com> <AANLkTikk7Xdiey76Dmy848_B4qNX2-Vbis7p=E8vtNL9@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: JT Olds <jtolds@xnet5.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Tor Arntsen <tor@spacetec.no>
X-From: git-owner@vger.kernel.org Fri Jan 14 09:56:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PdfSO-0007Kc-R3
	for gcvg-git-2@lo.gmane.org; Fri, 14 Jan 2011 09:56:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752865Ab1ANI4Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Jan 2011 03:56:24 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:32801 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751478Ab1ANI4X (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Jan 2011 03:56:23 -0500
Received: by fxm20 with SMTP id 20so2536767fxm.19
        for <git@vger.kernel.org>; Fri, 14 Jan 2011 00:56:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=rpH5ct0nR53LFammaap+q653UgwQ80kfWRu1QcmQJ5Y=;
        b=oou97wBt4SIkSaCu4Oit7zV9vu5WW4tJc/Gec+sOukE7oWM6inLqDpMO8kY0j/+tT+
         PLMD+sSCKj0jAq1g6sa+nxQUcCfyjpBnZtxH9qZI1EKhmczb2S3Xrkh7o87Pqd3yRXOj
         urKsTLs6hAIBIq7tqa+aenJhww0+5VaWr7ctM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        b=XK7MQmcDvVNZjF9bBxo0LcZawjbPnQ4nbL2gApb3gheMhibZSVIUzEGMSJ0l//ebg6
         GBJwyhE6AbamKRvPyzrOEahyHp3JvJzZb9TFaQxaisan4w9EV/+vIFTGo1JScJN0Lni7
         FVTZ1BnqetREczY8q8/PABt95a7NIphoiz8O8=
Received: by 10.223.87.80 with SMTP id v16mr436933fal.128.1294995381994; Fri,
 14 Jan 2011 00:56:21 -0800 (PST)
Received: by 10.223.79.3 with HTTP; Fri, 14 Jan 2011 00:56:01 -0800 (PST)
In-Reply-To: <AANLkTikk7Xdiey76Dmy848_B4qNX2-Vbis7p=E8vtNL9@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165082>

On Fri, Jan 14, 2011 at 9:45 AM, Tor Arntsen <tor@spacetec.no> wrote:
> On Thu, Jan 13, 2011 at 19:20, Erik Faye-Lund <kusmabite@gmail.com> wrote:
>>[..] Besides, a name of
>> two characters aren't really sane. You'd need at least three
>> characters to form a first/last name pair.
>
> I think I've mentioned this before in another thread, but first/last
> name isn't universal, not even within countries where it's the common
> form. When I was as student there was a fellow student from another
> scandinavian country and his legal, full name consisted of a single
> letter.
>

I'm curious, what Scandinavian country was this? Because as a
Norwegian, I know a lot of people from all Scandinavian country, yet
I've never heard of such names. In Norway, I the shortest legal name
I've ever heard of was five characters.
