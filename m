From: Marco Costalba <mcostalba@gmail.com>
Subject: Re: git log --pretty=format:%h prints (unrequired) abbreviated sha
Date: Fri, 25 Sep 2009 19:25:02 +0100
Message-ID: <e5bfff550909251125t6ed59b1fv953eee597adc4471@mail.gmail.com>
References: <e5bfff550909250240q3351d39evbcf507af422fde43@mail.gmail.com>
	 <e5bfff550909250246qed6f2ci4237bdaefd8a18a@mail.gmail.com>
	 <4ABC9C5D.5030202@viscovery.net>
	 <e5bfff550909250344y535a05edx7d30ad7e48a5f036@mail.gmail.com>
	 <e5bfff550909250430x14b0d7f4w5e22467ddd66cc29@mail.gmail.com>
	 <e5bfff550909250704x724fd4c7lebe7184b4557c7a9@mail.gmail.com>
	 <4ABCCFE4.6070202@viscovery.net>
	 <e5bfff550909250718y51709692kc8d1e2586017341b@mail.gmail.com>
	 <4ABCE167.7060204@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Sep 25 20:25:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MrFTh-0005rH-Ti
	for gcvg-git-2@lo.gmane.org; Fri, 25 Sep 2009 20:25:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752106AbZIYSZA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Sep 2009 14:25:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752020AbZIYSZA
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Sep 2009 14:25:00 -0400
Received: from mail-ew0-f211.google.com ([209.85.219.211]:46196 "EHLO
	mail-ew0-f211.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751897AbZIYSY7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Sep 2009 14:24:59 -0400
Received: by ewy7 with SMTP id 7so2806995ewy.17
        for <git@vger.kernel.org>; Fri, 25 Sep 2009 11:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=W04z0paHCMJ9pb+7r8JF2eYQC4lmW1jdNU/ZI0VAK3Y=;
        b=mXZ+TPcZ4XpzxIIDh30aivxOeZH5yBd+Qfw47nwKD8W/nTIaVIvdpmF51fG1D7FKE+
         g/Rln9ZWH203gYbcSecMCn/j9o3w4ew0cc92PxOIV4nUwIDvHovRUjR2f/8saLCD8vG9
         Yb1cCtNHW2rL/pK0Aie2s+Rd7Qdo7DtjY846I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=lfu/Uc8s4jARz1C77+wHk1KsEUWXeDXoQ6yoJSO68LiMyX+ZtIhQiu7wVWC6f46sxi
         LdN0sEwaDkZFOIqROYUbrEPz1jT5OKCB2TZHd+vysC4WKGvf5+oZENr+ZREQrGN7iq4x
         OOSpETW5lYaZXaX2L9UD1MLUWXuXklAfYgOE0=
Received: by 10.216.90.82 with SMTP id d60mr91535wef.79.1253903102595; Fri, 25 
	Sep 2009 11:25:02 -0700 (PDT)
In-Reply-To: <4ABCE167.7060204@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129101>

On Fri, Sep 25, 2009 at 16:27, Johannes Sixt <j.sixt@viscovery.net> wrote:
> Marco Costalba schrieb:
>> On Fri, Sep 25, 2009 at 15:12, Johannes Sixt <j.sixt@viscovery.net> wrote:
>>> Does that work?
>>>
>>
>> No it doesn't.
>>
>> I had already C:\Program Files\Git\cmd in path, probably added by
>> msysgit installation.
>
> The point of the exercise is to not use the git.cmd wrapper. I.e. point
> your path not into C:\Program Files\Git\cmd, but into the bin directories
> so that you run git.exe, not git.cmd.
>

Now path is C:\Program Files\Git\bin

I have even deleted the contents of cmd directory to be sure they were
not called.

But unfortunatly the problem persists.
