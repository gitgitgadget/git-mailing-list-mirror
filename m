From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Useful tracking branches and auto merging
Date: Sun, 10 Oct 2010 20:48:24 +0300
Message-ID: <AANLkTikfwHZVSyffEb5b77OAxcdmYsvy7e72=JngZ4x+@mail.gmail.com>
References: <AANLkTimq0sKUavKiXepDOz+DvrymuRAVUyAyV+FzbCBD@mail.gmail.com>
	<20101004204625.GH6466@burratino>
	<AANLkTikkXdDepdeOY4MZvgfCEgX69Tx6d0-QS-g3bWK-@mail.gmail.com>
	<20101010171505.GA15495@localhost>
	<AANLkTimFYExqr_OcYMJ0kTv5K-wtu3pzsAu=rhq+19W-@mail.gmail.com>
	<20101010174521.GC15495@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Sun Oct 10 19:48:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P500i-0001HL-U6
	for gcvg-git-2@lo.gmane.org; Sun, 10 Oct 2010 19:48:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755444Ab0JJRsd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Oct 2010 13:48:33 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:60360 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752824Ab0JJRsd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Oct 2010 13:48:33 -0400
Received: by bwz15 with SMTP id 15so1274985bwz.19
        for <git@vger.kernel.org>; Sun, 10 Oct 2010 10:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=bmIIFM2qNdQCah3UZ051qAE9YBSRFdJOVA6F0DCLLS0=;
        b=On4SVKaDeHnYuAPqE7qinXM9VlPTzxAajoa316OvxU4Kw1RK7QhcW/FuRPSjbs31Id
         eBEl5ebluxVI6ASkWoyc5gbKawOHHXDDR3jV5KS/gaMl2jbnuQ/oWr9uE70iH/esqbiu
         Nksd8eTj8doHlpzg+Xw+9gnUsxrKDw9+4ScsM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=Nc1DufNF9IWM1cW1kzUMQfLeQfd3FPbZLBeE9uNk+4TYPYrNitbmPPn02QvHzxWDkk
         ZhVfzckgNFGNP8kUMetLHddas3WZDSIvXnYiUSRM7LkctVe42tnIFe3zPr8Zy4Lqnb4N
         G40qRXgzGus5ZXz0+nt9kojIekuQBPfuDAmgw=
Received: by 10.204.133.91 with SMTP id e27mr4277120bkt.197.1286732904140;
 Sun, 10 Oct 2010 10:48:24 -0700 (PDT)
Received: by 10.204.75.16 with HTTP; Sun, 10 Oct 2010 10:48:24 -0700 (PDT)
In-Reply-To: <20101010174521.GC15495@localhost>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158682>

On Sun, Oct 10, 2010 at 8:45 PM, Clemens Buchacher <drizzd@aon.at> wrote:
> On Sun, Oct 10, 2010 at 08:30:22PM +0300, Felipe Contreras wrote:
>>
>> There's no magic involved, it's just what you would expect, what else
>> should 'git merge' (without arguments) do?
>
> I would expect it to do nothing, or just output a usage.

So you are not going to type this command, how can such change in
behavior affect you?

> The
> proposed behavior is also unexpected because git-pull already does
> (almost) the same thing.

Not true. By your logic 'git fetch' should also do nothing because
'git pull' does "the same thing".

-- 
Felipe Contreras
