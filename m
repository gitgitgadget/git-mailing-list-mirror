From: dennis <dennis.yxun@gmail.com>
Subject: [question] git svn fail to fetch GCC source due to index mismatch
Date: Sat, 08 Nov 2008 04:24:51 +0800
Message-ID: <4914A413.80301@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 08 13:26:32 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kymta-0006Gu-4m
	for gcvg-git-2@gmane.org; Sat, 08 Nov 2008 13:26:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753191AbYKHMZC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Nov 2008 07:25:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753153AbYKHMZB
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Nov 2008 07:25:01 -0500
Received: from ti-out-0910.google.com ([209.85.142.189]:17816 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753122AbYKHMZB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Nov 2008 07:25:01 -0500
Received: by ti-out-0910.google.com with SMTP id b6so939129tic.23
        for <git@vger.kernel.org>; Sat, 08 Nov 2008 04:24:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:content-type
         :content-transfer-encoding;
        bh=gws4ePyqsd2GKq9jHlSy5a9J5Dw8RVJDF/g0L2zMCtI=;
        b=iSyEsMTi+v/vcvVEiYoIsnMnfclW7lZeBhGd5AdP7Nks5zknpWJrN1JkfWcUsB7xyU
         heYweHR1gsk6kANZJR+tnAp+7III1BlU7WL/L7X8V2wQr6JT222oTPxZHz3bsZmVpuyT
         NlJaZY2veA++MeJM2xeZ3OUkdwG2da/QRG8qg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        b=lE8lD7m4MvHTMn4Z+0GPMeyJT1TCPDFVY1fXX0KqY8NQsShA2ZNjMhsczmCJauVTwh
         yO3pHU1D8NSoqe0YgN0LZUsBiTTxhZagyS6CUYBTyRAlo3Wsy2gJlq4jbb9Xce0sgXSM
         BokZAlSSlAkPLrc4r+t/N6LV0vE0MRejHOQ8Y=
Received: by 10.110.105.5 with SMTP id d5mr5116411tic.37.1226147099500;
        Sat, 08 Nov 2008 04:24:59 -0800 (PST)
Received: from ?192.168.0.18? ([222.65.132.11])
        by mx.google.com with ESMTPS id u12sm4293049tia.3.2008.11.08.04.24.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 08 Nov 2008 04:24:59 -0800 (PST)
User-Agent: Thunderbird 2.0.0.17 (X11/20081005)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100400>

HI:
   I have problem when use git svn fetch command to
retrieve the GCC source code.
It says index mismatch, then  abort,  any suggestion?

  
$git svn fetch
Index mismatch: 98ba56dbceddf50ebfab9e4649e9b1b1a319b377 !=
4f40f4619690f89454614be0eba63d584d25523e
rereading 19e22aa4cbc9f7e3667243481f33c859e3bba358
Found possible branch point: svn://gcc.gnu.org/svn/gcc/trunk =>
svn://gcc.gnu.org/svn/gcc/trunk, 130802
Initializing parent: git-svn@130802
Found branch parent: (git-svn) 9a08076e1ad241080838d547f64a2a9aceb083ca
Index mismatch: 4f40f4619690f89454614be0eba63d584d25523e !=
98ba56dbceddf50ebfab9e4649e9b1b1a319b377
rereading 9a08076e1ad241080838d547f64a2a9aceb083ca
Following parent with do_switch
Malformed network data: Malformed network data at
/usr/libexec/git-core/git-svn line 2340

$git branch -a
git-svn
git-svn@130802
 
