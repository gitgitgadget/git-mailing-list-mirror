From: Pavel Roskin <proski-mXXj517/zsQ@public.gmane.org>
Subject: Re: linux-firmware binary corruption with gitweb
Date: Thu, 05 Mar 2009 12:26:21 -0500
Message-ID: <1236273981.24072.16.camel@mj>
References: <49A98F6A.50702@gmail.com> <1235886467.3195.15.camel@mj>
	<49AD7E2B.3010101@gmail.com> <m3iqmqt9ox.fsf@localhost.localdomain>
	<49AF1429.9080009@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: orinoco-users-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	John 'Warthog9' Hawley <warthog9-a9bfEDSFcqP30BxdvE/MCQ@public.gmane.org>,
	dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jakub Narebski <jnareb-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Dave <kilroyd-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
X-From: orinoco-users-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org Thu Mar 05 18:28:06 2009
Return-path: <orinoco-users-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Envelope-to: gldou-orinoco-users@m.gmane.org
Received: from lists.sourceforge.net ([216.34.181.88])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfHMb-0006Zg-5u
	for gldou-orinoco-users@m.gmane.org; Thu, 05 Mar 2009 18:28:05 +0100
Received: from localhost ([127.0.0.1] helo=sfs-ml-2.v29.ch3.sourceforge.com)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <orinoco-users-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>)
	id 1LfHLB-0000gA-Nb; Thu, 05 Mar 2009 17:26:37 +0000
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <proski-mXXj517/zsQ@public.gmane.org>) id 1LfHLA-0000fy-Qk
	for orinoco-users-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org; Thu, 05 Mar 2009 17:26:36 +0000
Received-SPF: softfail (72vjzd1.ch3.sourceforge.com: transitioning domain of
	gnu.org does not designate 216.154.195.49 as permitted sender)
	client-ip=216.154.195.49; envelope-from=proski-mXXj517/zsQ@public.gmane.org;
	helo=c60.cesmail.net; 
Received: from c60.cesmail.net ([216.154.195.49])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.69) id 1LfHKy-0008Vq-EP
	for orinoco-users-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org; Thu, 05 Mar 2009 17:26:36 +0000
Received: from unknown (HELO smtprelay2.cesmail.net) ([192.168.1.112])
	by c60.cesmail.net with ESMTP; 05 Mar 2009 12:26:23 -0500
Received: from [192.168.0.22] (static-72-92-88-10.phlapa.fios.verizon.net
	[72.92.88.10])
	by smtprelay2.cesmail.net (Postfix) with ESMTPSA id C4C6A34C6A;
	Thu,  5 Mar 2009 12:25:46 -0500 (EST)
In-Reply-To: <49AF1429.9080009-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
X-Mailer: Evolution 2.24.5 (2.24.5-1.fc10) 
X-Spam-Score: -0.3 (/)
X-Spam-Report: Spam Filtering performed by mx.sourceforge.net.
	See http://spamassassin.org/tag/ for more details.
	-1.0 RCVD_IN_DNSWL_LOW RBL: Sender listed at http://www.dnswl.org/,
	low trust [216.154.195.49 listed in list.dnswl.org]
	0.7 SPF_SOFTFAIL SPF: sender does not match SPF record (softfail)
X-Headers-End: 1LfHKy-0008Vq-EP
X-BeenThere: orinoco-users-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
X-Mailman-Version: 2.1.9
Precedence: list
List-Id: <orinoco-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/orinoco-users>, 
	<mailto:orinoco-users-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=orinoco-users>
List-Post: <mailto:orinoco-users-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:orinoco-users-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/orinoco-users>, 
	<mailto:orinoco-users-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: orinoco-users-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112322>

On Wed, 2009-03-04 at 23:52 +0000, Dave wrote:
>         binmode STDOUT, ':raw';
> -        print <$fd>;
> +        #print <$fd>;
> +        $output .= <$fd>;
>         binmode STDOUT, ':utf8'; # as set at the beginning of
> gitweb.cgi

Nice catch!

Looking at the gitweb repository from kernel.org, two instances of
circumventing binmode were introduced by this commit:

commit c79ae555fb3c89d91b4cafbfce306e695720507b
Author: John Hawley <warthog9-v8g9t7APwQevveQcA6InS3zaFgp7qdfK@public.gmane.org>
Date:   Thu Dec 28 21:59:43 2006 -0800

    Last of the changes to deal with channeling the text through the caching
    engine.  Wow is this a total hack.

The original behavior was restored in git_snapshot() by the recent
commit c15229acd9bedf165f1eb05d99fa989d3b9f3e32, but git_blob_plain()
remains broken.

I don't see an easy fix.  We cannot manipulate the blob to counteract
the encoding, as it may not be valid utf-8, and therefore won't be
output in the utf-8 mode.

Maybe binmode should be raw everywhere, and adding to $output should
recode data to utf-8 from other encodings where needed, but it would be
a massive patch, I'm afraid.  Or it would be a small patch requiring
massive testing.

Adding John Hawley to cc:

-- 
Regards,
Pavel Roskin

------------------------------------------------------------------------------
Open Source Business Conference (OSBC), March 24-25, 2009, San Francisco, CA
-OSBC tackles the biggest issue in open source: Open Sourcing the Enterprise
-Strategies to boost innovation and cut costs with open source participation
-Receive a $600 discount off the registration fee with the source code: SFAD
http://p.sf.net/sfu/XcvMzF8H
