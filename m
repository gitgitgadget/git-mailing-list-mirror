From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: git_inetd_server: run git-http-backend using inetd
Date: Sat, 19 Jul 2014 10:06:23 -0700
Message-ID: <20140719170623.GA29072@google.com>
References: <43923BC7-08AF-4900-AC5E-B2F0FE7CD5AC@gmail.com>
 <20140717221056.GO12427@google.com>
 <53CA0E59.5030103@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Kyle J. McKay" <mackyle@gmail.com>,
	Git mailing list <git@vger.kernel.org>
To: Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sat Jul 19 19:06:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X8Y5o-0007RW-4Y
	for gcvg-git-2@plane.gmane.org; Sat, 19 Jul 2014 19:06:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932153AbaGSRGb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Jul 2014 13:06:31 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:57285 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752804AbaGSRGa (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Jul 2014 13:06:30 -0400
Received: by mail-pa0-f41.google.com with SMTP id rd3so6720832pab.14
        for <git@vger.kernel.org>; Sat, 19 Jul 2014 10:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=v+qpEBxfc++cCBYnR7EBn4uYrfl31Jl50P6Cp9Inerk=;
        b=neaQNQpMaWRRZE8z8RRuKrDlSiSA0proGE8khojXye091C3Hmf4PicwNmUp2GKkn3B
         hscW5K+8aYaYnuPv2lmqkHze/4Ba8Iy9EkI7zSYWg58Y7fNG4VqDfZfTBlvqmjsJ3zD+
         I2GUyzbo9UxiIfePIGOtINIRTjaoKZzVj4Gr/TLIuTdI1AUvT3WGzFz1rxvB3EeQkdUr
         i1+WQvGEbd3etfz0P1gUSDD1cUuUR3keirrVdDMKwP6ZAbDr/u62LEUZO6bktmRvmiI6
         ElRKbSGBNJkuiLPbeAj/5FSOquk1VIzFte1V89gN+AJwRgeYFMGztDxXEiV++lwTf+fF
         5HPg==
X-Received: by 10.66.118.71 with SMTP id kk7mr4473pab.147.1405789589937;
        Sat, 19 Jul 2014 10:06:29 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:5497:c624:18b:7b6c])
        by mx.google.com with ESMTPSA id k8sm9067192pbq.94.2014.07.19.10.06.28
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 19 Jul 2014 10:06:29 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <53CA0E59.5030103@web.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253898>

Torsten B=F6gershausen wrote:

> Jonathan, (I'm good in searching, but bad in finding)
> could you point out where the source code for the git package for
> debian is ?
>
> I recently learned about mDNS, and will probably do some tests
> and experiments later, and would like to test the lookup feature
> of "0010".

Thanks.  It's at git://git.debian.org/~jrnieder-guest/git branch
release+patches and mirrored at http://repo.or.cz/r/git/debian
