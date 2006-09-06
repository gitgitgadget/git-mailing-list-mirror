From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: A look at some alternative PACK file encodings
Date: Wed, 6 Sep 2006 19:23:16 -0400
Message-ID: <9e4733910609061623k73086dbey4a600ecf2852c024@mail.gmail.com>
References: <44FF41F4.1090906@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 07 01:23:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GL6jr-0004OD-Aj
	for gcvg-git@gmane.org; Thu, 07 Sep 2006 01:23:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030201AbWIFXXT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Sep 2006 19:23:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030204AbWIFXXT
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Sep 2006 19:23:19 -0400
Received: from py-out-1112.google.com ([64.233.166.182]:59335 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1030201AbWIFXXR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Sep 2006 19:23:17 -0400
Received: by py-out-1112.google.com with SMTP id n25so15528pyg
        for <git@vger.kernel.org>; Wed, 06 Sep 2006 16:23:16 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rP61bZcXXDyPORycEXiB+TJXapGwMXyc+yKp/kPPITgbwly2x3RBgVUhr1SZalLG0V0K0/nGmRX5KbEQT8gtlvtj0OX9Xnm3sy6tr91i9Dcyp/1FBZDMr4dKXB43neybsUEjU1C80LPa5Jf035fQ/1+4tX7e1v/uRF9SbtBY3mg=
Received: by 10.35.128.1 with SMTP id f1mr13104pyn;
        Wed, 06 Sep 2006 16:23:16 -0700 (PDT)
Received: by 10.35.60.14 with HTTP; Wed, 6 Sep 2006 16:23:16 -0700 (PDT)
To: gitzilla@gmail.com
In-Reply-To: <44FF41F4.1090906@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26569>

On 9/6/06, A Large Angry SCM <gitzilla@gmail.com> wrote:
> TREE objects do not delta or deflate well.

I can understand why they don't deflate, the path names are pretty
much unique and the sha1s are incompressible. By why don't they delta
well? Does sorting them by size mess up the delta process?

Shawn is doing some prototype work on true dictionary based
compression. I don't know how far along he is but it has potential for
taking 30% off the Mozilla pack.

-- 
Jon Smirl
jonsmirl@gmail.com
