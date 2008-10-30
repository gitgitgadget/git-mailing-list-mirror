From: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: Re: [StGit PATCH 1/3] stgit.el: Added undo command
Date: Thu, 30 Oct 2008 15:57:38 +0100
Message-ID: <87skqe9llp.fsf@krank.kagedal.org>
References: <20081030095221.10290.58637.stgit@krank>
	<20081030095248.10290.81253.stgit@krank>
	<20081030115716.GA19360@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, catalin marinas <catalin.marinas@gmail.com>
To: Karl =?utf-8?Q?Hasselstr=C3=B6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Thu Oct 30 15:59:07 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvYzJ-0007Jv-Jd
	for gcvg-git-2@gmane.org; Thu, 30 Oct 2008 15:59:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755428AbYJ3O5l convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 30 Oct 2008 10:57:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755365AbYJ3O5k
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Oct 2008 10:57:40 -0400
Received: from mail.lysator.liu.se ([130.236.254.3]:54531 "EHLO
	mail.lysator.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753982AbYJ3O5k (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Oct 2008 10:57:40 -0400
Received: from mail.lysator.liu.se (localhost [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id 2591B40003;
	Thu, 30 Oct 2008 15:57:38 +0100 (CET)
Received: by mail.lysator.liu.se (Postfix, from userid 1674)
	id 1935B40026; Thu, 30 Oct 2008 15:57:38 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.1.7-deb (2006-10-05) on 
	bernadotte.lysator.liu.se
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=5.0 tests=AWL,BAYES_00 autolearn=ham 
	version=3.1.7-deb
Received: from krank (dns.vtab.com [62.20.90.195])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTP id BC9C640003;
	Thu, 30 Oct 2008 15:57:37 +0100 (CET)
Received: by krank (Postfix, from userid 1000)
	id 5498DDC0AB; Thu, 30 Oct 2008 15:57:38 +0100 (CET)
In-Reply-To: <20081030115716.GA19360@diana.vm.bytemark.co.uk> ("Karl
 =?utf-8?Q?Hasselstr=C3=B6m=22's?= message of "Thu\, 30 Oct 2008 12\:57\:16
 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99479>

Karl Hasselstr=C3=B6m <kha@treskal.com> writes:

> On 2008-10-30 10:52:48 +0100, David K=C3=A5gedal wrote:
>
>> Bound it to the two standard bindings C-/ and C-_.
>
>> +  (define-key stgit-mode-map [(control ?/)] 'stgit-undo)
>> +  (define-key stgit-mode-map "\C-_" 'stgit-undo))
>
> Hmm, why do you spell control in two different ways?

I usually use the "\C-x" syntax, but for some reason that didn't work
with "\C-/", so I used another syntax. I'm not sure how compatible
that is with XEmacs, though.

--=20
David K=C3=A5gedal
