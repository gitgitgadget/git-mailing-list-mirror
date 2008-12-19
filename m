From: "C. Scott Ananian" <cscott@laptop.org>
Subject: Re: [PATCH] Simplified GIT usage guide
Date: Thu, 18 Dec 2008 19:47:12 -0500
Message-ID: <c6d9bea0812181647n55fbb6b9w333702fc80127198@mail.gmail.com>
References: <20081212182827.28408.40963.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, linux-kernel@vger.kernel.org
To: "David Howells" <dhowells@redhat.com>
X-From: git-owner@vger.kernel.org Fri Dec 19 01:48:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDTXe-0007fy-Bg
	for gcvg-git-2@gmane.org; Fri, 19 Dec 2008 01:48:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752356AbYLSArO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Dec 2008 19:47:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752276AbYLSArO
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Dec 2008 19:47:14 -0500
Received: from rv-out-0506.google.com ([209.85.198.232]:9660 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750753AbYLSArN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Dec 2008 19:47:13 -0500
Received: by rv-out-0506.google.com with SMTP id k40so658932rvb.1
        for <multiple recipients>; Thu, 18 Dec 2008 16:47:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=/kqjlcURylyoXxs4lcfFu7HfIcKSmKEQUnRQITuLiHM=;
        b=vZ3fQqUHR7Ua7qamZomW9i8hos9Fi7Ia3KqdAm4B5imdAdb7q38A2bT9PJ2fNHYNkr
         v/VYTH1/etbi9buJ2Dvs7e8ntRWod7pizu+2EcCMo1rh/U/NRcKMHfnq4pcnZEtHL1bV
         RHyxVleUjVehT5SfTwRR652ssaaJq1o/n6eNI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=ueYJgsiTVP2zWtmkp6G8ohY1AeiGnBjrbvEIa86RNyWymqfdFeoSRZRaobDG+Op1Ga
         S2TFCxVydukoJ8Iur3StdY2ZB1BgVR2mGNgPtN9yfExrc1MkzgEJpvfWcQJtVl974aZG
         dHTc8k064/sZ4DQraVQYara3X+wv+7a3NpsYE=
Received: by 10.141.26.19 with SMTP id d19mr1257783rvj.184.1229647632225;
        Thu, 18 Dec 2008 16:47:12 -0800 (PST)
Received: by 10.141.34.13 with HTTP; Thu, 18 Dec 2008 16:47:12 -0800 (PST)
In-Reply-To: <20081212182827.28408.40963.stgit@warthog.procyon.org.uk>
Content-Disposition: inline
X-Google-Sender-Auth: 6ea204e53f7bbc54
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103522>

On Fri, Dec 12, 2008 at 1:28 PM, David Howells <dhowells@redhat.com> wrote:
> Add a guide to using GIT's simpler features.
> diff --git a/Documentation/git-haters-guide.txt b/Documentation/git-haters-guide.txt
> +In the above example, I've assumed that you've got your own tree with the head
> +at commit C3, and that you've got a branch that you want to merge, which has
> +its head at commit B3.  After merging them, you'd end up with a directed,
> +cyclic tree:

That should be, "acyclic".  There are no cycles, because the graph is directed.
  --scott

-- 
                         ( http://cscott.net/ )
