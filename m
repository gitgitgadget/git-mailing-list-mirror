From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [ANNOUNCE] GIT 1.5.6
Date: Sun, 22 Jun 2008 18:54:58 +0200
Message-ID: <2305738E-573B-4058-9327-B50B89FA7A96@zib.de>
References: <7vmylixr6h.fsf@gitster.siamese.dyndns.org>
Reply-To: prohaska@zib.de
Mime-Version: 1.0 (Apple Message framework v924)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>, msysGit <msysgit@googlegroups.com>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Sun Jun 22 18:55:54 2008
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from yw-out-2122.google.com ([74.125.46.27])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KASr3-0003UP-Nf
	for gcvm-msysgit@m.gmane.org; Sun, 22 Jun 2008 18:55:54 +0200
Received: by yw-out-2122.google.com with SMTP id 8so6922518yws.63
        for <gcvm-msysgit@m.gmane.org>; Sun, 22 Jun 2008 09:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received-spf:authentication-results:received
         :received:from:to:in-reply-to:subject:references:message-id
         :content-type:content-transfer-encoding:mime-version:date:cc
         :x-mailer:reply-to:sender:precedence:x-google-loop:mailing-list
         :list-id:list-post:list-help:list-unsubscribe:x-beenthere;
        bh=M2x1x3RVTwK3Nzul1XBpUOuHOZHMemQmBm+IcCLyrLo=;
        b=IRdasgm6r+VQg/6a1BLZhu8ISr8fzqmgO/oa4evthKgODLbjKC2pbierfzk676mM86
         iYTHjoNftJ4Sy77OqHovnhC2eiLmFK7sGynammOLroP2dMP5QQ5jry9Z4g/RICAlgPEx
         oziuYz3wDPt8OYwKpYBrJi2WYcoqhicc55B/c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results:from
         :to:in-reply-to:subject:references:message-id:content-type
         :content-transfer-encoding:mime-version:date:cc:x-mailer:reply-to
         :sender:precedence:x-google-loop:mailing-list:list-id:list-post
         :list-help:list-unsubscribe:x-beenthere;
        b=YWixGUGz0Ul/iceyemkXjrnbIjWuB8TelDMEzFjvTvdxRDGQHsd4mnT1xa2wu2L1B7
         okAeUZ4qN2oyaOxS4STrUwkYr7bEK3rS8IFW1+AFIhUAFQwpm2ezuG9Bguj6zOSfJIcd
         6yL5pFtZDojjMdwTD3YL9lXmrOB+8Z8jz9vpE=
Received: by 10.142.126.17 with SMTP id y17mr162397wfc.22.1214153696139;
        Sun, 22 Jun 2008 09:54:56 -0700 (PDT)
Received: by 10.107.113.4 with SMTP id q4gr2406prm.0;
	Sun, 22 Jun 2008 09:54:56 -0700 (PDT)
X-Sender: prohaska@zib.de
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.100.213.4 with SMTP id l4mr4722388ang.15.1214153695246; Sun, 22 Jun 2008 09:54:55 -0700 (PDT)
Received: from mailer.zib.de (mailer.zib.de [130.73.108.11]) by mx.google.com with ESMTP id 7si4463585yxg.1.2008.06.22.09.54.54; Sun, 22 Jun 2008 09:54:55 -0700 (PDT)
Received-SPF: pass (google.com: best guess record for domain of prohaska@zib.de designates 130.73.108.11 as permitted sender) client-ip=130.73.108.11;
Authentication-Results: mx.google.com; spf=pass (google.com: best guess record for domain of prohaska@zib.de designates 130.73.108.11 as permitted sender) smtp.mail=prohaska@zib.de
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31]) by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m5MGshkB006992; Sun, 22 Jun 2008 18:54:53 +0200 (CEST)
Received: from [192.168.178.21] (brln-4db83dcc.pool.einsundeins.de [77.184.61.204]) (authenticated bits=0) by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m5MGsVYW001106 (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO); Sun, 22 Jun 2008 18:54:35 +0200 (MEST)
In-Reply-To: <7vmylixr6h.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.924)
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
X-BeenThere: msysgit@googlegroups.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85787>



On Jun 19, 2008, at 1:24 AM, Junio C Hamano wrote:

> The latest feature release GIT 1.5.6 is available at the usual
> places:


The msysgit Windows installer is available at

    http://code.google.com/p/msysgit/downloads

	Steffen
