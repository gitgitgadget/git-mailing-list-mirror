From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 1/2] sh-setup: Write a new require_clean_work_tree
 function
Date: Fri, 1 Oct 2010 13:28:52 -0500
Message-ID: <20101001182852.GA18692@burratino>
References: <1285877017-8060-1-git-send-email-artagnon@gmail.com>
 <1285877017-8060-2-git-send-email-artagnon@gmail.com>
 <7v4od7hsqt.fsf@alter.siamese.dyndns.org>
 <20101001045713.GE20098@kytes>
 <20101001053721.GB6184@burratino>
 <20101001072149.GA24171@kytes>
 <20101001074039.GC6184@burratino>
 <20101001125604.GA20713@kytes>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Joshua Jensen <jjensen@workspacewhiz.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 01 20:32:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P1kP0-0004Lt-4F
	for gcvg-git-2@lo.gmane.org; Fri, 01 Oct 2010 20:32:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754595Ab0JAScK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Oct 2010 14:32:10 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:61371 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754559Ab0JAScH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Oct 2010 14:32:07 -0400
Received: by wwj40 with SMTP id 40so1716649wwj.1
        for <git@vger.kernel.org>; Fri, 01 Oct 2010 11:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=uyruLx9d4InWxIkWrOdZAuuiJ+5tCVwzWaAqNbkHbDU=;
        b=IkchNxJ4mcAtvyl2XwD6e8KSlZ+qhDXVxB9m3L527R53PQpjecVCG6WaWv0+tGdU5Y
         4i6Tj64eJpmMY8oj9p48WwIuQxzHt3t7NiwBYIMJCjegj7uxkFN+e8BFf2O/KqVGI6FQ
         UaB5k7CfM8zrbZPyu/jJlfokUhf+ZeY2g/hvI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=v/xlWG2OiMzQze8nrnyMeeK3cWFbiIXkzv24wRZWbNnAspn9uD9dDjF51pe08z21dh
         DdGplbmPD9ashmP516AN73RdApO05HQTKUGyQlBm59WkYpMzJKL18IJDnQ5JGajBcwhr
         jQEPXx/CCoA3GFmlQ373ohz2yI47WnOa1E8rs=
Received: by 10.227.152.71 with SMTP id f7mr5283459wbw.17.1285957925035;
        Fri, 01 Oct 2010 11:32:05 -0700 (PDT)
Received: from burratino ([68.255.106.176])
        by mx.google.com with ESMTPS id fz1sm1301890wbb.0.2010.10.01.11.32.01
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 01 Oct 2010 11:32:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20101001125604.GA20713@kytes>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157771>

Ramkumar Ramachandra wrote:

> How about this then?
[...]
> +You can also create your own tag or use one that's in common usage
> +such as "Thanks-to:", "Based-on-patch-by:", or "Mentored-by:".

I like it.
