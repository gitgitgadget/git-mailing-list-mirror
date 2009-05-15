From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: Request for detailed documentation of git pack protocol
Date: Thu, 14 May 2009 20:58:29 -0400
Message-ID: <4A0CBE35.6030004@gmail.com>
References: <200905122329.15379.jnareb@gmail.com> <20090512233450.GY30527@spearce.org> <d411cc4a0905140655y244f21aem44f1e246dd74d80c@mail.gmail.com> <200905141701.41212.jnareb@gmail.com>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Scott Chacon <schacon@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 15 02:59:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4lle-0007sf-Ak
	for gcvg-git-2@gmane.org; Fri, 15 May 2009 02:59:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756532AbZEOA6h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 May 2009 20:58:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757178AbZEOA6g
	(ORCPT <rfc822;git-outgoing>); Thu, 14 May 2009 20:58:36 -0400
Received: from yx-out-2324.google.com ([74.125.44.29]:26269 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756488AbZEOA6f (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 May 2009 20:58:35 -0400
Received: by yx-out-2324.google.com with SMTP id 3so935508yxj.1
        for <git@vger.kernel.org>; Thu, 14 May 2009 17:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id
         :disposition-notification-to:date:from:reply-to:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=nc2IoPk2h7HFb6ZbmzhuqxHeyTIkf3CRWqPNyidsBwE=;
        b=Pqrzmb8xr3Fb9BjomkZ7/2P2+MTTYuv09QvL+ZDzdVirHSaKa/cqrmhP3Xhy2QxxlK
         LeIHo/v2nuiJIO6Sl2g3Jvou+KUo6GZMnAnFNZNY1jlYXFOpo3eal7RJ2Pai7smUTfYA
         ELHoRl1oh1D9KtBxWWepSmHwxsbmbUwbn0HYU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:disposition-notification-to:date:from:reply-to
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        b=RsqAw+L914Q14bUbm/rdALqiMurFkt/c0Hqmu2xsvL8jVjsyzrrLZQn+Hrod+80dgR
         CAG2e+8Lb2Cw1KwZz6wgO6sywKO+dHFSLI1Kc14eGG6vWZq5UDpeypA0hPhtfPE1LloS
         NYuYc7Qf3ApK2pdmgNJ2Op9ScW2KTPCkagb7A=
Received: by 10.100.143.17 with SMTP id q17mr3930377and.114.1242349116607;
        Thu, 14 May 2009 17:58:36 -0700 (PDT)
Received: from ?10.0.0.6? (c-66-177-19-100.hsd1.fl.comcast.net [66.177.19.100])
        by mx.google.com with ESMTPS id d38sm2282832and.24.2009.05.14.17.58.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 14 May 2009 17:58:35 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.10 (X11/20060911)
In-Reply-To: <200905141701.41212.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119243>

Jakub Narebski wrote:
> I don't think RFC _process_ is something to worry about; in the future
> perhaps (just like Atom Publishing protocol was submitted to IETF).
> I was thinking about _format_ used in RFC (BNF-like specification,
> specific semantic for 'MUST' etc. like in RFC2119). Although any format
> (more or less formal) would be better that none.

Standardese, the peculiar dialect and formalism employed by RFC authors, 
is not difficult to master. The difficult part is writing the prose 
that's an _unambiguous_ description of the protocol you're attempting to 
document. There's even a tool, xml2rfc, that will do the formatting for you.
