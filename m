From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: RFC: display dirty submodule working directory in git gui and
 	gitk
Date: Mon, 04 Jan 2010 19:40:51 +0100
Message-ID: <4B423633.6090603@web.de>
References: <4B3F6742.6060402@web.de>	 <alpine.DEB.1.00.1001041038520.4985@pacific.mpi-cbg.de> <fcaeb9bf1001040951r3f797750o5ebd25e93c0272ea@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Paul Mackerras <paulus@samba.org>,
	Heiko Voigt <hvoigt@hvoigt.net>, Lars Hjemli <hjemli@gmail.com>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 04 19:40:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NRrrN-0007Ct-AC
	for gcvg-git-2@lo.gmane.org; Mon, 04 Jan 2010 19:40:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753582Ab0ADSkx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Jan 2010 13:40:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752983Ab0ADSkx
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jan 2010 13:40:53 -0500
Received: from fmmailgate03.web.de ([217.72.192.234]:48363 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752457Ab0ADSkw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jan 2010 13:40:52 -0500
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215])
	by fmmailgate03.web.de (Postfix) with ESMTP id A92F113B58FE9;
	Mon,  4 Jan 2010 19:40:51 +0100 (CET)
Received: from [80.128.60.62] (helo=[192.168.178.26])
	by smtp07.web.de with asmtp (WEB.DE 4.110 #314)
	id 1NRrrH-0000gA-00; Mon, 04 Jan 2010 19:40:51 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.1.5) Gecko/20091204 Thunderbird/3.0
In-Reply-To: <fcaeb9bf1001040951r3f797750o5ebd25e93c0272ea@mail.gmail.com>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX19eftBCUgFfsdUlHDwCEzyRas0S6KsTHRjhLkmo
	eowwz3jqIIciZcB6AVLcK3bUVKuLwF/2Ib3tDWWr3mAMLmVKPN
	I8pCAatfgUQTdtraGnbA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136134>

Am 04.01.2010 18:51, schrieb Nguyen Thai Ngoc Duy:
> Incidentally I was just drafting git-super.sh it see how far it goes.
> The goal was to implement some cross-module operations over time. "git
> super status", "git super commit" and others could be handy.

Hm, i'm not sure if this will really help us. I would rather see "git
status" and friends do the right thing for submodules too. Maybe this
has to be configurable but i think the separate commands that one has
to use for submodules now are part of the usability problems we are
seeing.

IMHO putting the functionality of "git submodule summary" into "git
diff" was a step in the right direction. This thread is about adding a
line to the diff output when diffing against the working directory and
a submodule has a dirty working directory too. Then you can ask "git
diff" and it tells you anything you need to know about the submodule
before committing or checking out in the supermodule (And IMO later on
"git status" should give us this information too).
