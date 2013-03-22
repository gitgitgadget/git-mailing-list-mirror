From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [BUG?] rebase -i: edit versus unmerged changes
Date: Fri, 22 Mar 2013 11:25:50 -0700
Message-ID: <20130322182550.GF12223@google.com>
References: <CALkWK0n=fb_kq+Ed3rd9MhQUCHY3+_nj=zw4M+GmjbzEO56SOg@mail.gmail.com>
 <CADeaMWoeRQBbrqLsfieKTE2rRbpzU-Hyp+mv-=CTj+=Znmf=Zw@mail.gmail.com>
 <CALkWK0mgX40oicqxnoa7M3NJP_k8jDrg7mVGyWrg5T+=iRtHQA@mail.gmail.com>
 <7vsj3pdcm5.fsf@alter.siamese.dyndns.org>
 <CALkWK0kHFHtsy1Eh+jnY-JNSDUYd2xtiavhPNjaT8H3mJvYZkA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Andrew Wong <andrew.kw.w@gmail.com>,
	Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 22 19:26:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJ6fX-00071j-2Z
	for gcvg-git-2@plane.gmane.org; Fri, 22 Mar 2013 19:26:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422749Ab3CVSZ4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Mar 2013 14:25:56 -0400
Received: from mail-pd0-f173.google.com ([209.85.192.173]:33472 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422655Ab3CVSZz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Mar 2013 14:25:55 -0400
Received: by mail-pd0-f173.google.com with SMTP id v10so1729869pde.18
        for <git@vger.kernel.org>; Fri, 22 Mar 2013 11:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=x0LjxW7/wNewORXUW1yeA3tzJ6337LV6iyiEeioEX+E=;
        b=sKpL2uCvP/8c1+i0r7Qzs3KqXPHC6eV6lJalBXn6PZ/IfWHq67mBk1x50UXSEPhKOF
         0+lof7+0d3NnEZU6g7o/we7VGQrQMJO82ew27ohsYA48Ma8VecWee92alnmNJHyRtBhH
         ZiGyxgGdvqcb1m+lygFNsPSW0RYoOLY3aLVpv6N9+yq/r/6EGCk2CyqqpS0vStTVCYYf
         L7cbCGECoChnnvnEoqcf8NKIHiVQ8ci36JGTUy98OfzGK6dbggoxvSAmJ9IV7O7CZNXA
         YoYl4XhxKqg1tYV1Szpa+2qcTZY7EoDcQ91O7MFLIekqfOAt964d5sMiUs2ghBjAZCQt
         hjgQ==
X-Received: by 10.68.213.231 with SMTP id nv7mr4291669pbc.85.1363976754734;
        Fri, 22 Mar 2013 11:25:54 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPS id kt5sm3208755pbc.30.2013.03.22.11.25.52
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 22 Mar 2013 11:25:53 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CALkWK0kHFHtsy1Eh+jnY-JNSDUYd2xtiavhPNjaT8H3mJvYZkA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218831>

Ramkumar Ramachandra wrote:

> I'd really to have that final 'git continue' in Git 2.0.  Can someone
> attempt to break up the migration path into manageable logical steps
> that we can start working on?

Is there any deadline or migration path needed?  Depending on the
design, it might be possible to do without backward-incompatible
changes, meaning the migration path is "whatever someone feels like
implementing first lands first".

Hope that helps,
Jonathan
