From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [BUG] Highly inconsistent diff UI
Date: Thu, 25 Apr 2013 16:21:45 -0700
Message-ID: <20130425232145.GM29963@google.com>
References: <7va9ong9oa.fsf@alter.siamese.dyndns.org>
 <CALkWK0mVDT5ESnVJAWQ83gQnmxmGDoM_Y0nE4FGybcjcenA_KA@mail.gmail.com>
 <7v38ufer2x.fsf@alter.siamese.dyndns.org>
 <CALkWK0m5Q_e3q6Yg94-K+jU_SS7ovR2wnz-_Nr3cMz_YM=SMDQ@mail.gmail.com>
 <CALkWK0=5tE0pXj-XTe4g9LdCO78yrPNwyom5fupF1WTToY2TZw@mail.gmail.com>
 <877gjrpsk4.fsf@hexa.v.cablecom.net>
 <CALkWK0kn7mEosWSdWs1Jjx-L32wmL51W=X7ny9BYQMttG1LPvQ@mail.gmail.com>
 <87li87awwc.fsf@linux-k42r.v.cablecom.net>
 <7va9om5zxu.fsf@alter.siamese.dyndns.org>
 <CALkWK0mMvUXnMDY87h3US0gRuM44ADEYXPh+JVP23Ja1=yz=VQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@inf.ethz.ch>, Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 26 01:21:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVVUB-0003zs-EA
	for gcvg-git-2@plane.gmane.org; Fri, 26 Apr 2013 01:21:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759699Ab3DYXVv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Apr 2013 19:21:51 -0400
Received: from mail-pd0-f179.google.com ([209.85.192.179]:65367 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758187Ab3DYXVu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Apr 2013 19:21:50 -0400
Received: by mail-pd0-f179.google.com with SMTP id x11so2081419pdj.38
        for <git@vger.kernel.org>; Thu, 25 Apr 2013 16:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=I4qBNbPaVbB2piI8A3MH9bI6hI6Ed2hziDnWHGwc8IU=;
        b=spgn7z4SsgubiMraGG9pamfR3WQP3i80otU4TGn+HYEL5Uc4ImfbnrEOObMZiNR3iF
         vQlh1FdcpxhhSEpllwg4UI8gPWisbgrtZDN86VhG5ikaKxf7lBrc+tjvWBSv/4Mz2zHd
         g7xDB3WiRDeeNkwKyzd7vhAzxGYbou84hCPzuQ2MJG2S1UEIPjeoGobev6tWnYlGK6UB
         GWfiAZvEqYZSDGcIaH0zZ28uE13LFnCDSPxot4hc6ctR8Q/KUaREOyeMDlA0bYKkuvN5
         smhyckporBg6qBZdE9BOd95kajPU/JmMuYMQvtul+lwTEn7rD28yXHouxB2opnolEeBI
         ShiQ==
X-Received: by 10.66.19.170 with SMTP id g10mr27378725pae.199.1366932110106;
        Thu, 25 Apr 2013 16:21:50 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id bs3sm8991090pbb.36.2013.04.25.16.21.47
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 25 Apr 2013 16:21:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CALkWK0mMvUXnMDY87h3US0gRuM44ADEYXPh+JVP23Ja1=yz=VQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222463>

Ramkumar Ramachandra wrote:

> I thought ^@ was invented for scripting, but can't imagine a usecase for ^!.

I use "git diff $commit^!" from time to time to get the diff between a
merge and its first parent.

For comparison, I haven't found ^@ or "git log $commit^!" useful.  The
commit introducing the former says

| I needed it to do the multi-tree diff on Len's infamous 12-way
| Octopus; typing "diff --cc funmerge funmerge^1 funmerge^2 funmerge^3
| ..." was too painful.

which is spelled as "git show --cc funmerge" these days.
