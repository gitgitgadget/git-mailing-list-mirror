From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: [RFC] separate .git from working directory
Date: Thu, 12 Oct 2006 04:55:32 +0700
Message-ID: <fcaeb9bf0610111455y225237cmdbaadbf294686d8e@mail.gmail.com>
References: <fcaeb9bf0610110623q365d3ffcw9ba9e11936d03a9d@mail.gmail.com>
	 <BAYC1-PASMTP10003954B66E10247020A7AE140@CEZ.ICE>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 11 23:57:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GXm38-0002ba-CD
	for gcvg-git@gmane.org; Wed, 11 Oct 2006 23:55:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161213AbWJKVzf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Oct 2006 17:55:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161538AbWJKVze
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Oct 2006 17:55:34 -0400
Received: from wx-out-0506.google.com ([66.249.82.225]:13656 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1161213AbWJKVzd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Oct 2006 17:55:33 -0400
Received: by wx-out-0506.google.com with SMTP id s14so343556wxc
        for <git@vger.kernel.org>; Wed, 11 Oct 2006 14:55:32 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=epe8H48HhjxLYq5s/fdplBGbM3ihQxt/fZ+x685LVRjjGCQ4zBziNklCodjlWvmRLNHc+iOFAN4Jcc3G323gF5Dpsi/X489rWq6egQtbRD9RfqXCQFGsvsFYidMsWXLKCNE8F6EbaidQp5o1jdDxyHReH0nLFP944Urj1ZfeaJs=
Received: by 10.70.111.2 with SMTP id j2mr1471620wxc;
        Wed, 11 Oct 2006 14:55:32 -0700 (PDT)
Received: by 10.70.46.13 with HTTP; Wed, 11 Oct 2006 14:55:32 -0700 (PDT)
To: Sean <seanlkml@sympatico.ca>
In-Reply-To: <BAYC1-PASMTP10003954B66E10247020A7AE140@CEZ.ICE>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28756>

On 10/11/06, Sean <seanlkml@sympatico.ca> wrote:
> You can export a GIT_DIR manually pretty easily if you want to move
> the .git directory somewhere else.  Also you could make a "git find"
> shell script named "gf" that does something like:
>
> #/bin/sh
> find "$@" ! -path '*/.git/*'
>
> Which would let you type  "gf -name blah" and automatically ignore
> the .git directory.

It should work. However I would rather use "normal" find than
specialized ones. Imagine somedays I hate find and start to love grep,
I would have to find out --exclude option and create new "gg" script.
In worse cases where recursive commands don't support filtering, I
have no chance to filter out .git directories.

>
> Sean
-- 
Duy
