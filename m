From: "fkater@googlemail.com" <fkater@googlemail.com>
Subject: merge only some of the changed files?
Date: Fri, 19 Mar 2010 14:40:28 +0100
Message-ID: <20100319134028.GA2318@comppasch2>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 19 14:41:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NscRw-0008B0-KO
	for gcvg-git-2@lo.gmane.org; Fri, 19 Mar 2010 14:41:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752215Ab0CSNk6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Mar 2010 09:40:58 -0400
Received: from mail-fx0-f219.google.com ([209.85.220.219]:57993 "EHLO
	mail-fx0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751552Ab0CSNk5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Mar 2010 09:40:57 -0400
Received: by fxm19 with SMTP id 19so597255fxm.21
        for <git@vger.kernel.org>; Fri, 19 Mar 2010 06:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:subject
         :message-id:mime-version:content-type:content-disposition:user-agent;
        bh=a2VpTG/bO0lYvTvtK5e9d4w8UL1uzcxwEEjGYPqBN5M=;
        b=LRrcnkmvoGW8W8LM/ZSOD+mi1M4Idm8w2fOgrE7hrrnXnzVGT4XUDW/DIjFQUU1o2/
         sL2GcyQbon4ILbIlgWBVPDE4pnH/PBAFXjY3FI4MZ0wZVxdX4t7d70SWtKoi3GQu2VtB
         +szflR/MjY27oMqxMSJw+wieSPR+23xv5bgdI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=date:from:to:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        b=fR/kVUTntgcbFXlDQHvkvt16yX+phCCAV0F+p/zh0TLh/YPHlnxxfU4MtnNozMjuel
         CtBB312CG7dn/GjRzMfqKejY1AVXyXDJNW5UeL1qjxC+28pM10yvjvFbXcSn7xHyAft2
         b1mVGFGJmCyZVHj76gKyfooBAjtFjtXkVlNbo=
Received: by 10.87.2.15 with SMTP id e15mr8028048fgi.22.1269006056274;
        Fri, 19 Mar 2010 06:40:56 -0700 (PDT)
Received: from googlemail.com (port-87-193-148-114.static.qsc.de [87.193.148.114])
        by mx.google.com with ESMTPS id 15sm923023fxm.12.2010.03.19.06.40.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 19 Mar 2010 06:40:55 -0700 (PDT)
Received: by googlemail.com (nbSMTP-1.00) for uid 1100
	(using TLSv1/SSLv3 with cipher RC4-MD5 (128/128 bits))
	fkater@googlemail.com; Fri, 19 Mar 2010 14:40:29 +0100 (CET)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142591>

Hi all,

I am quite new to git.

If I want to merge branch B into A, however not all of the
changed files in B, how do I do that?

In other words: 'git diff --name-only A..B' lists 10 files
but I want to merge only 5 of them.

Thank You
 Felix
