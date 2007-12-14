From: Wolfram Gloger <wmglo@dent.med.uni-muenchen.de>
Subject: Re: Something is broken in repack
Date: 14 Dec 2007 16:18:58 -0000
Message-ID: <20071214161858.3506.qmail@md.dent.med.uni-muenchen.de>
References: <85d4tc8hi8.fsf@lola.goethe.zz>
Cc: nico@cam.org, jonsmirl@gmail.com, gitster@pobox.com, gcc@gcc.gnu.org,   git@vger.kernel.org
To: dak@gnu.org
X-From: gcc-return-142988-gcc=m.gmane.org@gcc.gnu.org Fri Dec 14 17:19:34 2007
Return-path: <gcc-return-142988-gcc=m.gmane.org@gcc.gnu.org>
Envelope-to: gcc@gmane.org
Received: from sourceware.org ([209.132.176.174])
	by lo.gmane.org with smtp (Exim 4.50)
	id 1J3DG3-00085y-Hj
	for gcc@gmane.org; Fri, 14 Dec 2007 17:19:27 +0100
Received: (qmail 6818 invoked by alias); 14 Dec 2007 16:19:07 -0000
Received: (qmail 6810 invoked by uid 22791); 14 Dec 2007 16:19:07 -0000
X-Spam-Check-By: sourceware.org
Received: from zep00a03.dent.med.uni-muenchen.de (HELO md.dent.med.uni-muenchen.de) (138.245.179.2)     by sourceware.org (qpsmtpd/0.31) with SMTP; Fri, 14 Dec 2007 16:19:01 +0000
Received: (qmail 3507 invoked by uid 211); 14 Dec 2007 16:18:58 -0000
In-reply-to: <85d4tc8hi8.fsf@lola.goethe.zz> (message from David Kastrup on 	Wed, 12 Dec 2007 09:05:51 +0100)
Mailing-List: contact gcc-help@gcc.gnu.org; run by ezmlm
Precedence: bulk
List-Id: <gcc.gcc.gnu.org>
List-Unsubscribe: <mailto:gcc-unsubscribe-gcc=m.gmane.org@gcc.gnu.org>
List-Archive: <http://gcc.gnu.org/ml/gcc/>
List-Post: <mailto:gcc@gcc.gnu.org>
List-Help: <http://gcc.gnu.org/ml/>
Sender: gcc-owner@gcc.gnu.org
Delivered-To: mailing list gcc@gcc.gnu.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68315>

Hi,

> Maybe an malloc/free/mmap wrapper that records the requested sizes and
> alloc/free order and dumps them to file so that one can make a compact
> git-free standalone test case for the glibc maintainers might be a good
> thing.

I already have such a wrapper:

http://malloc.de/malloc/mtrace-20060529.tar.gz

But note that it does interfere with the thread scheduling, so it
can't record the exact same allocation pattern as when not using the
wrapper.

Regards,
Wolfram.
