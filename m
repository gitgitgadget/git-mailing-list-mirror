From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v1 00/25] contrib: cleanup
Date: Fri, 09 May 2014 12:15:01 -0500
Message-ID: <536d0d158d827_693d7fd30c54@nysa.notmuch>
References: <1399597116-1851-1-git-send-email-felipe.contreras@gmail.com>
 <CACPiFCJnsu3qw59oK94sP1u0+KBDvne0ZpKS0LMGc_9ge+rJjA@mail.gmail.com>
 <536c36fc8e04c_741a161d31095@nysa.notmuch>
 <20140509152236.GC18197@sigill.intra.peff.net>
 <536cfb02d0f1a_ce316372ecce@nysa.notmuch>
 <CACPiFCLcXOsSG34oBefEN7CPy4AKMAZjf7EA5WmxJG5oUfmepA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Martin Langhoff <martin.langhoff@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 09 19:15:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WioOB-0003Q5-6J
	for gcvg-git-2@plane.gmane.org; Fri, 09 May 2014 19:15:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757191AbaEIRPJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 May 2014 13:15:09 -0400
Received: from mail-yh0-f44.google.com ([209.85.213.44]:49889 "EHLO
	mail-yh0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757151AbaEIRPI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 May 2014 13:15:08 -0400
Received: by mail-yh0-f44.google.com with SMTP id b6so4022790yha.31
        for <git@vger.kernel.org>; Fri, 09 May 2014 10:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=9uULKEp35RJkacfFwWrxm5WI6xL9lCzdgGroifGd8EA=;
        b=pnynKoPxty18RTO/TdXVlbxrOpz0ZbBZdwb4D0p0m/4dkM8Y2rRA6JblQZAA25d1WC
         mL+7ADNLYyjEP78M2Vodvyd9P5cdrpRx1aR49hKrVnHWapBmj7kR7EGq+TByS+6FIpKo
         PK55CxdSKPcNB+gyatG3FJLO0495za+aPDeBB5IHmL21CgUTwi8anmgeYk1oe82AUCO+
         TcOD88p53+t55UD80RMCuKeZTgS50XtgNx8KVe1D7B1N9cGPzRfNMA2LDiLcUSTDutX5
         cupAA8RRpEXxITR/tDmlS1x7DbtZCC7kc3YwPa8l6oIB0knm8Wy39iEN6PRCBXQujjdK
         dc0g==
X-Received: by 10.236.163.8 with SMTP id z8mr16689431yhk.43.1399655707447;
        Fri, 09 May 2014 10:15:07 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id l66sm6969422yhc.54.2014.05.09.10.15.03
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 May 2014 10:15:06 -0700 (PDT)
In-Reply-To: <CACPiFCLcXOsSG34oBefEN7CPy4AKMAZjf7EA5WmxJG5oUfmepA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248590>

Martin Langhoff wrote:
> On Fri, May 9, 2014 at 11:57 AM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
> > I already explained:
> >> That's right, and they are Cc'ed so they can respond.  Some tools have
> >> only one commit or two, and in those I didn't even bother Cc'ing
> >> anyone.
> >
> > contrib/persistent-https consist of a *single* commit, I didn't bother
> > with those.
> 
> That single commit is the "merge" into contrib. It may have had a dev
> history before.

It may, but from git.git's perspective it has no activity.

Either way it's written in Go. I fail to see why Go can be tolerated
while Ruby and any other language can't. Only C, perl, sh, or python.

-- 
Felipe Contreras
