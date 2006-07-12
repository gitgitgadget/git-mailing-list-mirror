From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/3] sha1_file: add the ability to parse objects in "pack file format"
Date: Tue, 11 Jul 2006 23:35:41 -0700
Message-ID: <7vzmffz5xe.fsf@assigned-by-dhcp.cox.net>
References: <20060710230132.GA11132@hpsvcnb.fc.hp.com>
	<Pine.LNX.4.64.0607101623230.5623@g5.osdl.org>
	<20060711145527.GA32468@hpsvcnb.fc.hp.com>
	<Pine.LNX.4.64.0607111004360.5623@g5.osdl.org>
	<Pine.LNX.4.64.0607111010320.5623@g5.osdl.org>
	<44B4172B.3070503@stephan-feder.de>
	<Pine.LNX.4.64.0607111449190.5623@g5.osdl.org>
	<7vejwr3ftl.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0607111656250.5623@g5.osdl.org>
	<Pine.LNX.4.63.0607120226210.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.64.0607111755180.5623@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 12 08:35:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G0YKB-0007R6-LN
	for gcvg-git@gmane.org; Wed, 12 Jul 2006 08:35:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751359AbWGLGfu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 12 Jul 2006 02:35:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751361AbWGLGfu
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Jul 2006 02:35:50 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:38547 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1751359AbWGLGft (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Jul 2006 02:35:49 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060712063547.ZEOB18458.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 12 Jul 2006 02:35:47 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0607111755180.5623@g5.osdl.org> (Linus Torvalds's
	message of "Tue, 11 Jul 2006 20:45:31 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23766>

Linus Torvalds <torvalds@osdl.org> writes:

> I shouldn't have introduced the new TYPE_xxx macros. I should just have 
> used the same OBJ_xxx macros that we use in the pack-file.
>
> Junio: this patch is totally independent from the other patches, and is on 
> top of you current "master". It gets rid of TYPE_xxx in favor of the 
> OBJ_xxx enums, which are moved from pack.h into object.h.

You seem to have forgotten one file (fetch-pack.c) but that was
trivial.  I'll apply and push it out shortly.

This might collide with a few topic branches but I have rerere
to help me cope with it ;-).
