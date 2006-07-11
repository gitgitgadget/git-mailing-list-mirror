From: sf <sf-gmane@stephan-feder.de>
Subject: Re: [PATCH 2/3] sha1_file: add the ability to parse objects in "pack
   file format"
Date: Tue, 11 Jul 2006 23:24:59 +0200
Message-ID: <44B4172B.3070503@stephan-feder.de>
References: <20060710230132.GA11132@hpsvcnb.fc.hp.com> <Pine.LNX.4.64.0607101623230.5623@g5.osdl.org> <20060711145527.GA32468@hpsvcnb.fc.hp.com> <Pine.LNX.4.64.0607111004360.5623@g5.osdl.org> <Pine.LNX.4.64.0607111010320.5623@g5.osdl.org>
Reply-To: sf-gmane@stephan-feder.de
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Jul 11 23:30:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G0Po2-0005Zl-V1
	for gcvg-git@gmane.org; Tue, 11 Jul 2006 23:30:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751321AbWGKVaG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 11 Jul 2006 17:30:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751325AbWGKVaG
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Jul 2006 17:30:06 -0400
Received: from main.gmane.org ([80.91.229.2]:52116 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751321AbWGKVaE (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Jul 2006 17:30:04 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1G0Pnu-0005Xa-A7
	for git@vger.kernel.org; Tue, 11 Jul 2006 23:30:02 +0200
Received: from ip-213157024137.dialin.heagmedianet.de ([213.157.24.137])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 11 Jul 2006 23:30:02 +0200
Received: from sf-gmane by ip-213157024137.dialin.heagmedianet.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 11 Jul 2006 23:30:02 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: ip-213157024137.dialin.heagmedianet.de
User-Agent: Thunderbird 1.5.0.4 (X11/20060606)
In-Reply-To: <Pine.LNX.4.64.0607111010320.5623@g5.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23737>

Linus Torvalds wrote:
> The pack-file format is slightly different from the traditional git
> object format, in that it has a much denser binary header encoding.
> 
> The traditional format uses an ASCII string with type and length
> information, which is somewhat wasteful.

And in the traditional format type and length are compressed whereas in
the pack-file format they are not.

> This should probably be applied to the main tree asap if we think
> this is at all a worthwhile exercise. But somebody should verify that I 
> got the format right first!

Sorry but see above.

Regards
	Stephan
