From: Dmitry Kakurin <dmitry.kakurin@gmail.com>
Subject: Re: .gitignore, .gitattributes, .gitmodules, .gitprecious?, .gitacls? etc.
Date: Sat, 25 Aug 2007 22:17:26 -0700
Message-ID: <52E107D8068148B795FB4279B6272B8E@ntdev.corp.microsoft.com>
References: <2646CA4BEA644C9E9089C4A1AC395250@ntdev.corp.microsoft.com> <7v1wdqud0z.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 26 07:18:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPAVf-0008QD-MT
	for gcvg-git@gmane.org; Sun, 26 Aug 2007 07:18:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750925AbXHZFRc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 26 Aug 2007 01:17:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750834AbXHZFRb
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Aug 2007 01:17:31 -0400
Received: from wa-out-1112.google.com ([209.85.146.178]:45643 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750784AbXHZFRb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Aug 2007 01:17:31 -0400
Received: by wa-out-1112.google.com with SMTP id j4so1590219wah
        for <git@vger.kernel.org>; Sat, 25 Aug 2007 22:17:30 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:to:cc:references:in-reply-to:subject:date:mime-version:content-type:content-transfer-encoding:x-priority:x-msmail-priority:x-mailer:x-mimeole:from;
        b=Hvdo9JbV5uVaZeU8/nqxB2x3wO3dBIBiEm7XVVkZI1X18I4uDxjlBGUsCOO9c0Gxxshh/pgXEAw7vcPwKyY9j+ha6vRCc+HurlLdzybHwEzl3WDGzd4izxKiHsbvz+gYVJbqA0oWT0HHebc8dk+Os1eOrBhwLP16qEwAQI/p5B0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:to:cc:references:in-reply-to:subject:date:mime-version:content-type:content-transfer-encoding:x-priority:x-msmail-priority:x-mailer:x-mimeole:from;
        b=hXCaIgNAsehN8Eg+eSFyZpsxmWyLH+PTfkWVwzshfDim3kNUXo072C3nzL//EUUPNrXyl5rqV94v/0DMFLHvN1EZW0gqB7K29CjZ5NgZ1LF0aO9R5TGQUnA7/ojNEh+wj9hZRvr9y72z/j80KiuV+lgxHBMlC6T+8HFzjfwRiuM=
Received: by 10.114.77.1 with SMTP id z1mr4122479waa.1188105450172;
        Sat, 25 Aug 2007 22:17:30 -0700 (PDT)
Received: from dmitrykl2 ( [71.112.20.227])
        by mx.google.com with ESMTPS id f20sm5171341waf.2007.08.25.22.17.29
        (version=SSLv3 cipher=OTHER);
        Sat, 25 Aug 2007 22:17:29 -0700 (PDT)
In-Reply-To: <7v1wdqud0z.fsf@gitster.siamese.dyndns.org>
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Windows Mail 6.0.6000.16480
X-MimeOLE: Produced By Microsoft MimeOLE V6.0.6000.16480
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56674>

----- Original Message ----- 
From: "Junio C Hamano" <gitster@pobox.com>
 >> 2. Storing metadata in regular source-controlled files feels wrong to
>> me.
> You are free to _feel_ whatever you want without thinking, but

I did quite a bit of thinking before posting it. Not sure what made you think otherwise.

>  I think reading from
> index as a fallback measure when work tree file is missing is a
> very good compromise we came up recently.

Can you specify _exactly_ how it works now? And I'll show you a bunch of corner cases where it's broken.

- Dmitry
