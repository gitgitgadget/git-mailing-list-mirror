From: "=?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?=" 
	<pclouds@gmail.com>
Subject: Re: [RFC] adding support for md5
Date: Fri, 18 Aug 2006 16:59:38 +0700
Message-ID: <fcaeb9bf0608180259o21a3d482y71b50227bd070497@mail.gmail.com>
References: <Pine.LNX.4.63.0608172259280.25827@chino.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 18 12:00:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GE18r-0003rA-2R
	for gcvg-git@gmane.org; Fri, 18 Aug 2006 11:59:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751334AbWHRJ7u (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 Aug 2006 05:59:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751335AbWHRJ7u
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Aug 2006 05:59:50 -0400
Received: from wx-out-0506.google.com ([66.249.82.226]:54132 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751334AbWHRJ7t (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Aug 2006 05:59:49 -0400
Received: by wx-out-0506.google.com with SMTP id s14so640704wxc
        for <git@vger.kernel.org>; Fri, 18 Aug 2006 02:59:49 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=eoMhWo52Dl1CRqdvXpiHZ0YTzkWuiBz9D+rEQ5nIIbyFSW8VKdqHhGVd89rxD9QofTg42UTZBxi66r5SLA/Q5QLy9ZQ701tgMiVP50AxOQVpsAOatJe+VzujKVkGU0edzxegUoe08vEIxhATVO4S/p1Y7ElaASJdFFnrqGTmUCU=
Received: by 10.70.67.4 with SMTP id p4mr4443145wxa;
        Fri, 18 Aug 2006 02:59:49 -0700 (PDT)
Received: by 10.70.45.19 with HTTP; Fri, 18 Aug 2006 02:59:38 -0700 (PDT)
To: "David Rientjes" <rientjes@google.com>
In-Reply-To: <Pine.LNX.4.63.0608172259280.25827@chino.corp.google.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25642>

On 8/18/06, David Rientjes <rientjes@google.com> wrote:
> I'd like to solicit some comments about implementing support for md5 as a
> hash function that could be determined at runtime by the user during a
> project init-db.  md5, which I implemented as a configurable option in my
> own tree, is a 128-bit hash that is slightly more recognized than sha1.
> Likewise, it is also available in openssl/md5.h just as sha1 is available
> through a library in openssl/sha1.h.  My patch to move the hash name
> comparison was a step in this direction in isolating many of the
> particulars of hash-specific dependencies.
Just curious, but why md5? Is there any benefit using md5 over sha1?
