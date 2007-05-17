From: "=?UTF-8?Q?Kristian_H=C3=B8gsberg?=" <krh@bitplanet.net>
Subject: Re: Commit ID in exported Tar Ball
Date: Thu, 17 May 2007 13:02:26 -0400
Message-ID: <59ad55d30705171002m503feb17l64fea9ffe2cf2297@mail.gmail.com>
References: <20070517163803.GE4095@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: GIT <git@vger.kernel.org>,
	"Michael Gernoth" <simigern@cip.informatik.uni-erlangen.de>
To: "Thomas Glanzmann" <thomas@glanzmann.de>
X-From: git-owner@vger.kernel.org Thu May 17 19:02:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HojN4-0006rR-32
	for gcvg-git@gmane.org; Thu, 17 May 2007 19:02:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754561AbXEQRC2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 May 2007 13:02:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754649AbXEQRC2
	(ORCPT <rfc822;git-outgoing>); Thu, 17 May 2007 13:02:28 -0400
Received: from nz-out-0506.google.com ([64.233.162.226]:5967 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754561AbXEQRC1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 May 2007 13:02:27 -0400
Received: by nz-out-0506.google.com with SMTP id r28so1027583nza
        for <git@vger.kernel.org>; Thu, 17 May 2007 10:02:27 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=TdKAQvhPA65hNLzbyiBcvEJ0iOQQBC1GbZQOTV6QHB0YTjDCifelAndyI0S48G0LN7t1FIRKoMHDp92kI5l67Z68b17P1fNuhe3bDL7uiTWUkOrPo1o7bs31QGvvVy+UeGsTyHHqby0jV0mP3cIzpM+2Cj17jYSUM3hiL6vDYDU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=diofSyltdysjfxcJHP51SmVTSTzG0avN6FLhcfOcd+Vxq5quU+R13X4GOmtmgJLl561xi721MK5CCDkJUbDE0EMIzqrEmo1HeEGzbyJGNznv/rag0cZth2dmZmosBj8YzmS1oJXfJ7N1QUP3OlDCe3YMP5HiIkXGmvjAXwdDfRc=
Received: by 10.114.58.1 with SMTP id g1mr305631waa.1179421346840;
        Thu, 17 May 2007 10:02:26 -0700 (PDT)
Received: by 10.114.107.20 with HTTP; Thu, 17 May 2007 10:02:26 -0700 (PDT)
In-Reply-To: <20070517163803.GE4095@cip.informatik.uni-erlangen.de>
Content-Disposition: inline
X-Google-Sender-Auth: 874783208f7ac7db
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47539>

On 5/17/07, Thomas Glanzmann <thomas@glanzmann.de> wrote:
> Hello,
> Michae, a friend of mine, is in the phase of migrating from git to cvs.
> He releases tar balls of his software project using gitweb. He would
> love to have a way to have the commit-id of HEAD of the export contained
> in one of the files he exported that way. Is there infrastructure in git
> that makes that already possible or does he need to some kind of
> gerneration tool by himself? Maybe it would be helpful if the
> git-tar-tree would generate a file .commitid or something like that in
> the generated tar tree.

Use git-get-tar-commit-id:

  $ gzip -cd snapshot.tar.gz | git-get-tar-commit-id

cheers,
Kristian
