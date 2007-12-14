From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: Something is broken in repack
Date: Fri, 14 Dec 2007 13:24:07 +0700
Message-ID: <fcaeb9bf0712132224u54ca845ap4836dfe1cda37b29@mail.gmail.com>
References: <alpine.LFD.0.99999.0712120743040.555@xanadu.home> 	 <fcaeb9bf0712130532s79aa7afeve6f018f9430ab3b3@mail.gmail.com> 	 <fjrj9k$n6k$1@ger.gmane.org> <47616044.7070504@viscovery.net> 	 <fjskqt$eap$1@ger.gmane.org> <fjt6vm$n7d$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gcc@gcc.gnu.org
To: "Paolo Bonzini" <bonzini@gnu.org>
X-From: gcc-return-142977-gcc=m.gmane.org@gcc.gnu.org Fri Dec 14 07:24:37 2007
Return-path: <gcc-return-142977-gcc=m.gmane.org@gcc.gnu.org>
Envelope-to: gcc@gmane.org
Received: from sourceware.org ([209.132.176.174])
	by lo.gmane.org with smtp (Exim 4.50)
	id 1J33yN-0001gA-V3
	for gcc@gmane.org; Fri, 14 Dec 2007 07:24:36 +0100
Received: (qmail 954 invoked by alias); 14 Dec 2007 06:24:15 -0000
Received: (qmail 945 invoked by uid 22791); 14 Dec 2007 06:24:14 -0000
X-Spam-Check-By: sourceware.org
Received: from nf-out-0910.google.com (HELO nf-out-0910.google.com) (64.233.182.191)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Fri, 14 Dec 2007 06:24:09 +0000
Received: by nf-out-0910.google.com with SMTP id h3so1344648nfh.6         for <gcc@gcc.gnu.org>; Thu, 13 Dec 2007 22:24:07 -0800 (PST)
Received: by 10.86.62.3 with SMTP id k3mr2686748fga.15.1197613447118;         Thu, 13 Dec 2007 22:24:07 -0800 (PST)
Received: by 10.86.83.6 with HTTP; Thu, 13 Dec 2007 22:24:07 -0800 (PST)
In-Reply-To: <fjt6vm$n7d$1@ger.gmane.org>
Content-Disposition: inline
Mailing-List: contact gcc-help@gcc.gnu.org; run by ezmlm
Precedence: bulk
List-Id: <gcc.gcc.gnu.org>
List-Unsubscribe: <mailto:gcc-unsubscribe-gcc=m.gmane.org@gcc.gnu.org>
List-Archive: <http://gcc.gnu.org/ml/gcc/>
List-Post: <mailto:gcc@gcc.gnu.org>
List-Help: <http://gcc.gnu.org/ml/>
Sender: gcc-owner@gcc.gnu.org
Delivered-To: mailing list gcc@gcc.gnu.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68234>

On Dec 14, 2007 1:14 PM, Paolo Bonzini <bonzini@gnu.org> wrote:
> > Hmmm... it is even documented in git-gc(1)... and git-index-pack(1) of
> > all things.
>
> I found that the .keep file is not transmitted over the network (at
> least I tried with git+ssh:// and http:// protocols), however.

I'm thinking about "git clone --keep" to mark initial packs precious.
But 'git clone' is under rewrite to C. Let's wait until C rewrite is
done.
-- 
Duy
