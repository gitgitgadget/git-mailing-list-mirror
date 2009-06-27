From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv6 4/8] gitweb: (gr)avatar support
Date: Fri, 26 Jun 2009 17:29:13 -0700
Message-ID: <7vhby2o6xy.fsf@alter.siamese.dyndns.org>
References: <1245926587-25074-1-git-send-email-giuseppe.bilotta@gmail.com>
	<200906270058.16686.jnareb@gmail.com>
	<cb7bb73a0906261614x3a5dab02h1f29d68b6f5005b1@mail.gmail.com>
	<200906270125.25048.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 27 02:29:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MKLnH-0002Im-2O
	for gcvg-git-2@gmane.org; Sat, 27 Jun 2009 02:29:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753853AbZF0A3N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Jun 2009 20:29:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753464AbZF0A3M
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jun 2009 20:29:12 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:59069 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753339AbZF0A3M (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jun 2009 20:29:12 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090627002914.GKAA20976.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Fri, 26 Jun 2009 20:29:14 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo01.cox.net with bizsmtp
	id 8oVE1c0044aMwMQ03oVEAl; Fri, 26 Jun 2009 20:29:14 -0400
X-VR-Score: -110.00
X-Authority-Analysis: v=1.0 c=1 a=qedoUCQmkU8A:10 a=pGLkceISAAAA:8
 a=VPW9pYw8AAAA:8 a=smv0LlRKKQCf4SFRNCMA:9 a=gxnVsg9yp5aRhlT4uR-ldy0CvHAA:4
 a=fDI1rFJSvNwA:10 a=MSl-tDqOz04A:10
X-CM-Score: 0.00
In-Reply-To: <200906270125.25048.jnareb@gmail.com> (Jakub Narebski's message of "Sat\, 27 Jun 2009 01\:25\:24 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122343>

Jakub Narebski <jnareb@gmail.com> writes:

> I'm not sure if having picons as 'default' for gravatar is a good idea,
> because the rules for resolving picons are complicated[1]... which 
> I didn't realize when writing this (sketch of) idea.
>
> [1] http://www.cs.indiana.edu/picons/ftp/faq.html

Also picons these days look somewhat antiquated with its rather strict
limitation to the colormaps (IIRC, you practically have to go grayscale if
you want to use a real photo), and it would make sense to try gravatar
first and then fall back to picons.
