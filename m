From: Johan Herland <johan@herland.net>
Subject: Re: CPPCheck found 24 high risk bugs in Git v.1.8.3.4
Date: Mon, 19 Aug 2013 22:52:26 +0200
Message-ID: <CALKQrgcYtZ58JkSd-qMG9NWeLDaNAhBxXwUTNE8O1LvT+=TF6w@mail.gmail.com>
References: <85C8141E5DAD94428A121F706995A31F010F116FDAD3@MX1.net.tbe.com>
	<33FCCE7A2CD5494B88F3C5CDBC341DFD@PhilipOakley>
	<20130819204044.GA29258@sigill.intra.peff.net>
	<7vmwodl885.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.org>,
	"Koch, Rick (Subcontractor)" <Rick.Koch@tbe.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 19 22:52:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VBWRL-00062v-24
	for gcvg-git-2@plane.gmane.org; Mon, 19 Aug 2013 22:52:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750823Ab3HSUwf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Aug 2013 16:52:35 -0400
Received: from mail12.copyleft.no ([188.94.218.224]:60583 "EHLO
	mail12.copyleft.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750790Ab3HSUwe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Aug 2013 16:52:34 -0400
Received: from locusts.copyleft.no ([188.94.218.116] helo=mail.mailgateway.no)
	by mail12.copyleft.no with esmtp (Exim 4.76)
	(envelope-from <johan@herland.net>)
	id 1VBWRE-0004Rk-Dd
	for git@vger.kernel.org; Mon, 19 Aug 2013 22:52:32 +0200
Received: from mail-pd0-f176.google.com ([209.85.192.176])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1VBWRB-000Kjv-CE
	for git@vger.kernel.org; Mon, 19 Aug 2013 22:52:30 +0200
Received: by mail-pd0-f176.google.com with SMTP id q10so5686272pdj.7
        for <git@vger.kernel.org>; Mon, 19 Aug 2013 13:52:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=2Fq86vOe4KCVs5DSwnHKFrDWlu7b/om/bDuE5KzdrbA=;
        b=KSXhgO1moPNFmGni4+ERGHW40wEo1u+lHpEv1RHebtXvIQcwyhG8ByGeXlG4CJs5Tp
         oJbNBVVkz3pOmJdNrpYsJXHG7RP7/iZVPW+2bEX6Tpnrmi3bGJeRagdHRCyVQCnVdW6e
         37xk/frqYxUfuuG+Cdj+pCPMWGtqc+HSvzkuPqyLkhHgXYmcGVNP6qwfY6+ieZ6TuIiJ
         b3CIFC1U5Xvuu6RLB2oeRaw4x4IntsZAPcJ4MnZTVu57erVcPY35alSjINHpfHx/tyUH
         +n9xx4/Bfyd/WqBijUzf6L8EbiiW3tauQxBOjxQ9AXTghXfQBtVmshEoaErHX7QXohtr
         XdLQ==
X-Received: by 10.66.192.234 with SMTP id hj10mr3637376pac.183.1376945547017;
 Mon, 19 Aug 2013 13:52:27 -0700 (PDT)
Received: by 10.70.126.67 with HTTP; Mon, 19 Aug 2013 13:52:26 -0700 (PDT)
In-Reply-To: <7vmwodl885.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232565>

On Mon, Aug 19, 2013 at 10:46 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jeff King <peff@peff.net> writes:
>> On Mon, Aug 19, 2013 at 09:03:21PM +0100, Philip Oakley wrote:
>> So out of the 4 entries I investigated, none of them looks like an
>> actual problem. But I'm not even sure I am looking at the right place;
>> these don't even seem like things that would cause a false positive in a
>> static analyzer.
>
> And the ones I picked at random looks totally bogus, too.
>
>      uninitvar(CppCheck) \git-master\notes.c notes.c 805
>      uninitvar(CppCheck) \git-master\notes.c notes.c 805

FWIW, I looked at the 3 notes-related ones and reached the same conclusions.

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
