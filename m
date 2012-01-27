From: David Barr <davidbarr@google.com>
Subject: Re: [PULL] svn-fe updates for master or next
Date: Fri, 27 Jan 2012 12:03:58 +1100
Message-ID: <CAFfmPPN-g+Lk2n9tzXe=CfyK8OZ7nGu4NwX0cXjtxS0W7SwPHA@mail.gmail.com>
References: <CAFfmPPMH2643JMMZdVbOQJL7DB-DiRYQS8x0TqEaSbGmhMdBNw@mail.gmail.com>
	<CALkWK0kMmDMZ4wiMSmOfwBLzd+xBEA+WKsviu9FVcvj9eZEahg@mail.gmail.com>
	<CAFfmPPOZfDdH+GF91Dxyy5yfX8TmGDmsbpHz=CVLcBY0c-pCsQ@mail.gmail.com>
	<CALkWK0nsO2EBLUrO_iWAdGYpULt=oug4yPDnczX9c44hzdwzqg@mail.gmail.com>
	<alpine.DEB.2.02.1201221310540.28747@asgard.lang.hm>
	<3BC64515-C4C0-4D32-97B0-8FFD14BB903C@silverinsanity.com>
	<CAP2yMaLHK2md=MHFmV--R6rmr4q3XuZxqsb2fUszMhssx3GDoA@mail.gmail.com>
	<CAFfmPPPvpbsYz9cjN6OspivCN3dbuPGOU7fyaVdnic3D4V855w@mail.gmail.com>
	<20120127001041.GB6158@burratino>
	<20120127003258.GA6946@burratino>
	<20120127004605.GA31538@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Scott Chacon <schacon@gmail.com>,
	Brian Gernhardt <benji@silverinsanity.com>, david@lang.hm,
	Ramkumar Ramachandra <artagnon@gmail.com>, git@vger.kernel.org,
	Dmitry Ivankov <divanorama@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 27 02:04:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RqaEX-0004ck-QI
	for gcvg-git-2@lo.gmane.org; Fri, 27 Jan 2012 02:04:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752773Ab2A0BEA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 26 Jan 2012 20:04:00 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:64964 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751377Ab2A0BD7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 Jan 2012 20:03:59 -0500
Received: by ggnb1 with SMTP id b1so593394ggn.19
        for <git@vger.kernel.org>; Thu, 26 Jan 2012 17:03:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:x-system-of-record:content-type:content-transfer-encoding;
        bh=eWdKeGaXjpdmm7XZYo4sf1kjLS+BE175XsL7uL4DFgI=;
        b=wCR77ajyPq9jA1UuwbWCwPDQGtokIGuQZyebkR2YFCE2ChVsS94DGcJLJq+JqGEYxA
         33HVCpQ5SyfNBQ9mBWQV2+EFNmdXnZbYJJZjz/kJdBSjpe3Nedpoy+OYkn+3FmG0jVLC
         CJ/LSlh3BcMtRKpGfLYVYdmUx2ds32StE7078=
Received: by 10.236.73.129 with SMTP id v1mr6979487yhd.129.1327626239013;
        Thu, 26 Jan 2012 17:03:59 -0800 (PST)
Received: by 10.236.73.129 with SMTP id v1mr6979465yhd.129.1327626238912; Thu,
 26 Jan 2012 17:03:58 -0800 (PST)
Received: by 10.101.144.22 with HTTP; Thu, 26 Jan 2012 17:03:58 -0800 (PST)
In-Reply-To: <20120127004605.GA31538@burratino>
X-System-Of-Record: true
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189183>

On Fri, Jan 27, 2012 at 11:46 AM, Jonathan Nieder <jrnieder@gmail.com> =
wrote:
> Jonathan Nieder wrote:
>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 It simplifies svn-fe a great
>> deal and fulfills a longstanding wish: support for dumps with deltas
>> in them.
>
> Oh, and incremental imports, too. ;-)

Thank you, Jonathan. I forgot our prior discussion about avoiding yet
another history rewrite. This provides a nice cut-point.
I do think we need to gather Dmitry's work on svn-fe and propose a
front-end for core so that it is no longer relegated to contrib.

--
David Barr.
