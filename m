From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: serious performance issues with images, audio files, and other 
	"non-code" data
Date: Tue, 18 May 2010 21:10:58 +0200
Message-ID: <AANLkTiltNPIR5gAWMOqZ2Y_azFUU93kH54ddHuCFFeCp@mail.gmail.com>
References: <4BEAF941.6040609@puckerupgames.com> <20100514051049.GF6075@coredump.intra.peff.net> 
	<4BED47EA.9090905@puckerupgames.com> <20100517231642.GB12092@coredump.intra.peff.net> 
	<AANLkTikAoZgvYXN-iGPGjMP-vdgrOuKp3_gJzGYaojec@mail.gmail.com> 
	<20100518190706.GA2383@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: John <john@puckerupgames.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue May 18 21:11:25 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OESCK-0000CE-TV
	for gcvg-git-2@lo.gmane.org; Tue, 18 May 2010 21:11:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757663Ab0ERTLU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 May 2010 15:11:20 -0400
Received: from mail-gx0-f227.google.com ([209.85.217.227]:64102 "EHLO
	mail-gx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752241Ab0ERTLT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 May 2010 15:11:19 -0400
Received: by gxk27 with SMTP id 27so3656293gxk.1
        for <git@vger.kernel.org>; Tue, 18 May 2010 12:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=taGCJsju5NDJdbLkJVaOu7Mr/b9WPOiJlH4uA61Cc4U=;
        b=Aq+ruSpzxqv0L4ZkK+owGJWoSToQyiGf5dHw2DP7b7P10ZRMNcOyazj3+kl8CTwUPN
         kri90JHY7MYEpwJtx0n2od7VLSatIqu05veT0H5h8CqRQnEnywqKSayfue24qgJvKtzr
         rFsl4cRLW80GoFRf0iyGe1k4tVmSWdx3aL9WA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=T9T8RsSk9LFwmN7/3LVXV1H1BO/ijzHU/l/o5oyJ6v/NUgeIdypv1pw+HYQn1wg6jO
         XKgYhLR72STkB5FAvhaX+BiNAOmagAO9fAw4wU2b764UfTUKlCLdhWVaAvf5Z4emhZfN
         KRLEWE+Wf15WY+zON9jV9kY4m96wF8+TXuMxs=
Received: by 10.151.117.14 with SMTP id u14mr8203548ybm.184.1274209878245; 
	Tue, 18 May 2010 12:11:18 -0700 (PDT)
Received: by 10.151.125.11 with HTTP; Tue, 18 May 2010 12:10:58 -0700 (PDT)
In-Reply-To: <20100518190706.GA2383@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147298>

Heya,

On Tue, May 18, 2010 at 21:07, Jeff King <peff@peff.net> wrote:
> No, not to my knowledge. Even the "binary" attribute just says "this
> file is binary, don't text diff it". I think we will always still do
> rewrite-detection for operations like "git status" and the diff summary
> of "git commit".

Would that not be a very sensible optimization that would help John
(and other users of big files) a lot?

-- 
Cheers,

Sverre Rabbelier
