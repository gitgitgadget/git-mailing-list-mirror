From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: Something is broken in repack
Date: Fri, 14 Dec 2007 17:52:05 +0700
Message-ID: <fcaeb9bf0712140252j42a3cff0r33b889e355d41dd@mail.gmail.com>
References: <alpine.LFD.0.99999.0712120743040.555@xanadu.home> 	 <fcaeb9bf0712130532s79aa7afeve6f018f9430ab3b3@mail.gmail.com> 	 <fjrj9k$n6k$1@ger.gmane.org> <47616044.7070504@viscovery.net> 	 <fjskqt$eap$1@ger.gmane.org> <fjt6vm$n7d$1@ger.gmane.org> 	 <fcaeb9bf0712132224u54ca845ap4836dfe1cda37b29@mail.gmail.com> 	 <m3odctr245.fsf@roke.D-201>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Paolo Bonzini" <bonzini@gnu.org>, git@vger.kernel.org, gcc@gcc.gnu.org
To: "Jakub Narebski" <jnareb@gmail.com>,  	"Harvey Harrison" <harvey.harrison@gmail.com>
X-From: gcc-return-142983-gcc=m.gmane.org@gcc.gnu.org Fri Dec 14 11:52:46 2007
Return-path: <gcc-return-142983-gcc=m.gmane.org@gcc.gnu.org>
Envelope-to: gcc@gmane.org
Received: from sourceware.org ([209.132.176.174])
	by lo.gmane.org with smtp (Exim 4.50)
	id 1J389g-0006rE-MV
	for gcc@gmane.org; Fri, 14 Dec 2007 11:52:33 +0100
Received: (qmail 10672 invoked by alias); 14 Dec 2007 10:52:13 -0000
Received: (qmail 10660 invoked by uid 22791); 14 Dec 2007 10:52:12 -0000
X-Spam-Check-By: sourceware.org
Received: from nf-out-0910.google.com (HELO nf-out-0910.google.com) (64.233.182.189)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Fri, 14 Dec 2007 10:52:08 +0000
Received: by nf-out-0910.google.com with SMTP id h3so1467914nfh.6         for <gcc@gcc.gnu.org>; Fri, 14 Dec 2007 02:52:05 -0800 (PST)
Received: by 10.86.4.2 with SMTP id 2mr2856787fgd.77.1197629525451;         Fri, 14 Dec 2007 02:52:05 -0800 (PST)
Received: by 10.86.83.6 with HTTP; Fri, 14 Dec 2007 02:52:05 -0800 (PST)
In-Reply-To: <m3odctr245.fsf@roke.D-201>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68275>

On Dec 14, 2007 4:01 PM, Harvey Harrison <harvey.harrison@gmail.com> wrote:
> While it doesn't mark the packs as .keep, git will reuse all of the old
> deltas you got in the original clone, so you're not losing anything.

There is another reason I want it. I have an ~800MB pack and I don't
want git to rewrite  the pack every time I repack my changes. So it's
kind of disk-wise (don't require 800MB on disk to prepare new pack,
and don't write too much).

On Dec 14, 2007 5:40 PM, Jakub Narebski <jnareb@gmail.com> wrote:
> But if you clone via network, pack might be network optimized if you
> use "smart" transport, not disk optimized, at least with current git
> which regenerates pack also on clone AFAIK.

Um.. that's ok it just regenerate once.

-- 
Duy
