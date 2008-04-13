From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [ANNOUNCE] GIT 1.5.5
Date: Sun, 13 Apr 2008 15:14:18 +0200
Message-ID: <045D6694-CF38-4AED-9AB4-653189E0B042@zib.de>
References: <7vtzibbjxn.fsf@gitster.siamese.dyndns.org>
Reply-To: prohaska@zib.de
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: msysGit <msysgit@googlegroups.com>, Git Mailing List <git@vger.kernel.org>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Sun Apr 13 15:14:21 2008
connect(): Connection refused
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from wr-out-0708.google.com ([64.233.184.241])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jl22G-0006zK-Ht
	for gcvm-msysgit@m.gmane.org; Sun, 13 Apr 2008 15:14:20 +0200
Received: by wr-out-0708.google.com with SMTP id 49so3072363wra.9
        for <gcvm-msysgit@m.gmane.org>; Sun, 13 Apr 2008 06:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to:received:received:received-spf:authentication-results:received:received:from:to:in-reply-to:subject:references:message-id:content-type:content-transfer-encoding:mime-version:date:cc:x-mailer:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        bh=plhK+OjxLYF22pDLlITSzhrGIv7Hv380oLg2u9zwj/8=;
        b=oKbNOG1ZxqSHk8KxY1SPL64s6IW7Gvc7KN11CVgv1GGu2mCg5Ky+FF/QkZ+S7WrPMC79hNH/07eXrN0xS1cfShaM8E0RCe0YE8Y9tlxEeYPbEbekSb1nKiDuVgV5XYP0JaPF0CVtKBiePP6MNn2U52COdmh4N5sENZ39IgQbOD8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results:from:to:in-reply-to:subject:references:message-id:content-type:content-transfer-encoding:mime-version:date:cc:x-mailer:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        b=2TOlL4SU+sfIif17590Ej6olS9Y22phKy/hOP8qY+nuilvrUHfNOgno/tvDLV5u6M7I7EF0thQvi4WEvsg9ni9/g+7VZZ9xVoo3dgoEEMB0tNhL9GJ0gWtYj1V/6VhibKJZpWgDtid4iRvSKjgRYxcz2gAuOJU0FCvZcuD9hrJk=
Received: by 10.100.239.11 with SMTP id m11mr340599anh.14.1208092414881;
        Sun, 13 Apr 2008 06:13:34 -0700 (PDT)
Received: by 10.44.190.49 with SMTP id n49gr2093hsf.0;
	Sun, 13 Apr 2008 06:13:34 -0700 (PDT)
X-Sender: prohaska@zib.de
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.35.39.1 with SMTP id r1mr7810162pyj.4.1208092413423; Sun, 13 Apr 2008 06:13:33 -0700 (PDT)
Received: from mailer.zib.de (mailer.zib.de [130.73.108.11]) by mx.google.com with ESMTP id z53si2543479pyg.1.2008.04.13.06.13.32; Sun, 13 Apr 2008 06:13:33 -0700 (PDT)
Received-SPF: pass (google.com: best guess record for domain of prohaska@zib.de designates 130.73.108.11 as permitted sender) client-ip=130.73.108.11;
Authentication-Results: mx.google.com; spf=pass (google.com: best guess record for domain of prohaska@zib.de designates 130.73.108.11 as permitted sender) smtp.mail=prohaska@zib.de
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31]) by mailer.zib.de (8.14.2/8.14.2) with ESMTP id m3DDDVqV003355; Sun, 13 Apr 2008 15:13:31 +0200 (CEST)
Received: from [192.168.178.21] (brln-4db83461.pool.einsundeins.de [77.184.52.97]) (authenticated bits=0) by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m3DDDTg7015544 (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO); Sun, 13 Apr 2008 15:13:30 +0200 (MEST)
In-Reply-To: <7vtzibbjxn.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.919.2)
Sender: msysgit@googlegroups.com
Precedence: bulk
X-Google-Loop: groups
Mailing-List: list msysgit@googlegroups.com;
	contact msysgit-owner@googlegroups.com
List-Id: <msysgit.googlegroups.com>
List-Post: <mailto:msysgit@googlegroups.com>
List-Help: <mailto:msysgit-help@googlegroups.com>
List-Unsubscribe: <http://googlegroups.com/group/msysgit/subscribe>,
	<mailto:msysgit-unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79406>



On Apr 9, 2008, at 8:51 AM, Junio C Hamano wrote:

> The latest feature release GIT 1.5.5 is available at the usual
> places:

The msysgit setup is now available at:

  http://code.google.com/p/msysgit/downloads/

	Steffen
