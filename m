From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH] Add a svnrdump-simulator replaying a dump file for testing.
Date: Tue, 24 Jul 2012 14:06:01 +0200
Message-ID: <CABPQNSauwwQgM-48NBJVWhS5dRHhhoXpjrOxoXFiN5ymY2Rvzg@mail.gmail.com>
References: <4514544.Xip1OCQ7Uj@flomedio> <20120722214333.GB680@burratino>
 <2948040.5ceLh0WG3L@flomedio> <1448476.VR1Gla8Cvg@flomedio>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jonathan Nieder <jrnieder@gmail.com>, davidbarr@google.com,
	git@vger.kernel.org
To: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 24 14:06:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Stdt3-0005sg-IC
	for gcvg-git-2@plane.gmane.org; Tue, 24 Jul 2012 14:06:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753542Ab2GXMGo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jul 2012 08:06:44 -0400
Received: from mail-vb0-f46.google.com ([209.85.212.46]:49244 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753534Ab2GXMGn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2012 08:06:43 -0400
Received: by vbbff1 with SMTP id ff1so5633469vbb.19
        for <git@vger.kernel.org>; Tue, 24 Jul 2012 05:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=V8BJsck6+l7C86Rb/NH1HI3wv9hA2ty/znHbbAJb+5M=;
        b=A7xVtmp0Mn2YsLN5y0Kv3LIw/wHG5Ym9yIEr5vCIwFveHLwF6usvWDTloOkbwoYYc3
         DaIcvOlhkOs5H42+VLu9QJXKtnv7SrdRg+SrSFQKnb0icf5s36ool8tqimRydM46V3Kh
         np1xV4PJdIoVqKxbm1qrU51o3nhnow8z4LYDoIp8ulWB3ptmUALYSioZOKnGnvU+hhwH
         dlnzVFzH9tnE4MRhYyA0q6PDGkclDjk7AvIBpLBoJezjw8wE6l6PLCGp0StU1hJrvFrj
         OURQKxWb8xxp/SU6vnqt7zC3ZWA2Z16ABgxGPQ7b8FBUrufBgJDY+onH4EizAtkJj7Rq
         FP1A==
Received: by 10.52.95.110 with SMTP id dj14mr13464178vdb.69.1343131601698;
 Tue, 24 Jul 2012 05:06:41 -0700 (PDT)
Received: by 10.58.94.13 with HTTP; Tue, 24 Jul 2012 05:06:01 -0700 (PDT)
In-Reply-To: <1448476.VR1Gla8Cvg@flomedio>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202031>

On Mon, Jul 23, 2012 at 2:44 PM, Florian Achleitner
<florian.achleitner.2.6.31@gmail.com> wrote:
> +       sys.exit(ret)
> \ No newline at end of file

Nit: add a \n after "sys.exit(ret)", perhaps?
