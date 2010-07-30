From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Git CVS Import Questions
Date: Fri, 30 Jul 2010 15:17:06 -0500
Message-ID: <20100730201706.GC2448@burratino>
References: <AANLkTin_d_wKxyJDMbjz4vFacr6GNYzE_aUGi2vbXW3V@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Samir Faci <samir@esamir.com>
X-From: git-owner@vger.kernel.org Fri Jul 30 22:18:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oew2J-0002yg-2k
	for gcvg-git-2@lo.gmane.org; Fri, 30 Jul 2010 22:18:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760716Ab0G3USY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 30 Jul 2010 16:18:24 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:34719 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754693Ab0G3USX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jul 2010 16:18:23 -0400
Received: by qyk7 with SMTP id 7so4169604qyk.19
        for <git@vger.kernel.org>; Fri, 30 Jul 2010 13:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=oJ+bYsiK+eYz4bOOM/gRf8pwyX7/0yhHQgPy0JmJTMs=;
        b=Rh0aoyArZLSz96QhxnwMggYANJ7VlWxdvmOd/wNEWevGvfRTtm/9K0BcsA502Jj6xs
         lbCt6JL0gqmzZ4lugHBUhqwtpOVt1qHhBaOmGCocsI63qdco3F8xNfJjk6ksouM9VD+3
         OE3vSoRNbez+QeriKMcOsH7uo2zeAhLexfM+s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=dHXIZsvjfsEFwyoG9tqLGH58Z8eBnBFi5d8dU8ctqqtD/noVNVtXDzC59bwoCLM880
         hCaPXLTQ3xzNrYjQAeO3kK6tQhdQji6T55s1adxes5byCBeU2ykvbj0nNvQgUvtebAUS
         Fc0Lfn9zgeordL/0JDeBrC+URmBK8IyE1lxl4=
Received: by 10.224.66.130 with SMTP id n2mr327539qai.334.1280521101958;
        Fri, 30 Jul 2010 13:18:21 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id g33sm3016135qcq.28.2010.07.30.13.18.20
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 30 Jul 2010 13:18:21 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTin_d_wKxyJDMbjz4vFacr6GNYzE_aUGi2vbXW3V@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152264>

Hi Samir,

Samir Faci wrote:

> mkdir bar; git cvsimport -v Foo/Bar   which checks out the history of
> module Bar into the current directory (in this case bar)
>=20
> now... if I do this again in another directory
>=20
> mkdir bar2; git cvsimport -v Foo/Bar  which repeats the same process
> the hashes don't match up.

Maybe the dates are different?  I would suggest comparing the result of
=E2=80=9Cgit fast-export HEAD=E2=80=9D from each.

> Now, correct me if I'm wrong.. but I thought the hashes were generate=
d
> based on the content of the diff.

Close, but not quite.  This might help: http://progit.org/book/ch9-2.ht=
ml

Have fun,
Jonathan
