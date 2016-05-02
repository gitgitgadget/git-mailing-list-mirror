From: =?UTF-8?Q?Ren=c3=a9_Nyffenegger?= <mail@renenyffenegger.ch>
Subject: Re: [PATCH] fix typo 'In such these cases'
Date: Mon, 2 May 2016 21:41:13 +0200
Message-ID: <5727AD59.3020905@renenyffenegger.ch>
References: <572703EC.20405@renenyffenegger.ch>
 <xmqqa8k8ti0q.fsf@gitster.mtv.corp.google.com>
 <5727AA7F.70504@renenyffenegger.ch>
 <xmqqlh3ss14j.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 02 21:41:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axJib-0004ds-LF
	for gcvg-git-2@plane.gmane.org; Mon, 02 May 2016 21:41:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754832AbcEBTlS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 May 2016 15:41:18 -0400
Received: from belinda3.kreativmedia.ch ([80.74.158.27]:36728 "EHLO
	belinda3.kreativmedia.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754680AbcEBTlR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 May 2016 15:41:17 -0400
Received: from [192.168.1.122] (214.181.202.62.dynamic.cgnat.res.cust.swisscom.ch [62.202.181.214])
	by belinda3.kreativmedia.ch (Postfix) with ESMTPSA id E868FBDD8059;
	Mon,  2 May 2016 21:41:13 +0200 (CEST)
DomainKey-Signature: a=rsa-sha1;  q=dns; c=nofws;
  s=default; d=renenyffenegger.ch;
  b=OBg/sQ6j9E/AXQk3MRQNN6bt5r5OBZXOkDH1oZgruXg/U2jFQWQSQYMeGg0OR3YrJUbzGE+3N79/DeETi9/iy5hdW6i/OPtkW5jxUIPAqY68LqA3cMtgCDLm0a/H3JY+dsvzn1qcHgnZpUD1pdXlTFcyQNxfKThSiTt7yELExVI=;
  h=Subject:To:References:Cc:From:Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding;
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
In-Reply-To: <xmqqlh3ss14j.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293278>

> Re substance, I am wondering if "In such a case" might be better, by
> the way.  That is:
> 
>  	A fast-forward is a special type of <<def_merge,merge>> where you have a
>  	<<def_revision,revision>> and you are "merging" another
>  	<<def_branch,branch>>'s changes that happen to be a descendant of what
> -	you have. In such these cases, you do not make a new <<def_merge,merge>>
> +	you have. In such a case, you do not make a new <<def_merge,merge>>
>  	<<def_commit,commit>> but instead just update to his
>  	revision. This will happen frequently on a
> 
> It is not like there are multiple variants of "fast-forward"
> situations, in all of which the HEAD pointer is just moved without
> creating a new commit.  There is only one variant of "fast-forward".

That's correct. Your suggestion makes more sense.
 
