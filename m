From: Harvey Harrison <harvey.harrison@gmail.com>
Subject: Re: Something is broken in repack
Date: Fri, 14 Dec 2007 01:01:52 -0800
Message-ID: <1197622912.898.53.camel@brick>
References: <alpine.LFD.0.99999.0712120743040.555@xanadu.home> 	 <fcaeb9bf0712130532s79aa7afeve6f018f9430ab3b3@mail.gmail.com> 	 <fjrj9k$n6k$1@ger.gmane.org> <47616044.7070504@viscovery.net> 	 <fjskqt$eap$1@ger.gmane.org> <fjt6vm$n7d$1@ger.gmane.org> 	 <fcaeb9bf0712132224u54ca845ap4836dfe1cda37b29@mail.gmail.com> 	 <fjtect$8qn$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: gcc@gcc.gnu.org, git@vger.kernel.org
To: Paolo Bonzini <bonzini@gnu.org>
X-From: gcc-return-142980-gcc=m.gmane.org@gcc.gnu.org Fri Dec 14 10:02:25 2007
Return-path: <gcc-return-142980-gcc=m.gmane.org@gcc.gnu.org>
Envelope-to: gcc@gmane.org
Received: from sourceware.org ([209.132.176.174])
	by lo.gmane.org with smtp (Exim 4.50)
	id 1J36R4-00064n-H1
	for gcc@gmane.org; Fri, 14 Dec 2007 10:02:22 +0100
Received: (qmail 18041 invoked by alias); 14 Dec 2007 09:02:01 -0000
Received: (qmail 18031 invoked by uid 22791); 14 Dec 2007 09:02:00 -0000
X-Spam-Check-By: sourceware.org
Received: from rv-out-0910.google.com (HELO rv-out-0910.google.com) (209.85.198.186)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Fri, 14 Dec 2007 09:01:49 +0000
Received: by rv-out-0910.google.com with SMTP id f5so808749rvb.56         for <gcc@gcc.gnu.org>; Fri, 14 Dec 2007 01:01:47 -0800 (PST)
Received: by 10.141.70.18 with SMTP id x18mr1691899rvk.284.1197622907650;         Fri, 14 Dec 2007 01:01:47 -0800 (PST)
Received: from ?192.168.1.100? ( [216.19.190.48])         by mx.google.com with ESMTPS id c20sm54810rvf.2007.12.14.01.01.46         (version=TLSv1/SSLv3 cipher=RC4-MD5);         Fri, 14 Dec 2007 01:01:47 -0800 (PST)
In-Reply-To: <fjtect$8qn$1@ger.gmane.org>
X-Mailer: Evolution 2.12.1
X-IsSubscribed: yes
Mailing-List: contact gcc-help@gcc.gnu.org; run by ezmlm
Precedence: bulk
List-Id: <gcc.gcc.gnu.org>
List-Unsubscribe: <mailto:gcc-unsubscribe-gcc=m.gmane.org@gcc.gnu.org>
List-Archive: <http://gcc.gnu.org/ml/gcc/>
List-Post: <mailto:gcc@gcc.gnu.org>
List-Help: <http://gcc.gnu.org/ml/>
Sender: gcc-owner@gcc.gnu.org
Delivered-To: mailing list gcc@gcc.gnu.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68269>

On Fri, 2007-12-14 at 09:20 +0100, Paolo Bonzini wrote:
> > I'm thinking about "git clone --keep" to mark initial packs precious.
> > But 'git clone' is under rewrite to C. Let's wait until C rewrite is
> > done.
> 
> It should be the default, IMHO.
> 

While it doesn't mark the packs as .keep, git will reuse all of the old
deltas you got in the original clone, so you're not losing anything.

Harvey
