From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: What's in a name? Let's use a (uuid,name,email) triplet
Date: Thu, 18 Mar 2010 19:47:16 +0100
Message-ID: <vpq8w9po4az.fsf@bauges.imag.fr>
References: <alpine.LFD.2.00.1003181022040.18017@i5.linux-foundation.org>
	<4ba2293f.c5c2f10a.5e9c.5c4a@mx.google.com>
	<4ba27424.9804cc0a.4b1f.11b1@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 18 19:48:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NsKlG-0001uN-T2
	for gcvg-git-2@lo.gmane.org; Thu, 18 Mar 2010 19:48:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752192Ab0CRSr6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Mar 2010 14:47:58 -0400
Received: from mx1.imag.fr ([129.88.30.5]:47881 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751923Ab0CRSr5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Mar 2010 14:47:57 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id o2IIhh7t006361
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 18 Mar 2010 19:43:43 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1NsKkW-0004sT-ID; Thu, 18 Mar 2010 19:47:16 +0100
In-Reply-To: <4ba27424.9804cc0a.4b1f.11b1@mx.google.com> (Michael Witten's message of "Thu\, 18 Mar 2010 11\:42\:44 -0700 \(PDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 18 Mar 2010 19:43:43 +0100 (CET)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142486>

Michael Witten <mfwitten@gmail.com> writes:

> So, forget the original generality and let's
> define the uuid as a SHA-1 of some EASILY
> REMEMBERED, already reasonably unique piece of
> information such as an old (name,email) pair.

What's the added value of the "SHA-1" thing, here? A hash of a pair
(a, b) is exactly as unique as the pair itself (well, actually even a
bit less if you consider collisions).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
