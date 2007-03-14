From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [GIT PULL] Please pull mergetool.git
Date: Wed, 14 Mar 2007 10:55:37 +0100
Message-ID: <81b0412b0703140255j1d49cf0cpea69d381ec8a0a4c@mail.gmail.com>
References: <E1HRI5K-0008T9-9e@candygram.thunk.org>
	 <7vtzwob1lo.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Theodore Ts'o" <tytso@mit.edu>, git@vger.kernel.org
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Mar 14 10:56:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HRQDQ-0005hj-Ii
	for gcvg-git@gmane.org; Wed, 14 Mar 2007 10:56:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030835AbXCNJ4N (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Mar 2007 05:56:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030836AbXCNJ4N
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Mar 2007 05:56:13 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:52166 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030835AbXCNJ4N (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Mar 2007 05:56:13 -0400
Received: by nf-out-0910.google.com with SMTP id o25so145955nfa
        for <git@vger.kernel.org>; Wed, 14 Mar 2007 02:56:12 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QfLueZzSPHMRRZRng4VVWb4++iARd8fnxr/e7oaLfAoEV5h0x0wuZNrCfUqeF0AIRr7ve8batABfWHFwzMlpyUUPp+24SE6ORbHzizHzHvJ1dh/H6HOEdWnEFRU4Qz68os1dEvHfufbqWbRxng04WXQAMlABwUtjb7tT9KXNM7E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HSIcLJIMn5pfRJ5Tew4IvU+rYD/8VvZelEjIWipr4MO20Qn3HmiabqA4I40EOiob2yYlZICYOaiuUW8hMfjp7LH650Dd78cqB5tkfXoHjaXALdfOZTdX3jggA0Pxl8s3qitazeOgx2k+9hZktKPj2LPZ4Q6QHqUmd4QjAS1Dnk4=
Received: by 10.78.172.20 with SMTP id u20mr1047482hue.1173866137961;
        Wed, 14 Mar 2007 02:55:37 -0700 (PDT)
Received: by 10.78.138.5 with HTTP; Wed, 14 Mar 2007 02:55:37 -0700 (PDT)
In-Reply-To: <7vtzwob1lo.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42195>

On 3/14/07, Junio C Hamano <junkio@cox.net> wrote:
> So here it is.
>
>  - An .gitignore entry to ignore the build product.
>
>  - An Makefile entry to build and clean.
>

- If the "product" has own Makefile: QUIET support (aka "V=x")
