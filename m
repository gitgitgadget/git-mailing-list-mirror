From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Redirect "git" subcommand to itself?
Date: Fri, 29 May 2015 09:49:22 -0700
Message-ID: <xmqq1thze3cd.fsf@gitster.dls.corp.google.com>
References: <CAGZ79kZHa9wUrRsWfHgGdSdx+cN9VAirAAfu3YLVTuSmggcehg@mail.gmail.com>
	<xmqqoal5ii21.fsf@gitster.dls.corp.google.com>
	<87zj4n4w3t.fsf@gmail.com>
	<xmqqsiafe6md.fsf@gitster.dls.corp.google.com>
	<87r3pz49r5.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Christian Neukirchen <chneukirchen@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 29 18:49:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YyNTQ-0007Qh-0J
	for gcvg-git-2@plane.gmane.org; Fri, 29 May 2015 18:49:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756455AbbE2Qt1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 May 2015 12:49:27 -0400
Received: from mail-ig0-f181.google.com ([209.85.213.181]:33225 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756055AbbE2QtY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 May 2015 12:49:24 -0400
Received: by igbpi8 with SMTP id pi8so19277478igb.0
        for <git@vger.kernel.org>; Fri, 29 May 2015 09:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=81vGkbbGmpfIEDnpu4Bti7UJCUOn4ziCcBEllKjv37g=;
        b=cT/+c/SPcv20k/4tjVJxWRgfbfKBsfNbivxBpKAm6syR2WtpxRrMHW8M3N5r2wWv15
         h5ZtWpdv+yvS6jOzDesyODfeoP2idhyz2trF4JRmQOIOVzwwwsLbOJM7L4TXXIsdv9BO
         4ycPm1e5gWRLYXGEOBH680UxLE2cFgLGPMHIYqjTH9nrejI+E59mjx3aXKa7Rejn3wSW
         3aPMX9XFtWmpbF/+Nt3qC8/U/pZm2d3Iq+KkA+yviJyJLoHbm/OSYdeDxVytyuytE1s0
         EtjpsgvtNU96+IIVUiDREx330d7BCf1kkUFPBz42FA5ySqDde7w3D3kFoqlY+M4/uGpC
         y8DQ==
X-Received: by 10.42.83.212 with SMTP id i20mr15901647icl.91.1432918163974;
        Fri, 29 May 2015 09:49:23 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:89d0:c49e:8012:77d2])
        by mx.google.com with ESMTPSA id f126sm4540657ioe.21.2015.05.29.09.49.23
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 29 May 2015 09:49:23 -0700 (PDT)
In-Reply-To: <87r3pz49r5.fsf@gmail.com> (Christian Neukirchen's message of
	"Fri, 29 May 2015 18:41:02 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270257>

Christian Neukirchen <chneukirchen@gmail.com> writes:

> I was just toying around, and it would have been cute.
>
>> Or didn't the alias work?
>
> It does.  This seems to work just as well, and is easier:

Thanks; I was wondering if I gave something that was not portable or
something.

> 	git = !git

I'd call that the ultimate cuteness.

We have a winner ;-) ;-) ;-).
