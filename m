From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: In future, to replace autotools by cmake like KDE4 did?
Date: Fri, 7 Dec 2007 08:56:47 +0100
Message-ID: <7FAE3E89-4C56-47AE-8AD8-9191D6BB8FAC@holtmann.org>
References: <998d0e4a0712061810k18e6388jde9d7bc5bd006b57@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: gcc@gcc.gnu.org, git@vger.kernel.org, "David Miller" <davem@davemloft.net>,         "Daniel Berlin" <dberlin@dberlin.org>,         "Ismail Donmez" <ismail@pardus.org.tr>
To: "J.C. Pizarro" <jcpiza@gmail.com>
X-From: gcc-return-142795-gcc=m.gmane.org@gcc.gnu.org Fri Dec 07 08:57:44 2007
Return-path: <gcc-return-142795-gcc=m.gmane.org@gcc.gnu.org>
Envelope-to: gcc@gmane.org
Received: from sourceware.org ([209.132.176.174])
	by lo.gmane.org with smtp (Exim 4.50)
	id 1J0Y5a-0000Ro-4z
	for gcc@gmane.org; Fri, 07 Dec 2007 08:57:38 +0100
Received: (qmail 12573 invoked by alias); 7 Dec 2007 07:57:18 -0000
Received: (qmail 12556 invoked by uid 22791); 7 Dec 2007 07:57:17 -0000
X-Spam-Check-By: sourceware.org
Received: from coyote.holtmann.net (HELO mail.holtmann.net) (217.160.111.169)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Fri, 07 Dec 2007 07:57:09 +0000
Received: from bluebird (i577ADB98.versanet.de [87.122.219.152]) 	by mail.holtmann.net (8.13.4/8.13.4/Debian-3sarge3) with ESMTP id lB781T01019376 	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT); 	Fri, 7 Dec 2007 09:01:31 +0100
In-Reply-To: <998d0e4a0712061810k18e6388jde9d7bc5bd006b57@mail.gmail.com>
X-Mailer: Apple Mail (2.915)
Mailing-List: contact gcc-help@gcc.gnu.org; run by ezmlm
Precedence: bulk
List-Id: <gcc.gcc.gnu.org>
List-Unsubscribe: <mailto:gcc-unsubscribe-gcc=m.gmane.org@gcc.gnu.org>
List-Archive: <http://gcc.gnu.org/ml/gcc/>
List-Post: <mailto:gcc@gcc.gnu.org>
List-Help: <http://gcc.gnu.org/ml/>
Sender: gcc-owner@gcc.gnu.org
Delivered-To: mailing list gcc@gcc.gnu.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67395>

Hi,

> The autotools ( automake + libtool + autoconf + ... ) generate many  
> big
> files that they have been slowing the building's computation and  
> growing
> enormously their cvs/svn/git/hg repositories because of generated  
> files.
>
> To see below interesting links:
> 1. http://dot.kde.org/1172083974/
> 2. http://sam.zoy.org/lectures/20050910-debian/
> 3. https://lwn.net/Articles/188693/
> 4. http://en.wikipedia.org/wiki/GNU_Build_Tools
> 5. http://en.wikipedia.org/wiki/GNU_Automake
>
> The benefits could be:
> * +40% faster in the KDE4 building vs KDE 3.5.6.
> * elimination of redundant and unnecesary generated files as those
>  from autotools.
> * smaller cvs/svn/git/hg repositories.

stop spreading this FUD. If you leave the auto-generated files from  
autotools in the source control repositories, then it is your fault.  
They are generated files and can always be generated. Hence putting  
them under revision control makes no sense and so don't do it. And  
more certain don't complain about it if you did.

Regards

Marcel
