From: "Mikhail T." <mi+thun@aldan.algebra.com>
Subject: Re: How to fork a file (git cp ?)
Date: Wed, 04 May 2011 21:58:57 -0400
Message-ID: <4DC20461.4090703@aldan.algebra.com>
References: <4DC1934D.6070608@aldan.algebra.com> <4DC19955.7040503@kdbg.org> <7viptqdvrf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 05 03:59:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QHnqZ-0001Ya-ND
	for gcvg-git-2@lo.gmane.org; Thu, 05 May 2011 03:59:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752464Ab1EEB67 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2011 21:58:59 -0400
Received: from smtp03.lnh.mail.rcn.net ([207.172.157.103]:41692 "EHLO
	smtp03.lnh.mail.rcn.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752271Ab1EEB67 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2011 21:58:59 -0400
Received: from mr16.lnh.mail.rcn.net ([207.172.157.36])
  by smtp02.lnh.mail.rcn.net with ESMTP; 04 May 2011 21:58:58 -0400
Received: from smtp01.lnh.mail.rcn.net (smtp01.lnh.mail.rcn.net [207.172.4.11])
	by mr16.lnh.mail.rcn.net (MOS 4.2.3-GA)
	with ESMTP id BBG23787;
	Wed, 4 May 2011 21:58:58 -0400
Received-SPF: None identity=pra; client-ip=209.6.61.133;
  receiver=smtp01.lnh.mail.rcn.net;
  envelope-from="mi+thun@aldan.algebra.com";
  x-sender="mi+thun@aldan.algebra.com";
  x-conformance=sidf_compatible
Received-SPF: None identity=mailfrom; client-ip=209.6.61.133;
  receiver=smtp01.lnh.mail.rcn.net;
  envelope-from="mi+thun@aldan.algebra.com";
  x-sender="mi+thun@aldan.algebra.com";
  x-conformance=sidf_compatible
Received-SPF: None identity=helo; client-ip=209.6.61.133;
  receiver=smtp01.lnh.mail.rcn.net;
  envelope-from="mi+thun@aldan.algebra.com";
  x-sender="postmaster@[192.168.1.8]";
  x-conformance=sidf_compatible
X-Auth-ID: anat
Received: from 209-6-61-133.c3-0.sbo-ubr1.sbo.ma.cable.rcn.com (HELO [192.168.1.8]) ([209.6.61.133])
  by smtp01.lnh.mail.rcn.net with ESMTP; 04 May 2011 21:58:58 -0400
User-Agent: Mozilla/5.0 (X11; U; FreeBSD amd64; uk-UA; rv:1.9.2.12) Gecko/20101114 Thunderbird/3.1.6
In-Reply-To: <7viptqdvrf.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172785>

On 04.05.2011 17:02, Junio C Hamano wrote:
> Well, if you come from the mindset that a "file" has an identity (hence
> there is a distinction between "This file used to be called A and at one
> point was renamed to B which is the name we see today" and "Some time ago
> somebody created a file B with the same contents as A and then removed A
> at the same time"), "copy" would not make much sense.  What identity does
> a new file B gets when you create it by copying from A?
What I want is to signify something like: "This code was obtained from 
that in file A."

"copy" -- of an individual file -- makes just as much sense as "move" 
(rename).

    -mi
