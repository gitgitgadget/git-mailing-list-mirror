From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Move all dashed form git commands to libexecdir
Date: Wed, 28 Nov 2007 15:48:45 -0800
Message-ID: <7vr6ia0w4i.fsf@gitster.siamese.dyndns.org>
References: <20071127150229.GA14859@laptop> <20071127160423.GA22807@laptop>
	<Pine.LNX.4.64.0711271617350.27959@racer.site>
	<20071128000731.GD9174@efreet.light.src>
	<7v8x4jb295.fsf@gitster.siamese.dyndns.org>
	<fcaeb9bf0711280036p33583824ge59af93bbe3f0a78@mail.gmail.com>
	<7vfxyq2c9b.fsf@gitster.siamese.dyndns.org>
	<Pine.LNX.4.64.0711282334250.27959@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, Jan Hudec <bulb@ucw.cz>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Nov 29 00:49:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxWel-0003T4-2k
	for gcvg-git-2@gmane.org; Thu, 29 Nov 2007 00:49:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755578AbXK1Xsz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2007 18:48:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755372AbXK1Xsz
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 18:48:55 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:36180 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755211AbXK1Xsy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2007 18:48:54 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 7F88E2EF;
	Wed, 28 Nov 2007 18:49:13 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id E15899AD5B;
	Wed, 28 Nov 2007 18:49:08 -0500 (EST)
In-Reply-To: <Pine.LNX.4.64.0711282334250.27959@racer.site> (Johannes
	Schindelin's message of "Wed, 28 Nov 2007 23:40:07 +0000 (GMT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66467>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> The fundamental problem is that we cannot move handle_internal_command() 
> into libgit.a, because it has pointers to all builtin cmd_*() functions.

What's wrong with having cmd_* functions in the library to begin with?
