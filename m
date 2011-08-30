From: David Michael Barr <davidbarr@google.com>
Subject: Re: [PATCH 2/3] unpack-trees: allow pruning with pathspec
Date: Wed, 31 Aug 2011 01:24:06 +1000
Message-ID: <CAFfmPPO2xT7bc0EjQRDCxG3hNTBLYYEYe61kipcqtOiNbL8=hA@mail.gmail.com>
References: <7vty9054qr.fsf@alter.siamese.dyndns.org>
	<1314653603-7533-1-git-send-email-gitster@pobox.com>
	<1314653603-7533-3-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 30 17:24:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QyQAh-0005Vb-QY
	for gcvg-git-2@lo.gmane.org; Tue, 30 Aug 2011 17:24:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755176Ab1H3PYK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Aug 2011 11:24:10 -0400
Received: from smtp-out.google.com ([216.239.44.51]:61634 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755008Ab1H3PYJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Aug 2011 11:24:09 -0400
Received: from hpaq13.eem.corp.google.com (hpaq13.eem.corp.google.com [172.25.149.13])
	by smtp-out.google.com with ESMTP id p7UFO8Ie011681
	for <git@vger.kernel.org>; Tue, 30 Aug 2011 08:24:08 -0700
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=google.com; s=beta;
	t=1314717848; bh=Hl6+v50l1Hxb7b1H2F+jz60eNKM=;
	h=MIME-Version:In-Reply-To:References:Date:Message-ID:Subject:From:
	 To:Cc:Content-Type;
	b=mZdd/jGAPTJ8Fgi4f5CF2APfcSlKEkr57/93bObUOCWIFtQKOMhVTa7tL6+R67z1f
	 DdcvghwfkagcG5pzI7JuA==
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=dkim-signature:mime-version:in-reply-to:references:date:
	message-id:subject:from:to:cc:content-type:x-system-of-record;
	b=v30qe9O9aW+OKCxqFlygNRJnDwR0ZeahDGxaqrebug4Uzxc6JXlH35nOCZ6yhn82v
	K5IK0+d1JHfO4pAfjhe7A==
Received: from ywo7 (ywo7.prod.google.com [10.192.15.7])
	by hpaq13.eem.corp.google.com with ESMTP id p7UFO0Ec030289
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <git@vger.kernel.org>; Tue, 30 Aug 2011 08:24:07 -0700
Received: by ywo7 with SMTP id 7so13236428ywo.25
        for <git@vger.kernel.org>; Tue, 30 Aug 2011 08:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=beta;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=SG5xtNJltjZRREbL5NFOSssEee+ob+w2K6Ox07Y+VqE=;
        b=Oj909WcicP1qQsShrrsbw2l9gv++xZNWwrr3T4O1rUP/6qa3zQI384o4Yp7lXMgB7T
         Vj/fuK/ahULliJFXg95A==
Received: by 10.101.37.5 with SMTP id p5mr5298838anj.161.1314717846704;
        Tue, 30 Aug 2011 08:24:06 -0700 (PDT)
Received: by 10.101.37.5 with SMTP id p5mr5298828anj.161.1314717846560; Tue,
 30 Aug 2011 08:24:06 -0700 (PDT)
Received: by 10.100.106.5 with HTTP; Tue, 30 Aug 2011 08:24:06 -0700 (PDT)
In-Reply-To: <1314653603-7533-3-git-send-email-gitster@pobox.com>
X-System-Of-Record: true
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180412>

On Tue, Aug 30, 2011 at 7:33 AM, Junio C Hamano <gitster@pobox.com> wrote:
> while running a merge, but the caller in diff-lib.c::diff_cache() should
> be able to take advanrage of it.

s/advanrage/advantage/ :)

Nice little hot-fix too. I love the understatement, "moderate speed up."

--
David Barr
