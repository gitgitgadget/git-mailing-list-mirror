From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: ks/precompute-completion
Date: Fri, 13 Nov 2009 01:06:52 -0600
Message-ID: <20091113070652.GA3907@progeny.tock>
References: <7vbpj9s8vk.fsf@alter.siamese.dyndns.org>
 <fabb9a1e0911110957k599ac3dfmd1a44a0499c72b2d@mail.gmail.com>
 <20091111220832.GA31620@progeny.tock>
 <4AFCFF50.5080401@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kirill Smelkov <kirr@mns.spb.ru>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <junio@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 13 07:56:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8q5J-0007wn-I2
	for gcvg-git-2@lo.gmane.org; Fri, 13 Nov 2009 07:56:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753991AbZKMG43 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Nov 2009 01:56:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752987AbZKMG42
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Nov 2009 01:56:28 -0500
Received: from mail-gx0-f228.google.com ([209.85.217.228]:47334 "EHLO
	mail-gx0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751981AbZKMG42 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Nov 2009 01:56:28 -0500
Received: by gxk28 with SMTP id 28so986075gxk.9
        for <git@vger.kernel.org>; Thu, 12 Nov 2009 22:56:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=H+a4up2ak6kwZ6yEUp4I1WVz9WaLdenkNFBY/deahx4=;
        b=cdK3OiaFOaqAC5pd+uWh7wTbv+YwqBgcpfzdMN1d3LY6kPFPikY7/0pkmxHU3QcQYN
         focyXreUaYVQiIZrNE028tNbE1zGctm+PhF5giIHl3RgJ5k2ZmXD8vLkQuN+kmxht7Az
         Oty70mYdShsk3Vs5jtqy/pPhc707B8W4mu1Hw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=EthBEpLK7dJXxfpCDpPv/gF4G9NOt0oqohjN0vNKyFGp16mCd3ueeQ6AMXFp8IqBBG
         uv24XMLQHQGuR7Kv88bDMFxdEGPy5w3hqvWLMnQ8I25AOuggddQYY2lKeC9MQ6FgTWGl
         8MK02LMCyQVTp3oQQZwNjaT0nswJWPkgcfl+U=
Received: by 10.100.59.5 with SMTP id h5mr4188543ana.83.1258095393573;
        Thu, 12 Nov 2009 22:56:33 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 22sm348455yxe.21.2009.11.12.22.56.32
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 12 Nov 2009 22:56:32 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4AFCFF50.5080401@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132818>

Stephen Boyd wrote:
> Jonathan Nieder wrote:
>>
>>As a distro user, I don't think I would be able to use it until there
>>is a command to update the installed completion, to call after adding
>>a new git command to my $PATH.  This could mean:
[...]
> I'm confused. Shouldn't your distro take care of updating the
> completion for you? And wouldn't update-git-completion be more
> suited as part of a makefile if it was needed at all?

The problem is that I have git commands the distro did not install in
my $PATH.  For example, I currently have git-new-workdir in ~/bin, and
once I bzr-fastexport works a little better, I will install git-bzr.

Even without such commands, in many distributions the completion
should not be one size fits all, since git-svn (for example) belongs
to a different package.

I would expect the distribution to take care of populating the initial
completion list and updating it on upgrades.

Jonathan
