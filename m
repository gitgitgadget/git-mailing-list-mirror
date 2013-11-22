From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Re: Git issues with submodules
Date: Fri, 22 Nov 2013 14:09:53 -0800
Message-ID: <20131122220953.GI4212@google.com>
References: <CAErtv27dMepNSbBVdOokn6OF858ENaKooL+FzD7JHtp9nRPufw@mail.gmail.com>
 <CALkWK0nDME-z7G4kcag=ad3qH5FL9FawrYFyVLQB6Z_g+TV+vQ@mail.gmail.com>
 <20131122151120.GA32361@sigill.intra.peff.net>
 <CAErtv25zrsde7wYg+VUZebow2pmhDnDQG53Dmz_gbjavC-D2cA@mail.gmail.com>
 <CALkWK0m9MK=RBBor-ZeGrGU9KA6tZa89UUi0J7j9fxr1g6uJtQ@mail.gmail.com>
 <CAErtv24Lv1JegCBQ=TXvOsgBNHp=Rphk5YVAq2qqRbNmqfNSkw@mail.gmail.com>
 <CAErtv24P+wyZKvvuuPJJ0oxzMif7XtOwJDtKcTKQdKHZaAUbig@mail.gmail.com>
 <CALkWK0muxsRUtO6KYk5G3=RVN0nqd=8gOZn=jsNbTc4B9KCATQ@mail.gmail.com>
 <528FC638.5060403@web.de>
 <20131122215454.GA4952@sandbox-ub>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Sergey Sharybin <sergey.vfx@gmail.com>,
	Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Fri Nov 22 23:16:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vjz1n-00045e-88
	for gcvg-git-2@plane.gmane.org; Fri, 22 Nov 2013 23:16:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755876Ab3KVWQj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Nov 2013 17:16:39 -0500
Received: from mail-yh0-f42.google.com ([209.85.213.42]:38869 "EHLO
	mail-yh0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755278Ab3KVWQi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Nov 2013 17:16:38 -0500
Received: by mail-yh0-f42.google.com with SMTP id z6so1292744yhz.15
        for <git@vger.kernel.org>; Fri, 22 Nov 2013 14:16:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=Z1ZaODKNvB78H94XOHWcyupOsrm48vh9ZeaQPpiyEHs=;
        b=cLXNRZZ+zRSxsYcJGEIEOySAcySvN/ooyVaHHxet0KD58IQLXaQabl9L5oIZoAwToB
         IWi0WtVln8nDabXf8UFDG1PJG3XV3Fm5t6MVROPCmGeGmhl/fg/dtxzLYnMMSZdZ4VX4
         1rP+F11ta1XucTnxNTff/x1oFzfEQZ/mtE9tUfmv4/8Nnr8sN+kfj02ubLg6bikd6bd0
         mdKi8Ry8CVSCn8Oq5WzZpoTu0X86uY/hoS92x0OY8F17OC9SjDYebBBH4hnlD0AfBMbp
         jh1t1GSNlP2zW0FY7urrTsw0HlF3W4PHA63zZKgJAgge7bfhPdRUW473rGwAcEtkP2YH
         +21w==
X-Received: by 10.236.131.12 with SMTP id l12mr143590yhi.69.1385158196788;
        Fri, 22 Nov 2013 14:09:56 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id v22sm59142973yhn.12.2013.11.22.14.09.55
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 22 Nov 2013 14:09:56 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20131122215454.GA4952@sandbox-ub>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238217>

Heiko Voigt wrote:

> After that we can discuss whether add should add submodules that are
> tracked but not shown. How about commit -a ? Should it also ignore the
> change? I am undecided here. There does not seem to be any good
> decision. From the users point of view we should probably not add it
> since its not visible in status. What do others think?

I agree --- it should not add.

That leaves the question of how to add explicitly.  "git add -f"?
"git add --ignore-submodules=none"?

Thanks,
Jonathan
