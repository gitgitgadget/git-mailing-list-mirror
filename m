From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Harmful LESS flags
Date: Fri, 25 Apr 2014 08:47:22 -0700
Message-ID: <20140425154722.GC11479@google.com>
References: <4dc69237123e8962b2b2b901692ea78e.id@mailtor>
 <87lhuvb9kr.fsf@fencepost.gnu.org>
 <xmqqha5iv9eb.fsf@gitster.dls.corp.google.com>
 <vpqfvl1rj7i.fsf@anie.imag.fr>
 <20140425151124.GA11479@google.com>
 <8761lxa0gs.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>, d9ba@mailtor.net,
	git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Fri Apr 25 17:47:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WdiLb-0001vW-5T
	for gcvg-git-2@plane.gmane.org; Fri, 25 Apr 2014 17:47:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751688AbaDYPr0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Apr 2014 11:47:26 -0400
Received: from mail-pd0-f175.google.com ([209.85.192.175]:48311 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751500AbaDYPrZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Apr 2014 11:47:25 -0400
Received: by mail-pd0-f175.google.com with SMTP id fp1so1121591pdb.20
        for <git@vger.kernel.org>; Fri, 25 Apr 2014 08:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=psBi1BSmuOQEgZZ1wIRTSDZQDm1kh7Yo1JSZ9Lwa5j4=;
        b=ircW+dtcd7Q3w2pbslxR5jDVvL37+Jz4FTGaIZg28/DY8WurDiKNMJDlvOmwsiLz9R
         ZPl5njTQUvoT8Cz6OgYtV/pBFe/1qBre/UKvFVyIJLGKGku0Syv4P5d48VKu0Ycia7WO
         ru2HJIX5Lv8LN2OCKm2XpR9v3Aj9h7l7ou/d9GwiDHYP020eDPjGqHlLdKUWT2Wh6Ykj
         FBs8C9f/Nbei+cv+pVmHj4XBTo53gWWXyWDyQw6nGIiBZNYKk/qDetVwTtbcZQDwOhLq
         YiSh7mVOKw/P0s/v7J/ZvAB7OTZYo7JJ2SF5o3ttywJz9RJaQbRspXLbpkOcVDVtqJuk
         UN0A==
X-Received: by 10.66.190.4 with SMTP id gm4mr8705764pac.116.1398440844957;
        Fri, 25 Apr 2014 08:47:24 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id et3sm16703555pbc.52.2014.04.25.08.47.23
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 25 Apr 2014 08:47:24 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <8761lxa0gs.fsf@fencepost.gnu.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247047>

David Kastrup wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>> Just for clarity: no, when we are talking about well formatted code,
>> -S is actually a way better interface.
>
> When we are talking about well-formatted code, -S does not matter either
> which way.

Sorry for the lack of clarity.  I believe well-formatted code can
contain long lines.  For example, sometimes a message + the printf to
print it and indentation move past the right margin.

If I wasn't talking about long lines, why would I have replied in the
first place?

[...]
> Overriding less' defaults should only be done for unequivocal benefits,

We agree here.  So, does someone who actually wants this change want to
propose a patch? :)

Hope that helps,
Jonathan
