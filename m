From: Lea Wiemann <lewiemann@gmail.com>
Subject: Re: [PATCH] Avoid errors from git-rev-parse in gitweb blame
Date: Tue, 03 Jun 2008 16:24:51 +0200
Message-ID: <48455433.8080500@gmail.com>
References: <1212489977-26822-1-git-send-email-rgarciasuarez@gmail.com> <m34p8a2173.fsf@localhost.localdomain> <b77c1dce0806030503r55c95d73t5ff244821f76cf1@mail.gmail.com> <200806031445.23002.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Rafael Garcia-Suarez <rgarciasuarez@gmail.com>,
	git@vger.kernel.org, Luben Tuikov <ltuikov@yahoo.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 03 16:26:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3XSY-0002F3-Qm
	for gcvg-git-2@gmane.org; Tue, 03 Jun 2008 16:25:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753101AbYFCOYm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2008 10:24:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753077AbYFCOYm
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jun 2008 10:24:42 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:28169 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752686AbYFCOYl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2008 10:24:41 -0400
Received: by nf-out-0910.google.com with SMTP id d3so596032nfc.21
        for <git@vger.kernel.org>; Tue, 03 Jun 2008 07:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        bh=gXmigwujyLEx3NKufROX39yrlTgUt3YyUx68Amt1wgg=;
        b=gFy2IYy60HgTxzdu46ozWZ7Rq7B9ntR4GulVBLfwy0mXkm7ugOo5W0RwzKNAD1Bj6gGugFbWRojFplTORevgLBLuqFylIU2xxoZiqKnXLVM4RCvHwusg/ZG8woFiXZouroF+eqMqSLPqWeCP8KQI5OSO8QiFXTC8f4ObzqwxomA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=a4XX+WynmffXM3qF7e669o4MCItOizmsuzptantLl27+WluRgo/QIq/lkjlQqLsbkffGHMtf5jO6NfYlrEgIMErJZRKS1OscHApm58nnxnXmkVRHGPl1TYMh++znCM4mXtr/B7HZXVCFKo5ky+KD1TfDuwvHZn8J4nzuQsNxrCs=
Received: by 10.86.36.11 with SMTP id j11mr7425556fgj.7.1212503080418;
        Tue, 03 Jun 2008 07:24:40 -0700 (PDT)
Received: from ?172.16.30.128? ( [91.33.231.153])
        by mx.google.com with ESMTPS id 4sm52595fgg.9.2008.06.03.07.24.37
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 03 Jun 2008 07:24:40 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.14 (X11/20080421)
In-Reply-To: <200806031445.23002.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83665>

Jakub Narebski wrote:
> I was thinking about extending git-blame porcelain format (and also
> incremental format, of course) by 'parents' (and perhaps
> 'original-parents') header...

Regarding prettiness, I don't find parents in the porcelain output 
particularly useful, but if other people think they need this, I won't 
object. :)

Regarding performance, it would be good to show that the solution I'm 
suggesting in my separate is slower than extending git-blame before 
implementing anything.  (I doubt it matters performance-wise.)

-- Lea
