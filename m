From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] document string_list_clear
Date: Wed, 10 Dec 2014 15:08:27 -0800
Message-ID: <20141210230827.GH16345@google.com>
References: <CAGZ79kbk4SXEXKzn-V8c4zCQU8m8ub+VkKhmub-bFoLZT1WWpA@mail.gmail.com>
 <20141209201713.GY16345@google.com>
 <20141209202738.GC12001@peff.net>
 <20141209222337.GA16345@google.com>
 <20141210084351.GA29776@peff.net>
 <5488A87C.4030505@alum.mit.edu>
 <20141210215154.GF16345@google.com>
 <xmqqlhmff8cs.fsf@gitster.dls.corp.google.com>
 <20141210223721.GG16345@google.com>
 <xmqq61djf6nq.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>, Jeff King <peff@peff.net>,
	Stefan Beller <sbeller@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 11 00:08:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XyqN1-0002Ke-9P
	for gcvg-git-2@plane.gmane.org; Thu, 11 Dec 2014 00:08:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758196AbaLJXIb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Dec 2014 18:08:31 -0500
Received: from mail-ig0-f175.google.com ([209.85.213.175]:38810 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751399AbaLJXIa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Dec 2014 18:08:30 -0500
Received: by mail-ig0-f175.google.com with SMTP id h15so7394524igd.2
        for <git@vger.kernel.org>; Wed, 10 Dec 2014 15:08:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=Onmdg3wTkr7R4EiFclJC4IeFjQ1BbRSE/fu268nzKxI=;
        b=cnQqJPHrbGY2DY/mNIQa6qKj1AX8FynTJoclJaXIOCg+7esBzxg2jwIniOTXTGTw3k
         /3R5nIcrT8vivaqj6GIP2C3p01oxCzSKgdshGhAr6GSjsOnubYgvW+TUgNVP8YlVmU9V
         ZZdWQnRGwh2TBRqkYdzmnk72z7+pFcvU/7EKR/pGx2bcGXLsBBAoqI6TRuugFth7BCQ0
         64mEQIHD6GURn0kSFPRksEFxb/2bXE390IojXWalMhGDND9BcsoruZnjS/pX6rpgRkao
         M03H/tXt9FtmaqzEBWdueMLhtIpgVQEpt7GtbDIW2SUUSVHl+3igVH9Vmlr4pxEb5rdJ
         oCmA==
X-Received: by 10.50.93.6 with SMTP id cq6mr10872633igb.7.1418252910148;
        Wed, 10 Dec 2014 15:08:30 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:ad0e:8148:e84b:d170])
        by mx.google.com with ESMTPSA id l70sm3020189iol.42.2014.12.10.15.08.29
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 10 Dec 2014 15:08:29 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <xmqq61djf6nq.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261256>

Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>>  2. Move documentation to header, being careful enough that the header
>>     sort of works as a standalone document.
>>
>>  3. Move documentation to Documentation/technical/ and keep the header
>>     bare-bones.
[...]
> I am not sure if (2) and (3) are that incompatible, though.  If you
> had an acceptable version of (3), wouldn't it be just the matter of
> indenting the whole thing with "s/^/ */", sprinkle "/**" and "*/" at
> strategic paragraph breaks, and move them back to the corresponding
> header?

Presumably.  There's also the question of whether to use asciidoc
markup, which got mixed in somehow (but I don't see why it has to be ---
a header with asciidoc would be fine with me, as would a file in
Documentation/technical/ without asciidoc).
