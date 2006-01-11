From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: Proxy and authentication
Date: Thu, 12 Jan 2006 07:26:44 +1300
Message-ID: <46a038f90601111026j1fd6f8e2pcafb4437c4b458fe@mail.gmail.com>
References: <4615f4910601110653k5e2e8ffapb962a8b0829eeb11@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 11 19:27:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ewkgh-0008KT-LZ
	for gcvg-git@gmane.org; Wed, 11 Jan 2006 19:27:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964790AbWAKS0q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Jan 2006 13:26:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964788AbWAKS0p
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jan 2006 13:26:45 -0500
Received: from wproxy.gmail.com ([64.233.184.204]:63941 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964790AbWAKS0o convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jan 2006 13:26:44 -0500
Received: by wproxy.gmail.com with SMTP id i34so201846wra
        for <git@vger.kernel.org>; Wed, 11 Jan 2006 10:26:44 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=i+9nEIfkJe/s0HHIHjutGrImxCr4loFScQMGKIdYtaJvC9PtMldb5GLbj1AESzfnZ28ZE5VYh3yN2xIFxztRXBqqHBop4DYvtQdnRKOaojc5tkogdE5toiD5ShQjAUmTYu0D8D/QInWzF9nxAXFY8drisaSv2ehIQtv0tuORpjk=
Received: by 10.54.76.4 with SMTP id y4mr1260869wra;
        Wed, 11 Jan 2006 10:26:44 -0800 (PST)
Received: by 10.54.71.5 with HTTP; Wed, 11 Jan 2006 10:26:44 -0800 (PST)
To: Beber <beber.lkml@gmail.com>
In-Reply-To: <4615f4910601110653k5e2e8ffapb962a8b0829eeb11@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14495>

On 1/12/06, Beber <beber.lkml@gmail.com> wrote:
> Is there plan to allow proxy authentication and http/webdav remote
> repository authentication ?
> It seem that's it's quiet non-working for now.

search the list archives for more detail, but

  export http_proxy=http://my.proxy.tld:8080/
  git foo

should work. Have you tried embedding auth details in the url? Try
http://user:pass@my.proxy.tld:8080/

cheers,


martin
