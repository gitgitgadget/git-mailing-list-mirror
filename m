From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [PATCH/RFC v2 1/4] Add "core.eolStyle" variable to control
 end-of-line conversion
Date: Mon, 10 May 2010 11:16:07 +0400
Message-ID: <20100510071607.GC14069@dpotapov.dyndns.org>
References: <cover.1273352819.git.eyvind.bernhardsen@gmail.com>
 <c8ef28b72709013f17e093954a0f4e2ad1fb9652.1273352819.git.eyvind.bernhardsen@gmail.com>
 <alpine.LFD.2.00.1005081455450.3711@i5.linux-foundation.org>
 <E2A9C4D2-010F-44B2-BF6A-627DE8B72FB5@gmail.com>
 <BFFD3CAC-E7D9-49D8-9B67-C3F5157646F3@gmail.com>
 <20100509070043.GB14069@dpotapov.dyndns.org>
 <o2h600158c31005090030uba3686e3v8bfe0be02bf2283d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	mat <matthieu.stigler@gmail.com>,
	Erik Faye-Lund <kusmabite@googlemail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	Robert Buck <buck.robert.j@gmail.com>,
	Finn Arne Gangstad <finnag@pvv.org>
To: hasen j <hasan.aljudy@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 10 09:16:22 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OBNDw-0002Ey-EF
	for gcvg-git-2@lo.gmane.org; Mon, 10 May 2010 09:16:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755335Ab0EJHQN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 May 2010 03:16:13 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:36512 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753916Ab0EJHQM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 May 2010 03:16:12 -0400
Received: by fxm10 with SMTP id 10so2038667fxm.19
        for <git@vger.kernel.org>; Mon, 10 May 2010 00:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=/JDRvEj+dYFwnQ7N4lz+hOZDQZfNXEWzP+9DMfHUwGc=;
        b=jX9Yz9kaAs8G1r8xHjV47n68oJP9ERIt6UI1dRGMHgJBM22NE+W9zLcH2kqqp/J8ZJ
         s0g0e9xwOjii1KeZDRfdYyl8QxImyhhN+kpm5xOAZovk/x8UuCmlnxMAs54lU4x5uXdk
         UWSP8AFXgwvoLW4IvLaq/OBH3DlUFv+rZ8qew=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=gcvwJdE8FTJWDX8eTf6Rh7Zdtwo5xws0tklsgjYaHpShjO2c4ShCsQka8qyMUNbHLP
         imlhKibh8crVDVyXoM1bsj7paLq3+Onk6kTkJ5CsGUM7mjan9/ipfmihQr0/C1lnM2nR
         u819JmKT7O770RcJS5X7fB646e3fcUZTbkynA=
Received: by 10.223.98.24 with SMTP id o24mr3847649fan.29.1273475770758;
        Mon, 10 May 2010 00:16:10 -0700 (PDT)
Received: from localhost (ppp91-76-18-177.pppoe.mtu-net.ru [91.76.18.177])
        by mx.google.com with ESMTPS id 2sm20171610fav.1.2010.05.10.00.16.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 10 May 2010 00:16:09 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <o2h600158c31005090030uba3686e3v8bfe0be02bf2283d@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146766>

On Sun, May 09, 2010 at 01:30:10AM -0600, hasen j wrote:
> On 9 May 2010 01:00, Dmitry Potapov <dpotapov@gmail.com> wrote:
> > [...] Also,
> > I would rather call default as "default" instead of "native". So,
> > why not use "core.crlf={true, false, default}"?
> 
> default and native have completely different connotations. default
> makes me think "one of true or false, which ever happens to be the
> default". native is a better fit here.

but indeed core.crlf=default means that it is either true or false
whatever happened the system default, as well as "default" means the
same as if it would be if it is not specified at all.  If it were
eol=native, it would be okay, but crlf=native looks strange to me.


Dmitry
