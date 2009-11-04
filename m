From: Vietor Liu <vietor@vxwo.org>
Subject: Re: Common setting for interoperability repo across windows and
 unix?
Date: Wed, 04 Nov 2009 08:46:18 +0800
Message-ID: <1257295578.2212.4.camel@localhost.localdomain>
References: <c94f8e120911030709h29c5b8edr53df269632990e81@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: Dilip M <dilipm79@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 04 01:43:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5Txu-0004lY-Ft
	for gcvg-git-2@lo.gmane.org; Wed, 04 Nov 2009 01:43:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752537AbZKDAm7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Nov 2009 19:42:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752265AbZKDAm6
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Nov 2009 19:42:58 -0500
Received: from ey-out-2122.google.com ([74.125.78.27]:28207 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752055AbZKDAm6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Nov 2009 19:42:58 -0500
Received: by ey-out-2122.google.com with SMTP id d26so787851eyd.19
        for <git@vger.kernel.org>; Tue, 03 Nov 2009 16:43:02 -0800 (PST)
Received: by 10.216.86.212 with SMTP id w62mr224833wee.131.1257295382543;
        Tue, 03 Nov 2009 16:43:02 -0800 (PST)
Received: from ?192.168.254.104? ([114.244.46.33])
        by mx.google.com with ESMTPS id g11sm1738751gve.20.2009.11.03.16.42.58
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 03 Nov 2009 16:43:01 -0800 (PST)
In-Reply-To: <c94f8e120911030709h29c5b8edr53df269632990e81@mail.gmail.com>
X-Mailer: Evolution 2.28.0 (2.28.0-2.fc12) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132013>

On Tue, 2009-11-03 at 20:39 +0530, Dilip M wrote:
> Hello,
> 
> I have repo in unix. The same repo is cloned onto windows.I have set
> "core.autocrlf=input" in both the repos.
> 
> When I do some change to a file in windows and push to unix repo, I
> get file deleted If I do "git status"?
> 
> What is the setting to be done if I want an repo to be
> access/push/pulled across windows and unix?
> 
> 
> 

msysgit, test:

 core.autocrlf=false
