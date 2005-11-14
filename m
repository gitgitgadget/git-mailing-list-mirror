From: Franck <vagabon.xyz@gmail.com>
Subject: Re: Can't use gitk.
Date: Mon, 14 Nov 2005 15:00:50 +0100
Message-ID: <cda58cb80511140600k2c0188c4i@mail.gmail.com>
References: <cda58cb80511140253s92f28e2g@mail.gmail.com>
	 <437870AF.8060607@op5.se>
	 <cda58cb80511140322v686e4ee0g@mail.gmail.com>
	 <43787831.3030404@op5.se>
	 <cda58cb80511140355q1add0ba5n@mail.gmail.com>
	 <43787E6E.8030702@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Nov 14 15:01:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EbetC-0004HL-Ro
	for gcvg-git@gmane.org; Mon, 14 Nov 2005 15:00:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751128AbVKNOAw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Nov 2005 09:00:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751129AbVKNOAw
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Nov 2005 09:00:52 -0500
Received: from zproxy.gmail.com ([64.233.162.195]:17526 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751128AbVKNOAv convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Nov 2005 09:00:51 -0500
Received: by zproxy.gmail.com with SMTP id 14so1273619nzn
        for <git@vger.kernel.org>; Mon, 14 Nov 2005 06:00:50 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pcz2+C93fzklGQk/i/o4iJQZoi5joOknZEku/JmQzhdtzGNuR6yUKl4BbD2S7G5/M5PRQSqtt26JtmZpkgyWf4AtSN82ltEseCv1ofQAY0RGPSw0r+o6uh+8CJZQ7plYq4rOqIBUMH6RE0NUwiMcZXhVN/7CbPLM5wjouvnXjOc=
Received: by 10.37.21.21 with SMTP id y21mr611049nzi;
        Mon, 14 Nov 2005 06:00:50 -0800 (PST)
Received: by 10.36.47.8 with HTTP; Mon, 14 Nov 2005 06:00:50 -0800 (PST)
To: Andreas Ericsson <ae@op5.se>
In-Reply-To: <43787E6E.8030702@op5.se>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11798>

Andreas

2005/11/14, Andreas Ericsson <ae@op5.se>:
> Yes, but wish or some such might strip $HOME/bin away from it.
>
> Try doing
>
> make clean; make prefix=/usr
> sudo make prefix=/usr install
>
> and see if it works.

it works.

>
> If it does, some program somewhere is manipulating your $PATH.

It seems that once wish is executed, $PATH does not include anymore my
$HOME/bin directory. Do you have any idea why ?

Thanks
--
               Franck
