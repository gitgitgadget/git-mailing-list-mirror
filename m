From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [RFC] Convert builin-mailinfo.c to use The Better String Library.
Date: Fri, 7 Sep 2007 08:41:25 +0100
Message-ID: <200709070841.33057.andyparkins@gmail.com>
References: <46DDC500.5000606@etek.chalmers.se> <a1bbc6950709061721r537b153eu1b0bb3c27fb7bd51@mail.gmail.com> <85ejhb7yzw.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: David Kastrup <dak@gnu.org>,
	"Dmitry Kakurin" <dmitry.kakurin@gmail.com>,
	"Linus Torvalds" <torvalds@linux-foundation.org>,
	"Matthieu Moy" <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 07 09:41:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITYTM-00019r-MH
	for gcvg-git@gmane.org; Fri, 07 Sep 2007 09:41:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964949AbXIGHll (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Sep 2007 03:41:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964945AbXIGHll
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Sep 2007 03:41:41 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:28054 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964931AbXIGHlk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Sep 2007 03:41:40 -0400
Received: by nf-out-0910.google.com with SMTP id f5so322259nfh
        for <git@vger.kernel.org>; Fri, 07 Sep 2007 00:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=0gAmaBLsIugvzLggMwFhRrLU/soNVbplSpBgITAA+A0=;
        b=SShO3GCywBmAd7nDPmDKImP86eNjH1uy+dtNCusma+Fnkkh2EjnEdZkpPHPevNNE6aDWf3phQJlZf52KYZX+IrLQOCj5pgXyg4bO3m9hTzURHT2J9tsB4zHPnvJ2vnOe8nmWbOoA+InrK1uOU5bZb8SRRBIyo5aBeEJ9n18PSsY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=dquyRdSA3BbK20AeknF0TfBFMODcTsyV5mDAYXUP/3ge24OOPWQ0PmpKrhFB3wmNYTfAixWtvxPHJvTS7gCovquvoZ+sv8j6MT3ehhnDIuCPzLHBYulTSuXEHmpOhR+OVg8sqyt4Q7gwK0oP3aKNTafHpPsTnuL/HY5/O/dCAA4=
Received: by 10.86.65.11 with SMTP id n11mr1230585fga.1189150898719;
        Fri, 07 Sep 2007 00:41:38 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTPS id f7sm2060621nfh.2007.09.07.00.41.35
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 07 Sep 2007 00:41:36 -0700 (PDT)
User-Agent: KMail/1.9.7
In-Reply-To: <85ejhb7yzw.fsf@lola.goethe.zz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58000>

On Friday 2007 September 07, David Kastrup wrote:

(Disclaimer: I'm certainly not joining the "C++ for git" chant; this reply is 
merely to the statements made about C++ in David's message).

> The problem with C++ is that every C++ developer has his own style,
> and reuse is an illusion within that style.  Take a look at classes
> implementing matrix arithmetic: there are as many around as the day is
> long, and all of them are incompatible with one another.

One could say the same about any API.  "Take a look at that C library libXYZ - 
it does exactly the same thing as libPQR but all the function calls and 
structures are different.  Conclusion: C is shit".  Obviously nonsense.

> With regard to programming styles, C++ does not support multiple
> inheritance.  For a single project grown from a single start, you can

Multiple inheritance is the spawn of the devil, but C++ _does_ support it.

Forgetting about the terrible STL, to me there really is no difference between 
C and C++; you can be object oriented in C.  Take a look at the Linux kernel, 
it should be printed out, rolled up and used to beat the ideas into students 
learning C++/Java/C#.   Object oriented design is a choice, and if you really 
wanted you could do it in assembly.

I would imagine the reason people often turn up wanting to rewrite Linux and 
git in C++ is because they are so object oriented in nature already and it's 
natural to think "wouldn't this be even better if I wrote it in an object 
oriented language"?  Maybe, maybe not, but why bother?



Andy

-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
