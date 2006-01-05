From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: use GIT_DIR instead of /var/tmp
Date: Thu, 5 Jan 2006 17:47:06 +0100
Message-ID: <81b0412b0601050847h1dcd5e81sd5eef3f03df6d1de@mail.gmail.com>
References: <81b0412b0601050352n386505bfjd40e515809e3c862@mail.gmail.com>
	 <43BD4B73.7010000@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 05 17:48:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EuYHA-0004Na-Kt
	for gcvg-git@gmane.org; Thu, 05 Jan 2006 17:47:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751153AbWAEQrm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Jan 2006 11:47:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751361AbWAEQrm
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jan 2006 11:47:42 -0500
Received: from nproxy.gmail.com ([64.233.182.206]:37451 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751153AbWAEQrl convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 5 Jan 2006 11:47:41 -0500
Received: by nproxy.gmail.com with SMTP id x37so142824nfc
        for <git@vger.kernel.org>; Thu, 05 Jan 2006 08:47:06 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GHS4nNzYHYS22EwMhjgnWUTg6WS10dOrIFOn/IMffCkdj4EMT/nWdDs+A157wBlcqF4op8fSKEgGaSknuc1qACLF9wHVHUz4LdGEBKRaS6z1VVhZuf3is8E7pYarpDVtbxoOTmFHc0tooKbr7RKLZhUUz3D8qWVw3jn1lsEprSM=
Received: by 10.48.247.14 with SMTP id u14mr701350nfh;
        Thu, 05 Jan 2006 08:47:06 -0800 (PST)
Received: by 10.48.248.4 with HTTP; Thu, 5 Jan 2006 08:47:06 -0800 (PST)
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <43BD4B73.7010000@zytor.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14205>

On 1/5/06, H. Peter Anvin <hpa@zytor.com> wrote:
> > Not every system (will not one microsoft windows system) have /var/tmp,
> > whereas using GIT_DIR for random temporary files is more or less established.
>
> Depends on what you're doing.  Only if you're writing to the repository.
>
> Windows will usually have $TMP and/or $TEMP, a lot of Unix apps honour
> $TMP_DIR.

Well, it never had TMP/TEMP by default for me (though I'd expect from people
installing git to set the thing properly), and it is usually undefined
everywhere else.
