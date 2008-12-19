From: "Dilip M" <dilipm79@gmail.com>
Subject: Re: Git with Hudson
Date: Fri, 19 Dec 2008 10:28:46 +0530
Message-ID: <c94f8e120812182058j7d425dd7n80dc283a776a0596@mail.gmail.com>
References: <D2F0F023-862A-4BAB-88B9-BFEFC5592D10@strakersoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 19 06:00:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDXT6-0006WH-T8
	for gcvg-git-2@gmane.org; Fri, 19 Dec 2008 06:00:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752384AbYLSE6s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Dec 2008 23:58:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752322AbYLSE6s
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Dec 2008 23:58:48 -0500
Received: from rn-out-0910.google.com ([64.233.170.188]:23993 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752253AbYLSE6r (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Dec 2008 23:58:47 -0500
Received: by rn-out-0910.google.com with SMTP id k40so628718rnd.17
        for <git@vger.kernel.org>; Thu, 18 Dec 2008 20:58:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=wQ4YeAVbxQ8BZm1zy17Bh8cYoKwsl2Hp7PDR2WXICfA=;
        b=EYLMNk4UQ5bkGfe6Vhkhia8SzgTBvJGCofidGakIMpTnCd+COIhbdscGs8mQpONNAL
         0DJcgvW0xW1hQ4lKJVLPaN3bGZE8OyQT3PQJNp9IKY2g831wxxs2GY4lGBLiJzd6GZYw
         o94QRoFhf+DuSAsaJ/giYjE2bKYPHglqRbhfQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=h7gWDJXu9tfSbnF6zTUpqxrzmlPMxzAr+dE7AhDCDEXNUxhAeQBbWzhGVmt75KPqCK
         gdlzBmdFxSt4KoLzD/ojl9hF7VTmIcA9LJD3lYFKkmsAFz3FqKqZHBhktS5VtELoOqez
         9GbPry0F1vlDNzvywhrOvn9AexjtDeBKUzVGI=
Received: by 10.100.57.13 with SMTP id f13mr1984912ana.143.1229662726241;
        Thu, 18 Dec 2008 20:58:46 -0800 (PST)
Received: by 10.100.109.4 with HTTP; Thu, 18 Dec 2008 20:58:46 -0800 (PST)
In-Reply-To: <D2F0F023-862A-4BAB-88B9-BFEFC5592D10@strakersoftware.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103544>

On Fri, Dec 19, 2008 at 12:53 AM, <indy@strakersoftware.com> wrote:
On Fri, Dec 19, 2008 at 3:37 AM, <stephen@exigencecorp.com> wrote:

indy> However, before we do that I wanted to check if anyone has had any
indy> experience/feedback in integrating Git with Hudson CI server?

We want to try it in futrure when GIT will be used for some projects. It
will be nice to share the knowledge on hudson tool. :)

B.W, what version of hudson you are using? Java version? TOMCAT
version?

It is stable?  Have you seen something like "(appears to be stuck)
entries"...

stephen> We eventually wrote our own Hudson git plugin that is simpler and
stephen> doesn't do any funny rev-listing/walking. It just stores last hash
stephen> built and rebuilds once that doesn't match the branch tip. Once that
stephen> was in place, it worked great.

I am eager to have it..please publish.

-dm
