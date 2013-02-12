From: John Keeping <john@keeping.me.uk>
Subject: Re: Improve 'git help' with basic user guide linkss
Date: Tue, 12 Feb 2013 11:37:31 +0000
Message-ID: <20130212113731.GA13501@farnsworth.metanate.com>
References: <6D91D31A093D46869F43DD8D1012F0FB@PhilipOakley>
 <7vr4kqzfw5.fsf@alter.siamese.dyndns.org>
 <6BC280F5827C4098BCB6276232DDE8E4@PhilipOakley>
 <7v6222za9x.fsf@alter.siamese.dyndns.org>
 <27C7EA38DDD345F994F01E5B8FB6D278@PhilipOakley>
 <2DFA2C4F62AE484681753EBC3774D222@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Tue Feb 12 12:38:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U5EBW-0005pE-AJ
	for gcvg-git-2@plane.gmane.org; Tue, 12 Feb 2013 12:38:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933009Ab3BLLhi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2013 06:37:38 -0500
Received: from dougal.metanate.com ([90.155.101.14]:17457 "EHLO metanate.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932877Ab3BLLhi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2013 06:37:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=simple/simple; d=metanate.com; s=stronger;
	h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=FOop4HQck0NIsktxdMkB1Rtdnn8X0NB4wEl2obsE6f8=;
	b=BS+ouikdTXtTxZVqJKPWkwRBfBFHsfhtWZL1b2PWBAv2Z3n55mc3FnESdAbdESEh09FEdbc5IGjXOBIurM3c3JLRqWJd5aZ31iYEmG20k93KC1XFuWtZxI5pH0iSMJ+zHJ+LJKEP8CZQPuiBbRdvItIKa7hx5fV984ZnN0dIDKLvNlGiVe/BIG5Tzkd7FsWezIaQIofn5emrTkaM/jbLJkskeCiz3BZDAmOc8zdOcvMGNkAURrOLaL3RUvr+Dl8A6pMQVr0nNDCjNq54fTmnzhEnQOqCXaYLZhKYywWOzRQCpj30kryFRfTAjNwh7TluGM1yT81sMUN70g2I8i/5bQ==;
Received: from brian.metanate.com ([192.168.88.1] helo=farnsworth.metanate.com)
	by shrek.metanate.com with esmtps (TLSv1:DHE-RSA-AES128-SHA:128)
	(Exim 4.80.1)
	(envelope-from <john@keeping.me.uk>)
	id 1U5EB0-00046j-Qi; Tue, 12 Feb 2013 11:37:30 +0000
Content-Disposition: inline
In-Reply-To: <2DFA2C4F62AE484681753EBC3774D222@PhilipOakley>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216148>

On Tue, Feb 12, 2013 at 11:11:17AM -0000, Philip Oakley wrote:
> Obviously (?) this is generated from the command-list.txt file, though I 
> don't see a shell script that would generate the 
> 'cmds-mainporcelain.txt' (etc.) files 
> (//github.com/gitster/git-htmldocs). They are also part of the msysgit 
> install.
> 
> Where should I be looking to see how they are generated?

Documentation/cmd-list.perl

If you look in Documentation/Makefile, cmds-mainporcelain.txt is a
member of cmds_txt, which depends on cmd-list.made, which is a stamp
file created after invoking cmd-list.perl.


John
