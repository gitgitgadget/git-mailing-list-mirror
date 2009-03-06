From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH] git push: Push nothing if no refspecs are given or
 configured
Date: Fri, 06 Mar 2009 02:32:53 -0800
Message-ID: <7v4oy7szze.fsf@gitster.siamese.dyndns.org>
References: <20090305221529.GA25871@pvv.org>
 <fabb9a1e0903051418k3fb6c8baqd0189c772893844e@mail.gmail.com>
 <200903052322.02098.markus.heidelberg@web.de>
 <200903052325.44648.markus.heidelberg@web.de>
 <fabb9a1e0903051426p1222f151s8f466abf319706da@mail.gmail.com>
 <alpine.DEB.1.00.0903061124000.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sverre Rabbelier <srabbelier@gmail.com>, markus.heidelberg@web.de,
	Finn Arne Gangstad <finnag@pvv.org>, git@vger.kernel.org,
	John Tapsell <johnflux@gmail.com>, Andreas Ericsson <ae@op5.se>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Mar 06 11:34:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfXO3-0002ET-A6
	for gcvg-git-2@gmane.org; Fri, 06 Mar 2009 11:34:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753414AbZCFKdL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Mar 2009 05:33:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753059AbZCFKdK
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Mar 2009 05:33:10 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:54821 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752925AbZCFKdJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Mar 2009 05:33:09 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id CED6D9F121;
	Fri,  6 Mar 2009 05:33:04 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id E03029F11F; Fri,
  6 Mar 2009 05:32:54 -0500 (EST)
In-Reply-To: <alpine.DEB.1.00.0903061124000.10279@pacific.mpi-cbg.de>
 (Johannes Schindelin's message of "Fri, 6 Mar 2009 11:24:28 +0100 (CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 2D112BC2-0A3A-11DE-8BE4-CFA5EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112416>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Thu, 5 Mar 2009, Sverre Rabbelier wrote:
>
>> On Thu, Mar 5, 2009 at 23:25, Markus Heidelberg
>> <markus.heidelberg@web.de> wrote:
>> > Oh, I confused "config option" with "command line argument"...
>> 
>> Right, I'd like to be able to do:
>> $ git config push.iamnotretarded true
>> $ git push
>
> LOL!  Sverre, you have a way to crack me up...

I found it amusing, too.

It may have some correlation with how well organized your work habit is,
but I do not think it has much correlation with being retarded.  It is
more about "'matching refs' is the perfect default for _my_ use pattern,
don't mess with it, please".
