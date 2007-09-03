From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [StGIT PATCH 4/4] Add optional logging of subprocess execution
Date: Mon, 3 Sep 2007 09:36:26 +0100
Message-ID: <b0943d9e0709030136y4f1f241cge28fb9607ec559c1@mail.gmail.com>
References: <20070826202724.16265.85821.stgit@yoghurt>
	 <20070826203344.16265.66280.stgit@yoghurt>
	 <b0943d9e0708290350rbadfe08g9bbab7888723980e@mail.gmail.com>
	 <20070829111102.GA29980@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Mon Sep 03 10:36:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IS7Q8-0003qC-Ib
	for gcvg-git@gmane.org; Mon, 03 Sep 2007 10:36:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751939AbXICIg1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 3 Sep 2007 04:36:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752537AbXICIg1
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Sep 2007 04:36:27 -0400
Received: from rv-out-0910.google.com ([209.85.198.185]:13195 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750758AbXICIg1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Sep 2007 04:36:27 -0400
Received: by rv-out-0910.google.com with SMTP id k20so907453rvb
        for <git@vger.kernel.org>; Mon, 03 Sep 2007 01:36:26 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Qbuv/3oKukNVlsiSDj+EfZJKifbFMNBqO33Bft93oe6M9IkzIGqyZ2RKgIAqsrp2Yj3X87xrNQEU3qNrMRuvnW8+Cp51L/UjnEsNLcfoflKbydTXdFB30lFiKefYFoTGrG7rWl/fLLy8lExIejnjUnKwmIyy5SouXLPMCozlwIA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ddg8gHtCnvgnlNpA4Vhzgfk6ns03cSeUrUR6VcjG/HJC2DyQCY54KTRkMeLuyXnToAd1/NTebtt0nX0Ncz7Dqco6S8MN420fdpb2VxZr++cGGXyREEdXgJfLfT8OMlRNMx6KuLM3mfYn4W2HG3NJIhzay2mTiDm0p0GdJjAocMM=
Received: by 10.141.169.9 with SMTP id w9mr1868391rvo.1188808586646;
        Mon, 03 Sep 2007 01:36:26 -0700 (PDT)
Received: by 10.140.187.15 with HTTP; Mon, 3 Sep 2007 01:36:26 -0700 (PDT)
In-Reply-To: <20070829111102.GA29980@diana.vm.bytemark.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57447>

On 29/08/07, Karl Hasselstr=F6m <kha@treskal.com> wrote:
> Any chance we can drop Python 2.3 support any time soon, by the way?
> I've confined all the ickyness to one place, but it would still be
> good to get rid of it (not to mention being able to use sets and
> generator expressions).

Unless there is no objection, I'm actually OK with this. Feel free to
break the 2.3 support from now on. I'll add a note stating the minimum
versions for Python and GIT in the 0.14 release.

--=20
Catalin
