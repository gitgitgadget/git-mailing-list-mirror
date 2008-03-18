From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Re* git remote --mirror bug?
Date: Tue, 18 Mar 2008 12:02:59 -0700
Message-ID: <7v4pb37t3w.fsf@gitster.siamese.dyndns.org>
References: <1205499956.7589.4.camel@gentoo-jocke.transmode.se>
 <1205604534.7589.20.camel@gentoo-jocke.transmode.se>
 <7v1w6bj7f9.fsf_-_@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0803181503240.3200@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: joakim.tjernlund@transmode.se, git <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Mar 19 20:45:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jc4C7-0002JK-2M
	for gcvg-git-2@gmane.org; Wed, 19 Mar 2008 20:43:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757433AbYCSTkE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2008 15:40:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757430AbYCSTkD
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Mar 2008 15:40:03 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:49324 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757418AbYCSTkB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2008 15:40:01 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id DF1C11650;
	Tue, 18 Mar 2008 15:03:08 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id BE63D164C; Tue, 18 Mar 2008 15:03:04 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77521>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Sun, 16 Mar 2008, Junio C Hamano wrote:
>
>> Joakim Tjernlund <joakim.tjernlund@transmode.se> writes:
>> 
>> >> git remote show os2kernel 
>> >> * remote os2kernel
>> >>   URL: /usr/local/src/os2kernel
>> >> Warning: unrecognized mapping in remotes.os2kernel.fetch: +refs/*:refs/*
>> 
>> This is very unfortunate.
>>
>> [...]
>>
>>  builtin-check-ref-format.c |    2 +-
>>  git-parse-remote.sh        |    9 +++++++--
>>  remote.c                   |   16 +++++++++++++---
>>  3 files changed, 21 insertions(+), 6 deletions(-)
>
> Thanks for the fix,...

As I alluded to in the message, I do not think this was a fix.
