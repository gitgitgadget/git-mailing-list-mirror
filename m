From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: In future, to replace autotools by cmake like KDE4 did?
Date: Fri, 07 Dec 2007 04:14:42 -0800 (PST)
Message-ID: <m3lk86u2fq.fsf@roke.D-201>
References: <998d0e4a0712061810k18e6388jde9d7bc5bd006b57@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gcc@gcc.gnu.org, git@vger.kernel.org, "David Miller" <davem@davemloft.net>,         "Daniel Berlin" <dberlin@dberlin.org>,         "Ismail Donmez" <ismail@pardus.org.tr>
To: "J.C. Pizarro" <jcpiza@gmail.com>
X-From: gcc-return-142796-gcc=m.gmane.org@gcc.gnu.org Fri Dec 07 13:15:17 2007
Return-path: <gcc-return-142796-gcc=m.gmane.org@gcc.gnu.org>
Envelope-to: gcc@gmane.org
Received: from sourceware.org ([209.132.176.174])
	by lo.gmane.org with smtp (Exim 4.50)
	id 1J0c6r-00035O-6t
	for gcc@gmane.org; Fri, 07 Dec 2007 13:15:13 +0100
Received: (qmail 8886 invoked by alias); 7 Dec 2007 12:14:54 -0000
Received: (qmail 8853 invoked by uid 22791); 7 Dec 2007 12:14:53 -0000
X-Spam-Check-By: sourceware.org
Received: from ug-out-1314.google.com (HELO ug-out-1314.google.com) (66.249.92.174)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Fri, 07 Dec 2007 12:14:46 +0000
Received: by ug-out-1314.google.com with SMTP id o38so921602ugd         for <gcc@gcc.gnu.org>; Fri, 07 Dec 2007 04:14:43 -0800 (PST)
Received: by 10.78.149.15 with SMTP id w15mr3500186hud.1197029683165;         Fri, 07 Dec 2007 04:14:43 -0800 (PST)
Received: from roke.D-201 ( [83.8.224.19])         by mx.google.com with ESMTPS id w7sm1602090mue.2007.12.07.04.14.40         (version=TLSv1/SSLv3 cipher=OTHER);         Fri, 07 Dec 2007 04:14:42 -0800 (PST)
Received: from roke (localhost.localdomain [127.0.0.1]) 	by roke.D-201 (8.13.4/8.13.4) with ESMTP id lB7CEZN5005279; 	Fri, 7 Dec 2007 13:14:35 +0100
Received: (from jnareb@localhost) 	by roke (8.13.4/8.13.4/Submit) id lB7CEXBs005276; 	Fri, 7 Dec 2007 13:14:33 +0100
In-Reply-To: <998d0e4a0712061810k18e6388jde9d7bc5bd006b57@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Mailing-List: contact gcc-help@gcc.gnu.org; run by ezmlm
Precedence: bulk
List-Id: <gcc.gcc.gnu.org>
List-Unsubscribe: <mailto:gcc-unsubscribe-gcc=m.gmane.org@gcc.gnu.org>
List-Archive: <http://gcc.gnu.org/ml/gcc/>
List-Post: <mailto:gcc@gcc.gnu.org>
List-Help: <http://gcc.gnu.org/ml/>
Sender: gcc-owner@gcc.gnu.org
Delivered-To: mailing list gcc@gcc.gnu.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67415>

"J.C. Pizarro" <jcpiza@gmail.com> writes:

> The autotools ( automake + libtool + autoconf + ... ) generate many big
> files that they have been slowing the building's computation and growing
> enormously their cvs/svn/git/hg repositories because of generated files.
[cut]

And this is relevant for this mailing list exactly how? From the whole
autotools package git uses only autoconf, and only as an optional part
to configure only Makefile configuration variables.

Generated files should not be put into version control, unless it is
for convenience only in separate branch like HTML and manpage versions
of git documentation are in 'html and 'man' branches, respectively.
The same could be done with ./configure script.

Although there was some talk about whether giw should use autotools,
or perhaps CMake, or handmade ./configure script like MPlayer IIRC,
instead of its own handmade Makefile...

-- 
Jakub Narebski
ShadeHawk on #git
