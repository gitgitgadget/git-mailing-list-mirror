From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH] post-receive-email hook: handle order of arguments consistently
Date: Tue, 7 Aug 2007 18:38:15 +0100
Message-ID: <200708071838.17999.andyparkins@gmail.com>
References: <20070614090929.31616.qmail@c76df6d65db410.315fe32.mid.smarden.org> <200706141119.18724.andyparkins@gmail.com> <20070807135849.24926.qmail@49810ee852ce6e.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Gerrit Pape <pape@smarden.org>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 07 19:38:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIT0v-00089C-UE
	for gcvg-git@gmane.org; Tue, 07 Aug 2007 19:38:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761586AbXHGRiW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 7 Aug 2007 13:38:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761541AbXHGRiW
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Aug 2007 13:38:22 -0400
Received: from ik-out-1112.google.com ([66.249.90.182]:34643 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756420AbXHGRiV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Aug 2007 13:38:21 -0400
Received: by ik-out-1112.google.com with SMTP id b32so508995ika
        for <git@vger.kernel.org>; Tue, 07 Aug 2007 10:38:19 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=C99EFz/L6+SSVOegxb4FkuhlbB61Xa6aDmAk49V/Uz7uYGNdidPKQyxPYlKd464cagbFQaU109ByLS7yPII4/2zHQ7p7oIZKFHzjjw5NyRgPKt16NSGuhhfH0rCMVyMTMrCIHd5oTZpwLjsLsTePlRIZ75XpN7EGX4EbpMBF7xs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=JAawxfbUWlJbLV9OTXSB+4/66vS+wEWeYQUxY3Hj/3OgABIAwCr6asgM372+x0bqpyzKVAxUkWSTfBGdWiUvqwzjxaYLeRCPtCWcEBnhmYUjYLP6oo+hIyKVAZpYPduvMM0540Wv4olqELJpTxPtcEYiZ0+147W0FE9mtp7g7HE=
Received: by 10.78.140.16 with SMTP id n16mr1882399hud.1186508299438;
        Tue, 07 Aug 2007 10:38:19 -0700 (PDT)
Received: from grissom.local ( [84.201.153.164])
        by mx.google.com with ESMTPS id k9sm2952736nfh.2007.08.07.10.38.18
        (version=SSLv3 cipher=OTHER);
        Tue, 07 Aug 2007 10:38:18 -0700 (PDT)
User-Agent: KMail/1.9.7
In-Reply-To: <20070807135849.24926.qmail@49810ee852ce6e.315fe32.mid.smarden.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55267>

On Tuesday 2007, August 07, Gerrit Pape wrote:
> The post-receive-email hook usually gets its arguments through stdin,
> but also supports them to be specified at the command line.  The order
> of the arguments should consistently follow the documentation no matter
> how they are passed to the script.


As I said the last time this was posted, this was done on purpose so that 
the command line arguments match the order of the arguments to the update 
hook.

Keeping them in that order allows the script to be used as an update hook in 
older versions of git.

Whether that is sensible or not is for Junio and the gang to decide; but 
there was good reason for doing it that way.  Also, I'm not sure what 
documentation you're talking about - use in command line mode is a bonus 
feature anyway, it's not necessary in normal hook mode anyway.  If you're 
going to be strict about matching documentation then the command line mode 
should be removed.



Andy

-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
