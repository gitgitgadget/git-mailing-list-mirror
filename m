From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: Versioning file system
Date: Tue, 19 Jun 2007 21:09:58 +1200
Message-ID: <46a038f90706190209h7cbde42h34d6ac819711c3d3@mail.gmail.com>
References: <OF7FA807A1.64C0D5AF-ON882572FE.0061B34C-882572FE.00628322@us.ibm.com>
	 <6E9A6F9E-8948-40F2-9129-1F1491D49D83@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Bryan Henderson" <hbryan@us.ibm.com>,
	"Jack Stone" <jack@hawkeye.stone.uk.eu.org>,
	"Andrew Morton" <akpm@linux-foundation.org>,
	alan <alan@clueserver.org>, "H. Peter Anvin" <hpa@zytor.com>,
	linux-fsdevel@vger.kernel.org,
	"LKML Kernel" <linux-kernel@vger.kernel.org>,
	"Al Viro" <viro@zeniv.linux.org.uk>, git@vger.kernel.org
To: "Kyle Moffett" <mrmacman_g4@mac.com>
X-From: git-owner@vger.kernel.org Tue Jun 19 11:10:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I0Ziw-0004xb-D6
	for gcvg-git@gmane.org; Tue, 19 Jun 2007 11:10:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755179AbXFSJKE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Jun 2007 05:10:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755257AbXFSJKD
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Jun 2007 05:10:03 -0400
Received: from wx-out-0506.google.com ([66.249.82.237]:22332 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754936AbXFSJJ7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jun 2007 05:09:59 -0400
Received: by wx-out-0506.google.com with SMTP id t15so1763108wxc
        for <git@vger.kernel.org>; Tue, 19 Jun 2007 02:09:59 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bfzLTL6P9bqYNTZIA5J5T25HIXwDwJfNxB+L8j4SSYH6M1kbYqe9+j0moEd0JvhXpx5ZZd43q9XETqoPfNBfEaHXqy7k0ZYN9EELqBHIydCRdd9wjdm1npkmw6a9ktif991C7OqCUAvscvwDAN1B0pAywKv7DxgfIBAFfhEOO/A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NQXjdJ5bsHgQGydhUpP/FOChcLJkAYahagOYHNISKfqtaJaB8yykgkfaLd+YpbsZ7JrssEo2IGGX9z80ekVGDYUG10OePKQ38229Vka/59WZJ2o+WTe4Q7Z0uEJEKFZPaendy6ZjMPe6Xy5MKIPZZng7E99SAVYUCOswD/TUDK0=
Received: by 10.90.79.6 with SMTP id c6mr4566895agb.1182244198952;
        Tue, 19 Jun 2007 02:09:58 -0700 (PDT)
Received: by 10.90.52.9 with HTTP; Tue, 19 Jun 2007 02:09:58 -0700 (PDT)
In-Reply-To: <6E9A6F9E-8948-40F2-9129-1F1491D49D83@mac.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50460>

On 6/19/07, Kyle Moffett <mrmacman_g4@mac.com> wrote:
> What I think would be particularly interesting in this domain is
> something similar in concept to GIT, except in a file-system:

perhaps stating the blindingly obvious, but there was an early
implementation of a FUSE-based gitfs --
http://www.sfgoth.com/~mitch/linux/gitfs/

cheers,


martin
