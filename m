From: "Eric Raible" <raible@gmail.com>
Subject: Re: RFC: perhaps a "new file" should not be deleted by "git reset --hard"
Date: Thu, 11 Sep 2008 16:29:40 -0700
Message-ID: <279b37b20809111629s3c91ae4ci33135535812383e3@mail.gmail.com>
References: <279b37b20809101212g57e9ad99qbf6fa15888679894@mail.gmail.com>
	 <eafc0afe0809101912v72916d3hce9ae5d6812f0db8@mail.gmail.com>
	 <eafc0afe0809101914lff5b23ehaf625d702fbd9b5d@mail.gmail.com>
	 <51419b2c0809101938v30e5a1aflf944027aedc2d900@mail.gmail.com>
	 <loom.20080911T204256-821@post.gmane.org>
	 <7vd4jas6x8.fsf@gitster.siamese.dyndns.org>
	 <279b37b20809111519o76bea81br738983b4cda1978e@mail.gmail.com>
	 <3ab397d0809111604r5d9dda04p32a987208d1fa92d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Jeff Whiteside" <jeff.m.whiteside@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 12 01:30:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kdvcf-0007cw-BP
	for gcvg-git-2@gmane.org; Fri, 12 Sep 2008 01:30:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754839AbYIKX3n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Sep 2008 19:29:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754811AbYIKX3n
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Sep 2008 19:29:43 -0400
Received: from mail-gx0-f16.google.com ([209.85.217.16]:50266 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754700AbYIKX3m (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Sep 2008 19:29:42 -0400
Received: by gxk9 with SMTP id 9so17860091gxk.13
        for <git@vger.kernel.org>; Thu, 11 Sep 2008 16:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=D29xiI7yJZiip+HFOFSpv77eQfOKxMsHTy9JXJoVRqY=;
        b=KRQbsESHYrralC4qafC0uw8Ow79X39ibWlHu4/U7TLKvYojGxzTUj7ISuc2jeP0pSA
         LTorh9Gp1ux2//34OMix4fzgfrfvYhOEwn6RLOQL6twSZaw/uEQxjatXr/QaX6f/UML9
         WaFTRTWwhLJh4gaGLMbgHlpFD8ym/T0Smm15M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=Ynr49yucopFNoCixAAqI8YzxsG8qJxGYYTW9kxOjQS0FQFlRTTGQ2HyimnTSr02JUo
         Az5PN+rgm+CHIgpaKRuTTjWhDr1tbyV9LNOSP8mvs1Ss+W/rxUH1++CLmAXZ32Ww7FnE
         NXIhG3FSQBk1A3KPVwnCympDXr7cUyQp2gFFw=
Received: by 10.150.204.12 with SMTP id b12mr4912757ybg.160.1221175780971;
        Thu, 11 Sep 2008 16:29:40 -0700 (PDT)
Received: by 10.151.113.10 with HTTP; Thu, 11 Sep 2008 16:29:40 -0700 (PDT)
In-Reply-To: <3ab397d0809111604r5d9dda04p32a987208d1fa92d@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95668>

On Thu, Sep 11, 2008 at 4:04 PM, Jeff Whiteside
<jeff.m.whiteside@gmail.com> wrote:
> And if you want to delete all untracked files
>     ls | sed s/`git status --index --filenamesonly`//g | rm
>     ls | sed s/`git status --commitrepo --filenamesonly`//g | rm
>           (I realize those commands don't actually work, but I'm a noob.)

"git clean" will remove untracked files.
