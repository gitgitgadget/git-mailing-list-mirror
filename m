From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: git-status -- trying to understand all possible states
Date: Tue, 1 Apr 2014 15:20:02 -0700
Message-ID: <20140401222002.GD6851@google.com>
References: <4AF06B83-E928-4FE2-8094-F23CE3BA1EBC@toyland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Toy <michael@toyland.org>
X-From: git-owner@vger.kernel.org Wed Apr 02 00:20:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WV72T-0007Zx-Is
	for gcvg-git-2@plane.gmane.org; Wed, 02 Apr 2014 00:20:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751816AbaDAWUH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Apr 2014 18:20:07 -0400
Received: from mail-pb0-f48.google.com ([209.85.160.48]:60800 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751709AbaDAWUG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Apr 2014 18:20:06 -0400
Received: by mail-pb0-f48.google.com with SMTP id md12so10537206pbc.35
        for <git@vger.kernel.org>; Tue, 01 Apr 2014 15:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=gCMrrJHEaAmSPdycl+kYBu5vC1MuNi6eWUbXofdOxIc=;
        b=oY4wtm094PKJATIxuF1AJuui2gZLyJua9RbCN9wjjNFyCNICvTKQly7a44ZKlofpMk
         /gH04pud7vuntzCVUeFAHp3lLemOKtOULUnzTlYA9C+yuNxAERGoPJV1tAj2+bSTro2V
         9QcOgHjbLRkwwA2lqJN2B5kxM4Ch9lBOLU3YFCv3zPSjXyxL/yafR44cjMXXljnYIVKY
         bG85BaJLVuyMUvsWDXaLhpzjXxyHm9tGbT2dqOP3oq5TcfsQlsf6Hs3fcw+aRC+WlJ5Y
         S3ECzNZx/c95VHkVHixtbMcnChU9gYXhk/4defzKFVZdQkIahpMu/sUK//cuhIr9WJDx
         pvEw==
X-Received: by 10.68.236.229 with SMTP id ux5mr33572143pbc.98.1396390805233;
        Tue, 01 Apr 2014 15:20:05 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id aj7sm61564717pad.29.2014.04.01.15.20.04
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 01 Apr 2014 15:20:04 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4AF06B83-E928-4FE2-8094-F23CE3BA1EBC@toyland.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245665>

Michael Toy wrote:

> https://gist.github.com/the-michael-toy/9907309

Two nits:

 - Please use --porcelain (implied by -z in the absence of another
   format option) instead of --short.  --short is meant to be human
   readable and details of the output might change some day.

 - Depending on what you're trying to do, you might find the output
   from other commands such as "git ls-files -s" or "git diff-files"
   easier to work with.

Hope that helps,
Jonathan
