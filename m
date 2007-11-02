From: Baz <brian.ewins@gmail.com>
Subject: Re: [PATCH 1/3] Implement parsing for new core.whitespace.* options.
Date: Fri, 2 Nov 2007 15:25:53 +0000
Message-ID: <2faad3050711020825y7d3ddc1et8d913e44d85ab989@mail.gmail.com>
References: <11940104611948-git-send-email-dsymonds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Junio C Hamano" <gitster@pobox.com>,
	"Andreas Ericsson" <ae@op5.se>
To: "David Symonds" <dsymonds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 02 16:27:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InyQA-0000zu-K2
	for gcvg-git-2@gmane.org; Fri, 02 Nov 2007 16:26:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753584AbXKBPZ4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Nov 2007 11:25:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753529AbXKBPZ4
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Nov 2007 11:25:56 -0400
Received: from rn-out-0910.google.com ([64.233.170.191]:34223 "EHLO
	rn-out-0102.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753584AbXKBPZz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Nov 2007 11:25:55 -0400
Received: by rn-out-0102.google.com with SMTP id s46so961167rnb
        for <git@vger.kernel.org>; Fri, 02 Nov 2007 08:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=wq4rPjsG7asmNKUq95ui7XJLx3Yjz7DAb4aKNdeBoN4=;
        b=KVeuAK6/DQfsnrtsKnsqW3svI1SVdjXJ1ZJVOJU7pQTiFMdZCdRd6dRgqliWl+t4ZW/if70Ejif7yV9Df+8gq0Eaw2xfyLnDJLeH1rYoLjGJn9Evwdr28SNDSAbaIb2X3QDeh7smYw/cQIoc3KHPuejlLKdTIBY9w5/dXG0KOFg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=t9XKxUxovVq2uMSa5g1do5g542ZYAVn1fC0y+dEpDsJwg3ymQSu01i8EZY9DBVoKpE6VkNdbn+/41r5QL+9AD8F1xMxBJiRZj/49aKaPhx3ZgMp9TyVO5asdWEmT9LS7ZQN5j1GtQiMTvVf7pD2pxEfPuN9BE/aa/A7oeXjv09U=
Received: by 10.142.158.17 with SMTP id g17mr507996wfe.1194017153562;
        Fri, 02 Nov 2007 08:25:53 -0700 (PDT)
Received: by 10.142.43.18 with HTTP; Fri, 2 Nov 2007 08:25:53 -0700 (PDT)
In-Reply-To: <11940104611948-git-send-email-dsymonds@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63130>

On 02/11/2007, David Symonds <dsymonds@gmail.com> wrote:
> Each of the new core.whitespace.* options (enumerated below) can be set to one
> of:
>         * okay (default): Whitespace of this type is okay
>         * warn: Whitespace of this type should be warned about
>         * error: Whitespace of this type should raise an error
>         * autofix: Whitespace of this type should be automatically fixed

Sorry, this is a bit bikesheddy, but shouldn't that be 'fix' rather
than autofix? Otherwise you might want to rename the others
'autowarn', 'autookay' etc... since the computer does them
automatically too.

Cheers,
Baz
