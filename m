From: Bryan Larsen <bryan.larsen@gmail.com>
Subject: cogito Mac OS X compatibility
Date: Fri, 08 Jul 2005 19:34:55 -0400
Message-ID: <42CF0D9F.8040909@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sat Jul 09 01:37:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dr2Ox-0006FQ-0y
	for gcvg-git@gmane.org; Sat, 09 Jul 2005 01:36:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262931AbVGHXg0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Jul 2005 19:36:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262969AbVGHXgY
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jul 2005 19:36:24 -0400
Received: from zproxy.gmail.com ([64.233.162.206]:58472 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262931AbVGHXe7 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Jul 2005 19:34:59 -0400
Received: by zproxy.gmail.com with SMTP id i28so243543nzi
        for <git@vger.kernel.org>; Fri, 08 Jul 2005 16:34:57 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:subject:content-type:content-transfer-encoding;
        b=X6oPfK7LZcgt5+4o9XlaVjCITImqJGDd8+SO3K+Rj+1Zj5aeM3JfN9+PmxRWJ9Rdlw+Jm0UOFxge2rpMabN8j2GdZhcplJVjL5td89PcaqPsqNx6oHFl/rgMTstZhybaZ5TpOuLxca0muf1LJem7PpXtbTDdtVaSjCkjDZwFlJ4=
Received: by 10.36.25.19 with SMTP id 19mr779228nzy;
        Fri, 08 Jul 2005 16:34:57 -0700 (PDT)
Received: from ?192.168.1.104? ([70.26.43.137])
        by mx.gmail.com with ESMTP id 24sm881608nzn.2005.07.08.16.34.57;
        Fri, 08 Jul 2005 16:34:57 -0700 (PDT)
User-Agent: Mozilla Thunderbird 1.0.2 (Macintosh/20050317)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Mac OS X

$ cg-clone http://www.kernel.org/pub/scm/cogito/cogito.git
defaulting to local storage area
19:11:10 
URL:http://www.kernel.org/pub/scm/cogito/cogito.git/refs/heads/master 
[41/41] -> "refs/heads/origin" [1]
/Users/blarsen/bin/cg-pull: line 82: 0 + : syntax error: operand 
expected (error token is " ")
cg-pull: objects pull failed
cg-init: pull failed

This appears to be some sort of weird shell thing.  I've got bash 3.0 
compiling in the background to see if that fixes the problem.

Cogito also appears to rely on the gnu tools.  For instance, I've seen 
the "-a" flag used with cp.  OS X's default installation of cp doesn't 
support -a.  darwinports coreutils installs gnu cp as "gcp".

Myself, I can't live without cp -a, so have linked gcp to cp, but I 
presume we want to be portable, at least to a certain degree.

Bryan
