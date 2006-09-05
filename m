From: "Torgil Svensson" <torgil.svensson@gmail.com>
Subject: stgit bisect feature request
Date: Wed, 6 Sep 2006 01:49:15 +0200
Message-ID: <e7bda7770609051649j56a92085i8d8a73ab12004c43@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Sep 06 01:49:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GKkfR-0000fV-Lw
	for gcvg-git@gmane.org; Wed, 06 Sep 2006 01:49:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932247AbWIEXtS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 5 Sep 2006 19:49:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932246AbWIEXtS
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Sep 2006 19:49:18 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:13152 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932247AbWIEXtR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Sep 2006 19:49:17 -0400
Received: by nf-out-0910.google.com with SMTP id o25so90865nfa
        for <git@vger.kernel.org>; Tue, 05 Sep 2006 16:49:15 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=V6XUm9J5LrhaR3CYJNeOnVlT75TwkvIMGz+cXbweHO7tDFqjACra7monmvqCVyMocBXKxpVF44LnwBTg8f2YrFIuJOUtl6wbbtTo1+aesVXDqCuQh/NwRfavwubJu446jpLYuu4dQAgSOK59UkyL3UO+1+WqyNb282tfgnVU22w=
Received: by 10.49.75.2 with SMTP id c2mr102473nfl;
        Tue, 05 Sep 2006 16:49:15 -0700 (PDT)
Received: by 10.49.26.9 with HTTP; Tue, 5 Sep 2006 16:49:15 -0700 (PDT)
To: git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26498>

I think i'd be nice if stgit wraps bisect and you could write
$ stg bisect start
$ stg bisect bad
$ stg bisect good ORIG_HEAD

and after bisect checks out the files it pushes the current stack as
if you had used stg pull at this point

//Torgil
