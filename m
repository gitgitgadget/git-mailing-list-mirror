From: Christian Couder <christian.couder@gmail.com>
Subject: Re: confusion with some `git reset` commands
Date: Thu, 18 Dec 2014 09:38:21 +0100
Message-ID: <CAP8UFD3iUjDsFfFfiPKKqmUkz6mfOHL7_mjam8P-_K11XYknxg@mail.gmail.com>
References: <2055441.uOK6yH3IMG@linux-wzza.site>
	<CAO54GHAVMSYCHAoqH1OOSaUeHBdSmqTvzJLWWUa0_bO3CLy4zg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, Kevin <ikke@ikke.info>
To: Arup Rakshit <aruprakshit@rocketmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 18 09:38:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y1WbP-0007Fz-Uo
	for gcvg-git-2@plane.gmane.org; Thu, 18 Dec 2014 09:38:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752070AbaLRIi1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Dec 2014 03:38:27 -0500
Received: from mail-ie0-f169.google.com ([209.85.223.169]:58682 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751706AbaLRIi0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Dec 2014 03:38:26 -0500
Received: by mail-ie0-f169.google.com with SMTP id y20so697794ier.28
        for <git@vger.kernel.org>; Thu, 18 Dec 2014 00:38:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=eq2Ai0/rItTSsckxM3TcGIMj21Xn/wLqTLpoq3h7ZKk=;
        b=m6JBC918K/3Hq40/SFSjZnifcEjxeFW8gyTzZtp1yoHG+SwDiN3/dy7CIkH7iPb1xs
         cOhCe0FuYfrWJDvI6ZwdjfP82uWGDknPi8YvsDtDRNtkZRlZPp+RBHcluVShXH9pqgsf
         vaipsM3gJCgtartIlS+980MCbN4JDATy7y45nrkVigfmYIme6ZEDEVhdfepHdkq8DSpW
         3KEXEr+D2wG2aNMmZOSAAreVDX979hQtUFRsu0nA7Zw01d2dswc7LqshzJUgxeKTn0Wq
         Eu+q/z4lLYWkIe8KJv9+yOf0VUQzScLWKywLfLqBPPu3jXQq2N0/9hMXHlOtBOaF56t7
         GAuw==
X-Received: by 10.50.114.69 with SMTP id je5mr12247345igb.24.1418891901172;
 Thu, 18 Dec 2014 00:38:21 -0800 (PST)
Received: by 10.50.3.39 with HTTP; Thu, 18 Dec 2014 00:38:21 -0800 (PST)
In-Reply-To: <CAO54GHAVMSYCHAoqH1OOSaUeHBdSmqTvzJLWWUa0_bO3CLy4zg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261519>

> On Tue, Dec 16, 2014 at 7:39 PM, Arup Rakshit
> <aruprakshit@rocketmail.com> wrote:

>> From the command help I see -
>>
>> [arup@to_do_app]$ git reset -h

You can also use "git help reset" to have the full man page.
It has a lot more information.

>> But I am looking for any differences -

Do you have some use cases in mind?

Best,
Christian.
