From: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: Re: git-blame.el
Date: Wed, 31 Jan 2007 21:27:47 +0100
Message-ID: <87irenym9o.fsf@morpheus.local>
References: <87iren2vqx.fsf@morpheus.local> <7v64anvu2u.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 31 21:28:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCM3m-0000tV-Ni
	for gcvg-git@gmane.org; Wed, 31 Jan 2007 21:28:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030477AbXAaU17 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 31 Jan 2007 15:27:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030568AbXAaU17
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Jan 2007 15:27:59 -0500
Received: from main.gmane.org ([80.91.229.2]:33124 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030477AbXAaU16 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Jan 2007 15:27:58 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HCM3d-00085N-Ei
	for git@vger.kernel.org; Wed, 31 Jan 2007 21:27:53 +0100
Received: from c83-253-22-207.bredband.comhem.se ([83.253.22.207])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 31 Jan 2007 21:27:53 +0100
Received: from davidk by c83-253-22-207.bredband.comhem.se with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 31 Jan 2007 21:27:53 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: c83-253-22-207.bredband.comhem.se
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (gnu/linux)
Cancel-Lock: sha1:6gRGFfClaUM8tvHsteBNMjIkN54=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38294>

Junio C Hamano <junkio@cox.net> writes:

> I seem to be getting tons of these; wouldn't you want some (require)?

Yeah, I apparently need a (require 'cl)

I try to stay away from cl by habit, but since I usually have it
required by something I use, I might use it without noticing.

So, to try it, add (require 'cl) to the top of the file.

--=20
David K=C3=A5gedal
