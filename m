From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [OT] Re: C++ *for Git*
Date: Sun, 23 Sep 2007 16:45:58 +0200
Message-ID: <e5bfff550709230745m43ad32dh261edc6fc846602a@mail.gmail.com>
References: <ABE0ABE82AE84593A2B71B0281F4C814@ntdev.corp.microsoft.com>
	 <46F55E03.2040404@krose.org>
	 <5e4707340709221550o6d0a6062qd51c16a278727c29@mail.gmail.com>
	 <20070923020951.GF24423@planck.djpig.de>
	 <20070923062527.GA8979@old.davidb.org> <851wcpsv4z.fsf@lola.goethe.zz>
	 <e5bfff550709230229t79004ce2j5ce8c2ae7744a7f2@mail.gmail.com>
	 <20070923104525.GC7118@artemis.corp>
	 <e5bfff550709230642v7fa5e837s7a5b9082b043672d@mail.gmail.com>
	 <alpine.LFD.0.9999.0709231018450.32185@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Pierre Habouzit" <madcoder@debian.org>,
	"David Kastrup" <dak@gnu.org>,
	"Frank Lichtenheld" <frank@lichtenheld.de>,
	"Alex Unleashed" <alex@flawedcode.org>,
	"Kyle Rose" <krose@krose.org>, "Miles Bader" <miles@gnu.org>,
	"Dmitry Kakurin" <dmitry.kakurin@gmail.com>,
	Git <git@vger.kernel.org>
To: "Nicolas Pitre" <nico@cam.org>
X-From: git-owner@vger.kernel.org Sun Sep 23 16:46:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IZSil-0008Uv-KC
	for gcvg-git-2@gmane.org; Sun, 23 Sep 2007 16:46:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754128AbXIWOqA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Sep 2007 10:46:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754099AbXIWOqA
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Sep 2007 10:46:00 -0400
Received: from rv-out-0910.google.com ([209.85.198.184]:28575 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754084AbXIWOp7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Sep 2007 10:45:59 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1188426rvb
        for <git@vger.kernel.org>; Sun, 23 Sep 2007 07:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=CfcVA4TljF1+IX5G87qK6BiNbzu/gWLGLO3M6nWmj40=;
        b=WlPhOIpxZ9toOZlpmbCygGm0u/67DguCwfh2Mw0lnty9z3j2WiT4kVHk/++TZRM3c3ZVA87wupne8DYHK2kaEx6iDPsNBs8eS4FIcnGY/Tn0FbqVL78Jbq3505yLFJylD4ZkGlYiH+bNpjxYLgDXqCQXHR2T/IukRNf+kligtYU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GvNt5jhribhh80yEf9QTkcAr+emz/HxZsSRbGZGXB4ECoRjqaEepV07pKqTd4hgsrP0Ev0cMatA6zxQY7a7wxwNQvMqIvj819w5FCeSgUxaeYK0/Gv4ie8/lGnQqJx984AnrgM9E9CLZW5lhGWwcjHI/FuTuZzEgDFrg/TDuE5s=
Received: by 10.140.201.1 with SMTP id y1mr1215015rvf.1190558759053;
        Sun, 23 Sep 2007 07:45:59 -0700 (PDT)
Received: by 10.140.185.19 with HTTP; Sun, 23 Sep 2007 07:45:58 -0700 (PDT)
In-Reply-To: <alpine.LFD.0.9999.0709231018450.32185@xanadu.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58967>

On 9/23/07, Nicolas Pitre <nico@cam.org> wrote:
> You must have misunderstood.  Why?  The linux kernel is itself very
> heavily "object oriented" already, even if it is written in C.  You
> don't need C++ for that.
>

Yes it's true, you don't need it. Object oriented in C is achived
using function pointers.

In C you fill a struct of function pointers with proper values instead
of inherithing from an (abstract) base class as you would do in C++.
The results are more or less the same modulo some type safe.


Marco
